//
//  NetworkManagerUnitTests.swift
//  NetworkManagerUnitTests
//
//  Created by mac on 11.05.2023.
//

import XCTest
@testable import Ray

///Предназначен для класса NetworkManager.
///Этот тест проверяет, что при вызове sendRequest с некоторым текстом, вызывается обработчик завершения, и что возвращенный результат содержит данные. Он также проверяет, что нет ошибок в обработчике завершения.
final class NetworkManagerUnitTests: XCTestCase {

  func testSendRequest() {
      // given
      let networkManager = NetworkManager.shared
      let text = "test"
      let expectation = XCTestExpectation(description: "Completion handler called")
      
      // when
      networkManager.sendRequest(by: text) { result in
        // then
        switch result {
        case .success(let data):
          XCTAssertNotNil(data)
          expectation.fulfill()
        case .failure(let error):
          XCTFail("Unexpected error: \(error.localizedDescription)")
        }
      }
      wait(for: [expectation], timeout: 5.0)
    }

}
