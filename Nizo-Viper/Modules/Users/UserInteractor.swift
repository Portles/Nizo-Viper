//
//  Interactor.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import Foundation
import SwiftUI

protocol UserInteractorInputProtocol: AnyObject {
    func getUsers()
}

protocol UserInteractorOutputProtocol: AnyObject {
    func getUsersSuccess(users: [User])
    func getUsersFailure(error: Error?)
}

final class UserInteractor: UserInteractorInputProtocol {
    
    weak var output: UserInteractorOutputProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getUsers() {
        Task {
            do {
                let users: [User] = try await networkManager.getUsers()
                self.output?.getUsersSuccess(users: users)
            } catch {
                self.output?.getUsersFailure(error: error)
            }
        }
    }
}
