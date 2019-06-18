//
//  NoteDetailView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/6/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit

//currently just a placeholder UIViewController to display when clicked into specific note
class NoteDetailView: UIViewController {
    
    public let exampleLabel:UILabel = {
        let label = UILabel()
        let myString = "you MADE IT"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        label.text = myString
        return label
    }()
    
    func makeConstraints() {
        exampleLabel.snp.makeConstraints{ (make) in
            make.top.left.bottom.equalTo(view.safeAreaInsets)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(exampleLabel)
        makeConstraints()
    }
}
