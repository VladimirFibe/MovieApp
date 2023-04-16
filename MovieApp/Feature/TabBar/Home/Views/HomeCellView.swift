import SwiftUI
import Kingfisher
typealias HomeCell = BridgingRestrictedTableViewCell<HomeCellView>
struct HomeCellView: View {
    let title: Title
    @State private var liked = false
    var body: some View {
        HStack {
            KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(title.posterPath)"))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("Action")
                    .font(.body)
                    .foregroundColor(.secondary)
                Spacer(minLength: 0)
                Text(title.originalTitle)
                    .font(.title)
                    .lineLimit(1)
                Spacer(minLength: 0)

                HStack {
                    Label("148 min", systemImage: "clock")
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4.4")
                        .foregroundColor(.yellow)
                    Text("(52)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            
        }
        .overlay(
            Button(action: {
                if let item = CoreDataMamanager.shared.fetchTitleItem(with: Int64(title.id)) {
                    CoreDataMamanager.shared.deletaTitleItme(with: item.id)
                } else {
                    CoreDataMamanager.shared.createTitle(title)
                }
                liked.toggle()
            }) {
                Image(systemName: liked ? "heart.fill" : "heart")
            }
                 , alignment: .topTrailing)
        .padding(8)
        .onAppear {
            liked = CoreDataMamanager.shared.fetchTitleItem(with: Int64(title.id)) != nil
        }
    }

}

struct HomeCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCellView(title: Title(adult: true, genreIds: [], id: 1, originalTitle: "ghbdfsafd", posterPath: "/cvsXj3I9Q2iyyIo95AecSd1tad7.jpg"))
    }
}
