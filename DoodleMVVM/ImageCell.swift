//
//  DoodleCell.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/03.
//

import UIKit

final class ImageCell: UICollectionViewCell {
    
    static let id = "ImageCell"
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
}
extension ImageCell {
    func setImage(data: Data) {
        imageView.image = UIImage(data: data)
    }
    
    private func layout() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
