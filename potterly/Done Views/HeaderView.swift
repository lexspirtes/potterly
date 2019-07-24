//
//  HeaderView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/18/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import UIKit

class SectionHeader: UICollectionReusableView {
    var viewModel: SectionViewModel!
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.midnight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: SectionViewModel){
        self.viewModel = viewModel
        //setting the label text
        dateLabel.text = viewModel.date
        
    }
    convenience init(frame: CGRect, viewModel: SectionViewModel){
        self.init(frame: frame)
        self.viewModel = viewModel
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(dateLabel)
        makeConstraints()
    }
    
    func makeConstraints() {
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(6)
            make.centerY.equalTo(self.snp.centerY).offset(6)
        }
    }
}
