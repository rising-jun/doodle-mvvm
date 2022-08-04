//
//  DoodleViewModelStub.swift
//  DoodleMVVMTests
//
//  Created by 김동준 on 2022/08/03.
//

import RxSwift
import RxRelay
@testable import DoodleMVVM

final class DoodleViewModelStub: DoodleViewModelProtocol {
    var viewDidLoad = PublishRelay<Void>()
    var requestDoodleImages = PublishRelay<[Data]>()
    
    func action() -> DoodleViewModelAction { self }
    func state() -> DoodleViewModelState { self }
    
    private var repository: DoodleRepository
    private let disposeBag = DisposeBag()
   
    init(repository: DoodleRepository) {
        self.repository = repository
        
        viewDidLoad
            .flatMap { [weak self] _ -> Observable<[DoodleDTO]> in
                guard let self = self else { return Observable.just([])}
                return self.repository.fetchDoodles() }
            .flatMap { doodles -> Observable<[Data]> in
            var imageObservables: [Observable<Data>] = []
            for doodle in doodles {
                imageObservables.append(Observable.just(Data()))
            }
            return Observable.combineLatest(imageObservables)
        }
        .bind(to: requestDoodleImages)
        .disposed(by: disposeBag)
    }
}
