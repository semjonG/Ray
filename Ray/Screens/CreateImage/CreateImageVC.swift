//
//  CreateImageVC.swift
//  Ray
//
//  Created by mac on 09.05.2023.
//

import UIKit

final class CreateImageVC: UIViewController {
  
  private lazy var textField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Enter some text, please"
    textField.textAlignment = .left
    textField.borderStyle = .roundedRect
    return textField
  }()
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .systemGray.withAlphaComponent(0.3)
    return imageView
  }()
  
  private lazy var createImageButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(createImageButtonPressed), for: .touchUpInside)
    button.setTitle("Create image", for: .normal)
    button.backgroundColor = .systemGreen.withAlphaComponent(0.8)
    button.layer.cornerRadius = 8
    return button
  }()
  
  private lazy var addToFavouritesButton: UIButton = {
    let button = UIButton()
    button.addTarget(self, action: #selector(addToFavouritesButtonPressed), for: .touchUpInside)
    button.setTitle("Add to Favorites", for: .normal)
    button.backgroundColor = .systemPink.withAlphaComponent(0.8)
    button.layer.cornerRadius = 8
    button.accessibilityIdentifier = "addToFavouriteButton"
    button.isHidden = true
    return button
  }()
  
  // MARK: Private properties
  private let networkManager: NetworkManagerProtocol = NetworkManager.shared
  private let coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
  
  
  // MARK: Overriden
  override func viewDidLoad() {
    super.viewDidLoad()
    setupGestures()
    setupViews()
    setupConstraints()
  }
  
  // MARK: Private methods, Actions
  @objc private func createImageButtonPressed() {
    createImage()
  }
  
  @objc private func addToFavouritesButtonPressed() {
    
    guard let lastGeneratedImageData = imageView.image?.pngData(),
          let lastRequestURL = networkManager.lastURLRequest?.removingPercentEncoding else { return }
    
    coreDataManager.addToFavorites(imageData: lastGeneratedImageData, imageURL: lastRequestURL)
    
    let addedToFavoritesAlert = UIAlertController(title: "Added to favorites",
                                                  message: nil,
                                                  preferredStyle: .alert)
    
    let okButton = UIAlertAction(title: "Ok", style: .cancel)
    addedToFavoritesAlert.addAction(okButton)
    present(addedToFavoritesAlert, animated: true)
  }
  
  private func createImage() {
    imageView.image = nil
    addToFavouritesButton.isHidden = true
    
    networkManager.sendRequest(by: textField.text ?? "", completionHandler: { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let imageData):
          let image = UIImage(data: imageData)
          
          if image != nil {
            self?.imageView.image = image
            self?.addToFavouritesButton.isHidden = false
            return
          }
          
        case .failure(let error):
          let errorAlert = UIAlertController(title: "Something went wrong",
                                             message: error.localizedDescription,
                                             preferredStyle: .alert)
          
          let okButton = UIAlertAction(title: "Ok", style: .cancel)
          errorAlert.addAction(okButton)
          self?.present(errorAlert, animated: true)
        }
      }
    }
    )
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
  
  private func setupGestures() {
    let anyPlaceTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(anyPlaceTap)
  }
  
  private func setupViews() {
    view.backgroundColor = .clear
    uiViewBatch([textField, imageView, createImageButton, addToFavouritesButton]) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubviews($0)
    }
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      textField.heightAnchor.constraint(equalToConstant: 46),
      
      imageView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
      imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
      
      createImageButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
      createImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      createImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      createImageButton.heightAnchor.constraint(equalToConstant: 48),
      
      addToFavouritesButton.topAnchor.constraint(equalTo: createImageButton.bottomAnchor, constant: 18),
      addToFavouritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      addToFavouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      addToFavouritesButton.heightAnchor.constraint(equalToConstant: 48)
    ])
  }
}
