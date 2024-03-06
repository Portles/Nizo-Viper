//
//  MockNetworkManager.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 6.03.2024.
//

import Foundation

final class MockNetworkManager: NetworkManagerProtocol {
    
    var invokedGetUsers: Bool = false
    var invokedGetUsersCount: Int = 0
    var mockUsers: [User]?
    var mockError: Error?
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        invokedGetUsers = true
        invokedGetUsersCount += 1
        if let error = mockError {
            completion(.failure(error))
        } else if let users = mockUsers {
            completion(.success(users))
        } else {
            completion(.failure(NSError(domain: "MockError", code: 0, userInfo: nil)))
        }
    }
}
