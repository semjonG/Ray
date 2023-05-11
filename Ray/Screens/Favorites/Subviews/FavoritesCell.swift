//
//  FavoritesCell.swift
//  Ray
//
//  Created by mac on 09.05.2023.
//

import UIKit

final class FavoritesCell: UITableViewCell {
  
  static let identifier = "FavoritesCell"
  
  private lazy var favoritesImageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  private lazy var urlLabel: UILabel = {
    let label = UILabel()
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .left
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textColor = .black
    return label
  }()
  
  // MARK: Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Public methods
  func configure(cellModel: FavoritesCellModel) -> Self {
    favoritesImageView.image = cellModel.image
    urlLabel.text = cellModel.imageURL
    return self
  }
  
  // MARK: Private methods
  private func setupViews() {
    selectionStyle = .none
    backgroundColor = .clear
    uiViewBatch([favoritesImageView, urlLabel]) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubviews($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      favoritesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      favoritesImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      favoritesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      favoritesImageView.heightAnchor.constraint(equalToConstant: 84),
      favoritesImageView.widthAnchor.constraint(equalToConstant: 84),
      
      urlLabel.leadingAnchor.constraint(equalTo: favoritesImageView.trailingAnchor, constant: 8),
      urlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      urlLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      urlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
}

