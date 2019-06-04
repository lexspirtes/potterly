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
    let color = colors()
   

    
    public let libraryButton:UIButton = {
        let color = colors()
        let myString = "library"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: color.lightPurple
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
      //  button.setTitle("library", for: .normal)
       // button.setTitleColor(color.lightPurple, for: .normal)
        button.setAttributedTitle(myMutableString, for: .normal)
        return button
    }()
    
    public let photoButton:UIButton = {
        let color = colors()
        let myString = "photo"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: color.lightPurple
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return button
    }()
    
    func makeConstraints(){
        //containerView constraints
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view).offset(-64)
            make.left.right.equalTo(view)}
        
        //libraryButton constraints
        libraryButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view)
            make.top.bottom.equalTo(containerView)
        }
        //photoButton constraints
        photoButton.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(containerView).offset(50)
            make.top.bottom.equalTo(containerView)
        }
    }

    

    override func viewDidLoad() {
      //  proceedWithCameraAccess(identifier: "hi")
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(libraryButton)
        containerView.addSubview(photoButton)
        makeConstraints()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "add"
    }
}
