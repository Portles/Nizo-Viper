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
    private var networkManager: MockNetworkManager!
    private var userPresenter: UserPresenterProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        userRouter = MockUserRouter()
        userInteractor = MockUserInteractor()
        userView = MockUserView()
        networkManager = MockNetworkManager()
        userPresenter = UserPresenter(view: userView, router: userRouter, interactor: userInteractor)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        userRouter = nil
        userInteractor = nil
        userView = nil
        networkManager = nil
        userPresenter = nil
    }
    
    // ZORT
    func test_fetchUsers() {
        userPresenter.fetchUsers()
    }
    
    // ZORT
    func test_clearUsers() {
        userPresenter.fetchUsers()
        userPresenter.clearUsers()
        XCTAssertEqual(userPresenter.getUserCount, 0)
    }
    
    // ZORT
    func test_getUserDataByIndex() {
        var invokedResult: Bool = false
        userPresenter.fetchUsers()
        if let result = userPresenter.getUserDataByIndex(0) {
            invokedResult = true
            XCTAssertEqual(result, "")
        }
        XCTAssertTrue(invokedResult)
    }
    
    func test_setupView() {
        XCTAssertFalse(userView.invokedSetupView)
        XCTAssertEqual(userView.invokedSetupViewCount, 0)
        
        userView.setupView()
        
        XCTAssertTrue(userView.invokedSetupView)
        XCTAssertEqual(userView.invokedSetupViewCount, 1)
    }
    
    func test_reloadTable() {
        XCTAssertFalse(userView.invokedReloadTable)
        XCTAssertEqual(userView.invokedReloadTableCount, 0)
        
        userView.reloadTable()
        
        XCTAssertTrue(userView.invokedReloadTable)
        XCTAssertEqual(userView.invokedReloadTableCount, 1)
    }
    
    func test_changeTableVisibility_true() {
        let hiddenState: Bool = true
        XCTAssertFalse(userView.invokedChangeTableVisibility)
        XCTAssertEqual(userView.invokedChangeTableVisibilityCount, 0)
        XCTAssertEqual(userView.tableViewHiddenState, false)
        
        userView.changeTableVisibility(hiddenState)
        
        XCTAssertTrue(userView.invokedChangeTableVisibility)
        XCTAssertEqual(userView.invokedChangeTableVisibilityCount, 1)
        XCTAssertEqual(userView.tableViewHiddenState, hiddenState)
    }
    
    func test_changeTableVisibility_false() {
        let hiddenState: Bool = false
        XCTAssertFalse(userView.invokedChangeTableVisibility)
        XCTAssertEqual(userView.invokedChangeTableVisibilityCount, 0)
        XCTAssertEqual(userView.tableViewHiddenState, false)
        userView.changeTableVisibility(hiddenState)
        XCTAssertTrue(userView.invokedChangeTableVisibility)
        XCTAssertEqual(userView.invokedChangeTableVisibilityCount, 1)
        XCTAssertEqual(userView.tableViewHiddenState, hiddenState)
    }
    
    func test_notifyViewDidload() {
        XCTAssertFalse(userView.invokedSetupView)
        userPresenter.notifyViewDidload()
        XCTAssertTrue(userView.invokedSetupView)
    }
    
    func test_networkGetUsersSuccessfull() {
        networkManager.mockUsers = User.mockUsers
        XCTAssertFalse(networkManager.invokedGetUsers)
        XCTAssertEqual(networkManager.invokedGetUsersCount, 0)
        
        let expectation = self.expectation(description: "SuccessFetchUsers")
        
        networkManager.getUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, self.networkManager.mockUsers?.count, "Kullanıcı sayısı eşleşmiyor.")
            case .failure(let error):
                XCTFail("\(error)")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(networkManager.invokedGetUsers)
        XCTAssertEqual(networkManager.invokedGetUsersCount, 1)
    }
    
    func testGetUsersNetworkError() {
        let errorToReturn = NSError(domain: "NetworkError", code: -1009, userInfo: nil)
        networkManager.mockError = errorToReturn
        
        let expectation = self.expectation(description: "FailureFetchUsers")
        
        networkManager.getUsers { result in
            switch result {
            case .success(_):
                XCTFail("GetUsers Networking error.")
            case .failure(let error):
                XCTAssertEqual(error as NSError, errorToReturn, "GetUsers Networking error but different one")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetUsersDecodingError() {
        XCTAssertFalse(networkManager.invokedGetUsers)
        XCTAssertEqual(networkManager.invokedGetUsersCount, 0)
        networkManager.mockError = DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Test Decoding Error"))
        
        let expectation = self.expectation(description: "DecodingError")
        
        networkManager.getUsers { result in
            switch result {
            case .success(_):
                XCTFail("GetUsers Decoding error.")
            case .failure(let error):
                XCTAssertTrue(error is DecodingError, "GetUsers Decoding error but different one.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertTrue(networkManager.invokedGetUsers)
        XCTAssertEqual(networkManager.invokedGetUsersCount, 1)
    }
}
