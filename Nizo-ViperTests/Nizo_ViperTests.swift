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
    
    func test_fetchUsers() {
        XCTAssertEqual(userPresenter.getUserCount, 0)
        userInteractor.mockFetchedUsers = User.mockUsers
        userPresenter.fetchUsers()
        XCTAssertEqual(userPresenter.getUserCount, 2)
    }
    
    func test_clearUsers() {
        userInteractor.mockFetchedUsers = User.mockUsers
        userPresenter.fetchUsers()
        XCTAssertEqual(userPresenter.getUserCount, 10)
        userPresenter.clearUsers()
        XCTAssertEqual(userPresenter.getUserCount, 0)
    }
    
    func test_getUserDataByIndex() {
        var invokedResult: Bool = false
        userInteractor.mockFetchedUsers = User.mockUsers
        userPresenter.fetchUsers()
        if let result = userPresenter.getUserDataByIndex(0) {
            invokedResult = true
            XCTAssertEqual(result, "Nizometto")
        }
        XCTAssertTrue(invokedResult)
    }
    
    func test_notifyViewDidload() {
        XCTAssertFalse(userView.invokedSetupView)
        userPresenter.notifyViewDidload()
        XCTAssertTrue(userView.invokedSetupView)
    }
}
