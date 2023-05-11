//
//  CoreDataManager.swift
//  Ray
//
//  Created by mac on 10.05.2023.
//
//

import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
  static let shared = CoreDataManager()
  static let favouriteLimit = 3
  
  // MARK: Private
  private let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Ray")
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Failed to load persistent stores: \(error)")
      }
    }
    return container
  }()
  
  private var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  private init() {}
  
  // MARK: CoreDataManagerProtocol
  func addToFavorites(imageData: Data, imageURL: String) {
    var items = fetchFavourites()
    
    if let existingItem = items.first(where: { $0.imageURL == imageURL }) {
      deleteFromFavorites(item: existingItem)
      items.removeAll { $0.imageURL == imageURL }
    }
    
    if items.count == CoreDataManager.favouriteLimit, let lastItem = items.last {
      deleteFromFavorites(item: lastItem)
    }
    
    let item = CreatedImage(context: context)
    item.imageData = imageData
    item.imageURL = imageURL
    item.addedDate = Date()
    
    context.insert(item)
  }
  
  func deleteFromFavorites(item: CreatedImage) {
    context.delete(item)
  }
  
  func fetchFavourites() -> [CreatedImage] {
    guard let items = try? context.fetch(CreatedImage.fetchRequest()) as? [CreatedImage] else {
      return []
    }
    return items.sorted { $0.unwrappedAddedDate > $1.unwrappedAddedDate }
  }
  
  func saveToContext() throws {
    guard context.hasChanges else {
      return
    }
    
    do {
      try context.save()
    } catch {
      throw error
    }
  }
}
