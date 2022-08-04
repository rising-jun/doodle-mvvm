//
//  DoodleRepositoryImpl.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/04.
//

import Foundation
import RxSwift

final class DoodleRepositoryImpl: DoodleRepository {
    func fetchDoodles() -> Observable<[DoodleDTO]> {
        guard let url = URL(string: "https://public.codesquad.kr/jk/doodle.json") else { return Observable.just([]) }
        let urlRequest = URLRequest(url: url)
        return URLSession.shared.rx
            .data(request: urlRequest)
            .decode(type: [DoodleDTO].self, decoder: JSONDecoder())
    }
}
