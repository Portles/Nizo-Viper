//
//  Presenter.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol UserPresenterProtocol {
    func fetchUsers()
    func clearUsers()
    func getUserDataByIndex(_ index: Int) -> String?
    func notifyViewDidload()
    var getUserCount: Int { get }
}

final class UserPresenter {
    private weak var view: UserViewProtocol?
    private weak var router: UserRouterProtocol?
    var interactor: UserInteractorProtocol? {
        didSet {
            fetchUsers()
        }
    }
    
    var users: [User] = []
    
    init(view: UserViewProtocol?, router: UserRouterProtocol?, interactor: UserInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension UserPresenter: UserPresenterProtocol {
    var getUserCount: Int {
        users.count
    }
    
    func getUserDataByIndex(_ index: Int) -> String? {
        return users[index].name
    }
    
    func notifyViewDidload() {
        view?.setupView()
        fetchUsers()
    }
    
    func fetchUsers() {
        interactor?.getUsers(completion: { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                DispatchQueue.main.async {
                    self?.view?.reloadTable()
                    self?.view?.changeTableVisibility(false)
                }
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
    
    func clearUsers() {
        self.users = []
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
            self?.view?.changeTableVisibility(true)
        }
    }
}
