//
//  AddView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class AddView: UIViewController {
    let containerView = UIView()
    let buttonView = UIView()
    
    
    public let libraryButton:UIButton = {
        let myString = "library"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return button
    }()
    
    
    public let photoButton:UIButton = {
        let myString = "photo"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return button
    }()
    
    func makeConstraints(){
        //containerView constraints
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaInsets)
            make.bottom.equalTo(view.safeAreaInsets)
            make.width.equalTo(view.safeAreaInsets)}
        
        //libraryButton constraints
        libraryButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.containerView)
            make.centerX.equalTo(self.containerView).multipliedBy(1.5)
        }
        //photoButton constraints
        photoButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.containerView)
            make.trailing.equalTo(self.containerView).multipliedBy(0.5)
            //make.top.bottom.equalTo(containerView)
        }
    }
    
    override func viewDidLoad() {
        //  proceedWithCameraAccess(identifier: "hi")
        view.backgroundColor = .white
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(buttonView)
        containerView.addSubview(libraryButton)
        containerView.addSubview(photoButton)
        makeConstraints()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "add"
    }
}
