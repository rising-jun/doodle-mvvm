//
//  DoodleMVVMTests.swift
//  DoodleMVVMTests
//
//  Created by 김동준 on 2022/08/02.
//

import XCTest
@testable import DoodleMVVM

class DoodleRepositoryTest: XCTestCase {

    var doodleRepository: DoodleRepository!
    
    func test_doodleRepository일때_fetchDoodles호출하여_성공하고_틀린JSON값이오면_failure가호출된다() throws {
        //give
        doodleRepository = DoodleRepositoryStub()
        
        let didFinish = expectation(description: #function)
        var result: Bool = false
        
        //when
        let doodleObservable = doodleRepository.fetchDoodles()
        
        doodleObservable.subscribe { doodles in
            if !doodles.isEmpty {
                result = true
            }
            didFinish.fulfill()
        } onError: { error in
            XCTFail()
        }
        wait(for: [didFinish], timeout: 1.0)
        
        // then
        XCTAssertEqual(result, true)
    }
}
