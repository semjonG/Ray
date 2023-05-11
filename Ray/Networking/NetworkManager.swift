//
//  NetworkManager.swift
//  Ray
//
//  Created by mac on 09.05.2023.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {

  static let shared = NetworkManager()
  var lastURLRequest: String?

  private init() {}

  func sendRequest(by text: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    guard let urlString = "https://dummyimage.com/500x500&text=\(text)"
      .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          
            let url = URL(string: urlString) else {
      completionHandler(.failure(NetworkError.incorrectURL))
      return
    }

    lastURLRequest = urlString

    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
      guard let data = data else {
        completionHandler(.failure(NetworkError.fetchDataError))
        return
      }
      completionHandler(.success(data))
    }
    .resume()
  }
}

enum NetworkError: LocalizedError {
  case incorrectURL
  case fetchDataError

  var errorDescription: String? {
    switch self {
    case .incorrectURL:
      return "Incorrect URL"
    case .fetchDataError:
      return "Something went wrong"
    }
  }
}
