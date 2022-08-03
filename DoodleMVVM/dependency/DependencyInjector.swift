//
//  DependencyInjector.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/03.
//

import Foundation
import EbonyDependencyKit

final class DependencyInjector: DependencyInjectable {
    static var dependencyDictionary: [ObjectIdentifier : Any] = [ObjectIdentifier(DoodleViewController.self): DoodleDependency(viewModel: DoodleViewModel(repository: DoodleRepositoryImpl()))]
    
    static func injecting<T: DependencySetable>(to compose: T){
        guard let dependency = dependencyDictionary[ObjectIdentifier(type(of: compose.self))] as? T.DependencyType else {
            return
        }
        compose.setDependency(dependency: dependency)
    }
}
