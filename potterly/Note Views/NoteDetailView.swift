//
//  NoteDetailView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/6/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit


class NoteDetailView: UIViewController {
    let containerView = UIView()
    
    
    func makeConstraints() {
        containerView.snp.makeConstraints{ (make) in
            make.top.left.bottom.equalTo(view.safeAreaInsets)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        makeConstraints()
    }
}
