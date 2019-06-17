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
            make.top.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalTo(view)}
        
        //libraryButton constraints
        libraryButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.buttonView)
            make.centerX.equalTo(self.buttonView).multipliedBy(1.5)
        }
        //photoButton constraints
        photoButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.buttonView)
            make.centerX.equalTo(self.buttonView).multipliedBy(0.5)
            //make.top.bottom.equalTo(containerView)
        }
        //photo preview
        buttonView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(containerView)
            make.height.equalTo(containerView).dividedBy(10)
            
        }
    }
    
    override func viewDidLoad() {
        //  proceedWithCameraAccess(identifier: "hi")
        view.backgroundColor = .white
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(buttonView)
        buttonView.addSubview(libraryButton)
        buttonView.addSubview(photoButton)
        makeConstraints()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "add"
    }
}
