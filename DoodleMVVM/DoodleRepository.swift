//
//  DoodleRepository.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/02.
//

import Foundation
import RxSwift

protocol DoodleRepository {
    
}

final class DoodleRepositoryImpl: DoodleRepository {
    func fetchDoodles() -> Observable<[DoodleDTO]> {
        guard let url = URL(string: "https://public.codesquad.kr/jk/doodle.json") else { return Observable.just([]) }
        let urlRequest = URLRequest(url: url)
        return URLSession.shared.rx
            .data(request: urlRequest)
            .decode(type: [DoodleDTO].self, decoder: JSONDecoder())
    }
    
}

final class ImageManager {
    private init() { }
    static let shared = ImageManager()
    func requestImage(url: String) -> Observable<Data> {
        guard let url = URL(string: url) else { return Observable.just(Data()) }
        let urlRequest = URLRequest(url: url)
        return URLSession.shared.rx
            .data(request: urlRequest)
            .catch { error in
                return Observable.just(Data())
            }
    }
}
