//
//  NetworkManagerProtocol.swift
//  Ray
//
//  Created by mac on 11.05.2023.
//

import Foundation

protocol NetworkManagerProtocol {
  func sendRequest(by text: String, completionHandler: @escaping (Result<Data, Error>) -> Void)
  var lastURLRequest: String? { get }
}
