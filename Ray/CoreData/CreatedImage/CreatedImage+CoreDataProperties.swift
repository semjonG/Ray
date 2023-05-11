//
//  CreatedImage+CoreDataProperties.swift
//  Ray
//
//  Created by mac on 10.05.2023.
//
//

import Foundation
import CoreData


extension CreatedImage {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CreatedImage> {
    return NSFetchRequest<CreatedImage>(entityName: "CreatedImage")
  }
  
  @NSManaged public var addedDate: Date?
  @NSManaged public var imageData: Data?
  @NSManaged public var imageURL: String?
  
  var unwrappedImageData: Data {
    return imageData ?? Data()
  }
  
  var unwrappedImageURL: String {
    return imageURL ?? ""
  }
  
  var unwrappedAddedDate: Date {
    return addedDate ?? Date()
  }
  
}
