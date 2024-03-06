//
//  MockUserView.swift
//  Nizo-Viper
//
//  Created by Nizamet Özkan on 5.03.2024.
//

import UIKit

final class MockUserView: UserViewProtocol {
    
    var invokedSetupView: Bool = false
    var invokedSetupViewCount: Int = 0
    
    func setupView() {
        invokedSetupView = true
        invokedSetupViewCount += 1
    }
    
    var invokedReloadTable: Bool = false
    var invokedReloadTableCount: Int = 0
    
    func reloadTable() {
        invokedReloadTable = true
        invokedReloadTableCount += 1
    }
    
    var invokedChangeTableVisibility: Bool = false
    var invokedChangeTableVisibilityCount: Int = 0
    var tableViewHiddenState: Bool = false
    
    func changeTableVisibility(_ isHidden: Bool) {
        invokedChangeTableVisibility = true
        invokedChangeTableVisibilityCount += 1
        tableViewHiddenState = isHidden
    }
}
