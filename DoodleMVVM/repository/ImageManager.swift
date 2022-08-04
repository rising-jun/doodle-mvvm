//
//  ImageManager.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/04.
//

import Foundation
import RxSwift

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
