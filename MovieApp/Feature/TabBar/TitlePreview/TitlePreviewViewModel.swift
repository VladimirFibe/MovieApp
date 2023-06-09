import Foundation

struct TitlePreviewViewModel {
    let title: String
    let overview: String
    let youtube: String
    
    init(title: Title, video: VideoElement) {
        self.title = title.originalTitle
        overview = "no overview"
        youtube = "https://www.youtube.com/embed/\(video.id.videoId)"
    }
    
    init(item: TitleItem, video: VideoElement) {
        self.title = (item.originalName ?? item.originalTitle) ?? "no name"
        overview = item.overview ?? "no overview"
        youtube = "https://www.youtube.com/embed/\(video.id.videoId)"
    }
}
