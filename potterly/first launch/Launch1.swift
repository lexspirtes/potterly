//
//  FirstLaunchController.swift
//  potterly
//
//  Created by Alexandra Spirtes on 11/11/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import SnapKit

class Launch1: UIViewController {
    
    let myLabel : UILabel = {
        let label = UILabel()
        label.text = "here"
        return label
    }()
    
    let escapeButton: UIButton = {
        let button = UIButton()
        let title = "start potting"
        button.setAttributedTitle(title.attrBoldString(color: UIColor.customColors.appleBlue), for: .normal)
        button.setAttributedTitle(title.attrBoldString(color: UIColor.customColors.appleHighlight), for: .highlighted)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myLabel)
        view.addSubview(escapeButton)
        makeConstraints()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        escapeButton.reactive.controlEvents(.touchUpInside).observeValues({_ in self.dismissView()})
    }
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    func makeConstraints() {
        myLabel.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self.view)
               }
        escapeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(myLabel.snp.bottom).offset(24)
               }
    }
    

}
