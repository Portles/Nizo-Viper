//
//  Interactor.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import Foundation

protocol UserInteractorInputProtocol: AnyObject {
    func getUsers()
}

protocol UserInteractorOutputProtocol: AnyObject {
    func getUsersSuccess(users: [User])
    func getUsersFailure(error: Error?)
}

final class UserInteractor: UserInteractorInputProtocol {
    
    weak var output: UserInteractorOutputProtocol?
    
    private let repo: UserRepo
    
    init(repo: UserRepo) {
        self.repo = repo
    }
    
    func getUsers() {
        repo.getUsers(completion: { [weak self] result in
            switch result {
            case .success(let users):
                self?.output?.getUsersSuccess(users: users)
            case .failure(let error):
                self?.output?.getUsersFailure(error: error)
            }
        })
    }
}
