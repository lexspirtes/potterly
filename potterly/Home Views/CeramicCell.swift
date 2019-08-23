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
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        //set from data timestampx
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        return dateString
    }
    func checkImage() -> UIImage {
        let image: UIImage
        if UIImage(data: viewModel.photo!) == nil {
            image = UIImage(named: "oops")!
        }
        else { image = UIImage(data: viewModel.photo!)!
        }
        return image
    }
    
    func checkNil() -> UIImage {
        if viewModel.photo != nil {
            return UIImage(data: viewModel.photo!)!
        }
        else {
            return UIImage(named: "oops")!
        }
    }

    func configure(viewModel: CeramicCellViewModel){
        self.viewModel = viewModel
        //setting the label text
        let image = checkNil()
        let resize = UIImage.resize(image: image, targetSize: CGSize(width: 100, height: 100))
        imageView.image = resize
        dateLabel.text = formatDate(date: viewModel.date)
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

