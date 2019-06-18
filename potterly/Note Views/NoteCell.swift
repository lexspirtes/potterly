//
//  NoteCell.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/5/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result
import CoreData


class NoteTableViewCell: UITableViewCell {
    var note: Note? {
        didSet {
            guard let noteItem = note else {return}
            if let title = noteItem.title {
                titleLabel.text = title
            }
            if let date = noteItem.date {
                dateLabel.text = " \(date) "
            }

            if let text = noteItem.text {
                detailLabel.text = text
            }
        }
    }
    
    let button = UIButton()
    var buttonClickedSignal: SignalProducer<AnyObject?, NSError>?
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Bold", size: 14)
        label.textColor = UIColor.customColors.midnight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.mauve
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.mauve
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(contentView).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerView)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(10)
            make.width.equalTo(contentView).dividedBy(3)
        }
        button.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(containerView)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(detailLabel)
        containerView.addSubview(button)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}

