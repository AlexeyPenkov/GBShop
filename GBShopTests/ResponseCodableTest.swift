//
//  ResponseCodableTest.swift
//  GBShopTests
//
//  Created by Алексей Пеньков on 14.01.2022.
//
import Alamofire
import XCTest
@testable import GBShop


class ResponseCodableTest: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Download https://failUrl")
    var errorParser: ErrorParserStub!

    override func setUpWithError() throws {
        try super.setUpWithError()
        errorParser = ErrorParserStub()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        errorParser = nil
    }

    func testShouldDownloadAndParse() {
        AF
            .request("https://failUrl")
            .responceCodable(errorParser: errorParser) { [weak self] (response: DataResponse<PostStub>) in
                switch response.result {
                case .success(_): break
                case .failure(): XCTFail()
                }
                self?.expectation.fulfill()
            }
        wait(for: [expectation], timeout: 10.0)
    }

}
