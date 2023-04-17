import Combine

enum FavoriteEvent {
    case didLoadPreview(TitlePreviewViewModel)
}

enum FavoriteAction {
    case fetchPreview(TitleItem)
}

final class FavoriteStore: Store<FavoriteEvent, FavoriteAction> {
    override func handleActions(action: FavoriteAction) {
        switch action {
        case let .fetchPreview(item):
            statefulCall {
                await self.fetchPreview(item: item)
            }
        }
    }
    
    private func fetchPreview(item: TitleItem) async {
        do {
            let name = (item.originalName ?? item.originalTitle) ?? ""
            let video = try await APICaller.shared.getMovie(with: name)
            let titlePreview = TitlePreviewViewModel(item: item, video: video)
            sendEvent(.didLoadPreview(titlePreview))
        } catch {}
    }
}
