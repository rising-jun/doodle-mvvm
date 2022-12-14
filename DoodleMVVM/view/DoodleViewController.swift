//
//  ViewController.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/02.
//

import RxAppState
import RxSwift
import SnapKit
import EbonyDependencyKit

struct DoodleDependency: Dependency {
    typealias ManagerType = DoodleViewModelProtocol
    var viewModel: DoodleViewModelProtocol
}

final class DoodleViewController: UIViewController, DependencySetable {
    var dependency: DoodleDependency? {
        didSet { self.viewModel = dependency?.viewModel }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        DependencyInjector.injecting(to: self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let disposeBag = DisposeBag()
    var viewModel: DoodleViewModelProtocol?
    
    private let flowlayout: UICollectionViewFlowLayout = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSize(width: 90, height: 90)
        return flowlayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.id)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
}

extension DoodleViewController {
    private func bind() {
        guard let viewModel = viewModel else { return }
        rx.viewWillAppear
            .map { _ in return () }
            .bind(to: viewModel.action().viewDidLoad)
            .disposed(by: disposeBag)
        
        viewModel.state().requestDoodleImages
            .bind(to: collectionView.rx.items(cellIdentifier: ImageCell.id, cellType: ImageCell.self)){ index, data, cell in
            cell.setImage(data: data)
        }
        .disposed(by: disposeBag)
        
    }
    
    private func layout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
