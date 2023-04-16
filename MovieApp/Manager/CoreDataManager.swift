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

    func fetchTitleItems() -> [TitleItem] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        do {
            return (try? context.fetch(fetchRequest) as? [TitleItem]) ?? []
        }
    }
    
    func fetchTitleItem(with id: Int64) -> TitleItem? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            let items = try? context.fetch(fetchRequest) as? [TitleItem]
            return items?.first
        }
    }
    
    func updateTitleItem(with title: Title) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        fetchRequest.predicate = NSPredicate(format: "id == %i", title.id)
        do {
            guard let items = try? context.fetch(fetchRequest) as? [TitleItem],
            let item = items.first else { return }
            item.originalTitle = title.originalTitle
            item.posterPath = title.posterPath
        }
        appDelegate.saveContext()
    }


    func deletaAllTitleItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        do {
            let items = try? context.fetch(fetchRequest) as? [TitleItem]
            items?.forEach { context.delete($0) }
        }
        appDelegate.saveContext()
    }

    public func deletaTitleItme(with id: Int64) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TitleItem")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            guard let items = try? context.fetch(fetchRequest) as? [TitleItem],
                  let item = items.first else { return}
            context.delete(item)
        }
        appDelegate.saveContext()
    }
}

