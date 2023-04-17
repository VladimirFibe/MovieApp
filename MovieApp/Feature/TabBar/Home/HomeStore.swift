import Combine

enum HomeEvent {
    case didLoadPreview(TitlePreviewViewModel)
    case didLoad([Title])
}

enum HomeAction {
    case fetch
    case fetchPreview(Title)
}

final class HomeStore: Store<HomeEvent, HomeAction> {
    override func handleActions(action: HomeAction) {
        switch action {
        case .fetch:
            statefulCall(fetch)
        case let .fetchPreview(title):
            statefulCall {
                await self.fetchPreview(title: title)
            }
        }
    }
    
    private func fetch() async throws {
        let response = try await APICaller.shared.getTopRated()
        sendEvent(.didLoad(response.results))
    }
    
    private func fetchPreview(title: Title) async {
        do {
            let video = try await APICaller.shared.getMovie(with: title.originalTitle)
            let titlePreview = TitlePreviewViewModel(title: title, video: video)
            sendEvent(.didLoadPreview(titlePreview))
        } catch {}
    }
}
