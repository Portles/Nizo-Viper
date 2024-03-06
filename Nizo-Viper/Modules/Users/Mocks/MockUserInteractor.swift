//
//  MockUserInteractor.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 5.03.2024.
//

import Foundation

final class MockUserInteractor: UserInteractorInputProtocol {
    
    var invokedGetUsers: Bool = false
    var invokedGetUsersCount: Int = 0
    
    func getUsers() {
        invokedGetUsers = true
        invokedGetUsersCount += 1
    }
}
