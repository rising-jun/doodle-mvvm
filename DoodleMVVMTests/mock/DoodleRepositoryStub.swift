//
//  DoodleRepositoryStub.swift
//  DoodleMVVMTests
//
//  Created by 김동준 on 2022/08/03.
//

import RxSwift
@testable import DoodleMVVM

final class DoodleRepositoryStub: DoodleRepository {
    func fetchDoodles() -> Observable<[DoodleDTO]> {
        return Observable.just(TestUtil.loadJSON("MockDoodles")!)
            .decode(type: [DoodleDTO].self, decoder: JSONDecoder())
    }
}
