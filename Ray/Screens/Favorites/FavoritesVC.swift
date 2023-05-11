//
//  FavouritesVC.swift
//  Ray
//
//  Created by mac on 09.05.2023.
//

import UIKit

final class FavoritesVC: UIViewController {

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.dataSource = self
    tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  // MARK: Private properties
  private var favoritesCellModel: [FavoritesCellModel] = []
  private let coreDataService: CoreDataManagerProtocol = CoreDataManager.shared
  
  // MARK: Overriden
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchFavorites()
    tableView.reloadData()
  }
  
  // MARK: Private methods
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(tableView)
  }
  
  private func fetchFavorites() {
    favoritesCellModel = coreDataService.fetchFavourites().compactMap { item -> FavoritesCellModel? in
      guard let image = UIImage(data: item.unwrappedImageData) else { return nil }
      return FavoritesCellModel(image: image, imageURL: item.unwrappedImageURL)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }
}

// MARK: UITableViewDataSource
extension FavoritesVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritesCellModel.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier,
                                                   for: indexPath) as? FavoritesCell else { return UITableViewCell()
    }
    return cell.configure(cellModel: favoritesCellModel[indexPath.row])
  }
}

// MARK: UITableViewDelegate
extension FavoritesVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = coreDataService.fetchFavourites()[indexPath.row]
      coreDataService.deleteFromFavorites(item: item)
      favoritesCellModel.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
}
