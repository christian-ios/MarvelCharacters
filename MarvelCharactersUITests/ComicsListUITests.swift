//
//  ComicsListUITests.swift
//  MarvelCharactersUITests
//
//  Created by Christian Curiel on 6/18/24.
//

import XCTest

final class CharactersListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testFocusOnCharacterListItem() throws {
        let remote: XCUIRemote = XCUIRemote.shared
        let charactersList = app.scrollViews["charactersList"]
        XCTAssertTrue(charactersList.waitForExistence(timeout: 10))
        let first = charactersList.buttons.firstMatch
        XCTAssertTrue(first.waitForExistence(timeout: 5))
        XCUIRemote.shared.press(.select)
        let detailView = app.scrollViews["characterDetailView"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 5))
    }
    
    func testFocusAndLoadMoreCharacters() throws {
        let remote = XCUIRemote.shared
        
        let charactersScrollView = app.scrollViews["charactersList"]
        XCTAssertTrue(charactersScrollView.waitForExistence(timeout: 10))
        
        let initialLastButtonIndex = charactersScrollView.buttons.count - 1
        let initialLastButton = charactersScrollView.buttons.element(boundBy: initialLastButtonIndex)
        XCTAssertTrue(initialLastButton.waitForExistence(timeout: 5))
        
        remote.press(.right, forDuration: 10)
        
        wait(for: 2)
        
        let newLastButtonIndex = charactersScrollView.buttons.count - 1
        XCTAssertTrue(charactersScrollView.buttons.element(boundBy: newLastButtonIndex).waitForExistence(timeout: 10))
        
        XCTAssertTrue(newLastButtonIndex > initialLastButtonIndex, "New characters should be loaded and appended to the list.")
    }
}

extension XCTestCase {
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }
}

