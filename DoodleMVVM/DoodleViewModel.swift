//
//  DoodleViewModel.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/02.
//

import RxSwift
import RxRelay
import Foundation

protocol DoodleViewModelProtocol: DoodleViewModelAction, DoodleViewModelState, DoodleViewModelBinding { }

protocol DoodleViewModelAction {
    var viewDidLoad: PublishRelay<Void> { get set }
}

protocol DoodleViewModelState {
    var requestDoodleImages: PublishRelay<[Data]> { get set }
}

protocol DoodleViewModelBinding {
    func action() -> DoodleViewModelAction
    func state() -> DoodleViewModelState
}

final class DoodleViewModel: DoodleViewModelProtocol {
    var viewDidLoad = PublishRelay<Void>()
    
    var requestDoodleImages = PublishRelay<[Data]>()
    
    func action() -> DoodleViewModelAction { self }
    func state() -> DoodleViewModelState { self }
    
    private let repository = DoodleRepositoryImpl()
    private let disposeBag = DisposeBag()
   
    init() {
        let requestDoodles = viewDidLoad
            .flatMap { [unowned self] _ in
                self.repository.fetchDoodles() }
            .share()
        
        requestDoodles.flatMap { doodles -> Observable<[Data]> in
            var imageObservables: [Observable<Data>] = []
            for doodle in doodles {
                imageObservables.append(ImageManager.shared.requestImage(url: doodle.image))
            }
            return Observable.combineLatest(imageObservables)
        }
        .bind(to: requestDoodleImages)
        .disposed(by: disposeBag)
    }
}
