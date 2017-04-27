//
//  CbcRssTests.swift
//  CbcRssTests
//
//  Created by Valeriy Kliuk on 2017-04-26.
//  Copyright © 2017 Valeriy Kliuk. All rights reserved.
//

import XCTest
import Alamofire
import SwiftyXMLParser

@testable import CbcRss

class CbcRssTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /// to test connection with the CBC web site
    func testCBC() -> Void {
        let exp = expectation(description: "Alamofire")
        
        Alamofire.request(Helper.shared.requestLink)
            .validate(statusCode: 200..<300)
            .responseData { response in
                // Custom validation
                switch response.result {
                case .success:
                    print("Validation Successful")
                    if let data = response.data {
                        let xml = XML.parse(data)
                        
                        var items: [RSSItem] = []
                        
                        for item in xml["rss", "channel", "item"] {
                            // Create a new RSS Item
                            let i = RSSItem(title: item["title"].text!,
                                            author: item["author"].text!,
                                            pubDate: item["pubDate"].text!,
                                            imgLink: Utils.getImageURL(string: item["description"].text!, start: "<img src='", end: ".jpg"),
                                            link: item["link"].text!)
                            // add item to array
                            items.append(i)
                            
                            print(i.title)
                            print(i.author)
                            print(i.pubDate)
                            print(i.imgLink)
                            print(i.link)
                            print("---")
                        }
                        XCTAssertEqual(20, items.count, "Should be 20")
                    }
                    exp.fulfill()
                case .failure(let error):
                    print(error)
                    XCTAssertNil(error, "Whoops, error \(error)")
                    exp.fulfill()
                }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
