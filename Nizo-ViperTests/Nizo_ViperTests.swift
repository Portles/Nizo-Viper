//
//  Nizo_ViperTests.swift
//  Nizo-ViperTests
//
//  Created by Nizamet Özkan on 3.03.2024.
//

import XCTest
@testable import Nizo_Viper

final class Nizo_ViperTests: XCTestCase {

    private var userRouter: MockUserRouter!
    private var userInteractor: MockUserInteractor!
    private var userView: MockUserView!
    private var userPresenter: UserPresenterProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userRouter = MockUserRouter()
        userInteractor = MockUserInteractor()
        userView = MockUserView()
        userPresenter = UserPresenter(view: userView, router: userRouter, interactor: userInteractor)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        userRouter = nil
        userInteractor = nil
        userView = nil
        userPresenter = nil
    }
}
