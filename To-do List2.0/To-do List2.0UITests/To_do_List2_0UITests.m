//
//  To_do_List2_0UITests.m
//  To-do List2.0UITests
//
//  Created by lxh_miao on 16/7/9.
//  Copyright © 2016年 lxh_miao. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface To_do_List2_0UITests : XCTestCase

@end

@implementation To_do_List2_0UITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *enterTasksHereTextField = app.textFields[@"Enter tasks here"];
    [enterTasksHereTextField tap];
    [enterTasksHereTextField typeText:@"q"];
    
    XCUIElement *insertButton = app.buttons[@"Insert"];
    [insertButton tap];
    [enterTasksHereTextField tap];
    [enterTasksHereTextField typeText:@"a"];
    [insertButton tap];
    
    XCUIElementQuery *toolbarsQuery = app.toolbars;
    XCUIElement *deleteButton = toolbarsQuery.buttons[@"Delete"];
    [deleteButton tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.cells.buttons[@"Delete q"] tap];
    [tablesQuery.cells.buttons[@"Delete"] tap];
    [deleteButton tap];
    [toolbarsQuery.buttons[@"Clear"] tap];
    [app.alerts[@"Delete all tasks or not"].collectionViews.buttons[@"OK"] tap];
    
}

@end
