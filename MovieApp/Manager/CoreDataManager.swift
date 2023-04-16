import UIKit
import CoreData

// MARK: - CRUD
public final class CoreDataMamanager: NSObject {
    
    enum DatabasError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = CoreDataMamanager()
    private override init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func createTitle(_ title: Title) {
        guard let titleItemDescription = NSEntityDescription.entity(forEntityName: "TitleItem", in: context)
        else { return }
        let item = TitleItem(entity: titleItemDescription, insertInto: context)
        item.id = Int64(title.id)
        item.originalTitle = title.originalTitle
        item.posterPath = title.posterPath
        appDelegate.saveContext()
    }

//    public func createPhoto(_ id: Int16, title: String, url: String?) {
//        guard let photoEntityDescription = NSEntityDescription.entity(forEntityName: "TitleItem", in: context) else {
//            return
//        }
//        let photo = TitleItem(entity: photoEntityDescription, insertInto: context)
//        photo.id = id
//        photo.title = title
//        photo.url = url
//
//        appDelegate.saveContext()
//    }
//
//    public func fetchPhotos() -> [Photo] {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        do {
//            return (try? context.fetch(fetchRequest) as? [Photo]) ?? []
//        }
//    }
//
//    public func fetchPhoto(with id: Int16) -> Photo? {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//        do {
//            let photos = try? context.fetch(fetchRequest) as? [Photo]
//            return photos?.first
//        }
//    }
//
//    public func updataPhoto(with id: Int16, newUrl: String, title: String? = nil) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//        do {
//            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
//                  let photo = photos.first else { return }
//            photo.url = newUrl
//            photo.title = title
//        }
//
//        appDelegate.saveContext()
//    }
//
//    public func deletaAllPhoto() {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        do {
//            let photos = try? context.fetch(fetchRequest) as? [Photo]
//            photos?.forEach { context.delete($0) }
//        }
//
//        appDelegate.saveContext()
//    }
//
//    public func deletaPhoto(with id: Int16) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photo")
//        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
//        do {
//            guard let photos = try? context.fetch(fetchRequest) as? [Photo],
//                  let photo = photos.first else { return}
//            context.delete(photo)
//        }
//
//        appDelegate.saveContext()
//    }
}

