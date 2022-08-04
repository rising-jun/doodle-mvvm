//
//  DoodleViewModel.swift
//  DoodleMVVMTests
//
//  Created by 김동준 on 2022/08/03.
//

import XCTest
import RxSwift
import RxRelay
import RxTest

@testable import DoodleMVVM

class DoodleViewModelTest: XCTestCase {

    var viewModel: DoodleViewModelProtocol!
    let disposeBag = DisposeBag()
    
    func test_doodleViewModel일때_viewDidLoad호출하여_성공하고_error가_발생하면_failure가호출된다() throws {
        //give
        let scheduler = TestScheduler(initialClock: 0)
        viewModel = DoodleViewModelStub(repository: DoodleRepositoryStub())
        let observer = scheduler.createObserver(Bool.self)

        //when
        viewModel.state()
            .requestDoodleImages
            .map { ($0.count > 0) }
            .bind(to: observer)
            .disposed(by: disposeBag)
            
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.action().viewDidLoad)
            .disposed(by: disposeBag)
        
        scheduler.start()
        // then
        XCTAssertEqual(observer.events, [.next(10, true)])
    }
}
