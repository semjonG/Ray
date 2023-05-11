//
//  CoreDataManagerProtocol.swift
//  Ray
//
//  Created by mac on 11.05.2023.
//

import Foundation

protocol CoreDataManagerProtocol {
  func addToFavorites(imageData: Data, imageURL: String)
  func deleteFromFavorites(item: CreatedImage)
  func fetchFavourites() -> [CreatedImage]
  func saveToContext() throws
}
