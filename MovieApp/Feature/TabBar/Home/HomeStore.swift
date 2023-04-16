import Combine

enum HomeEvent {
    case didLoad([Title])
}

enum HomeAction {
    case fetch
}

final class HomeStore: Store<HomeEvent, HomeAction> {
    override func handleActions(action: HomeAction) {
        switch action {
        case .fetch:
            statefulCall(fetch)
        }
    }
    
    private func fetch() async throws {
        let response = try await APICaller.shared.getTopRated()
        sendEvent(.didLoad(response.results))
    }
}
/*
 
 Task {
     do {
         let title = titles[indexPath.row]
         let name = title.originalTitle
         print(name)
         let video = try await APICaller.shared.getMovie(with: name)
         print(video)
         DispatchQueue.main.async {
             let controller = TitlePreviewViewController()
             controller.configure(with: TitlePreviewViewModel(title: title, video: video))
             self.navigationController?.pushViewController(controller, animated: true)
         }
     } catch {
         print(error.localizedDescription)
     }
 }
 
 */
