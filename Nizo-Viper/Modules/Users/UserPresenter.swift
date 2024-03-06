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

protocol UserPresenterProtocol: AnyObject {
    func fetchUsers()
    func clearUsers()
    func getUserDataByIndex(_ index: Int) -> String?
    func notifyViewDidload()
    var getUserCount: Int { get }
}

final class UserPresenter {
    private weak var view: UserViewProtocol?
    private weak var router: UserRouterProtocol?
    private var interactor: UserInteractorInputProtocol? {
        didSet {
            fetchUsers()
        }
    }
    private var users: [User]?
    
    init(view: UserViewProtocol?, router: UserRouterProtocol?, interactor: UserInteractorInputProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension UserPresenter: UserPresenterProtocol {
    var getUserCount: Int {
        users?.count ?? 0
    }
    
    func getUserDataByIndex(_ index: Int) -> String? {
        users?[index].name ?? ""
    }
    
    func notifyViewDidload() {
        view?.setupView()
        fetchUsers()
    }
    
    func fetchUsers() {
        interactor?.getUsers()
    }
    
    func clearUsers() {
        self.users = []
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
            self?.view?.changeTableVisibility(true)
        }
    }
}

extension UserPresenter: UserInteractorOutputProtocol {
    func getUsersSuccess(users: [User]) {
        self.users = users
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadTable()
            self?.view?.changeTableVisibility(false)
        }
    }
    
    func getUsersFailure(error: Error?) {
        debugPrint(error?.localizedDescription as? String ?? "Some errors")
    }
}
