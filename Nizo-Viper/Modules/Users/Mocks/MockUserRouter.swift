//
//  MockUserRouter.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 5.03.2024.
//

import Foundation

final class MockUserRouter: UserRouterProtocol {
    
    var invokedPopView: Bool = false
    var invokedPopViewCount: Int = 0
    
    func popView() {
        invokedPopView = true
        invokedPopViewCount += 1
    }
}
