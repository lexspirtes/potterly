//
//  NoteCell.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/5/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit

struct Note {
    let title:String?
    let text:String?
    let date:String?
}

class NoteAPI {
    static func getNotes() -> [Note]{
        let notes = [
            Note(title: "Glazes", text: "i think i want to try frose", date: "Friday"),
            Note(title: "to Make", text: "stuff to make", date: "06.01.19"),
            Note(title: "Comissions", text: "aduhfjhsdgfaksdfgakdjsgfakdjshgfakjsdgfakds", date: "05.30.19"),
            Note(title: "for Friends", text: "butter holder", date: "05.23.19"),
            Note(title: "Trimming", text: "jars", date: "05.20.19"),
            Note(title: "Christmas Market", text: "make sure you get booth!", date: "04.13.18"),
            Note(title: "Slip", text: "try pedros black", date: "03.12.18"),
            Note(title: "Luster Fire", text: "will happen in may", date: "03.11.18"),
            Note(title: "Retreats", text: "upstate new york thing", date: "03.10.18"),
        ]
        return notes
    }
}

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
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(detailLabel)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}

