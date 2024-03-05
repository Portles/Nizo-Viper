//
//  Router.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import UIKit

protocol UserRouterProtocol: AnyObject {
    func popView()
}

final class UserRouter: UserRouterProtocol {
    private weak var navigationController: UINavigationController?
    
    static func createModule(using navigationController: UINavigationController) -> UserViewController {
        let router: UserRouter = UserRouter()
        let view: UserViewController = UserViewController()
        let repo: UserRepo = UserRepo()
        let interactor: UserInteractor = UserInteractor(repo: repo)
        let presenter: UserPresenter = UserPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.output = presenter
        router.navigationController = navigationController
        
        return view
    }
}

extension UserRouter {
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}
