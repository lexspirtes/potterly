//
//  CeramicCellView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/17/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import SnapKit


class CeramicCell: UICollectionViewCell {
    var viewModel: CeramicCellViewModel!
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.mauve
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(imageView)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: CeramicCellViewModel){
        self.viewModel = viewModel
        //setting the label text
        let image = UIImage(data: viewModel.photo!)
        let resize = UIImage.resize(image: image!, targetSize: CGSize(width: 100, height: 100))
        imageView.image = resize
    }
    
    convenience init(frame: CGRect, viewModel: CeramicCellViewModel){
        self.init(frame: frame)
        self.viewModel = viewModel
        //setting the label text
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(contentView)
        }
    }
}

