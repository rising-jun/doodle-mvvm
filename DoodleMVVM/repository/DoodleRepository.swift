//
//  DoodleRepository.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/02.
//

import Foundation
import RxSwift

protocol DoodleRepository {
    func fetchDoodles() -> Observable<[DoodleDTO]>
}
