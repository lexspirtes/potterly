//
//  DoneView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

//placeholder of DoneView
class DoneView: UIViewController {
    
    var cocoaActionAdd: CocoaAction<Any>!
    
    public let exampleLabel:UILabel = {
        let label = UILabel()
        let myString = ""
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return label
    }()
    
    public let textField:UITextField = {
        let label = UITextField()
        label.backgroundColor = UIColor.customColors.mauve
        let myString = ""
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return label
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
        textField.snp.makeConstraints { (make) in
            make.centerY.equalTo(view).offset(-120)
            make.centerX.equalTo(view)
        }
        
        //libraryButton constraints
        exampleLabel.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(self.view)
        }
        
        //libraryButton constraints
        photoButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(60)
        }
    }
    
    override func viewDidLoad() {
        view.addSubview(exampleLabel)
        view.addSubview(textField)
        view.addSubview(photoButton)
        exampleLabel.reactive.text <~ textField.reactive.continuousTextValues
        //other stuff
//        let addAction = Action<Void, Void, NSError> {
//            if let navigationController = self.navigationController {
//                navigationController.pushViewController(navigationController, animated: true)
//            }
//            return SignalProducer.empty
//        }
//        cocoaActionAdd = CocoaAction(addAction, input: ())
//        photoButton.addTarget(cocoaActionAdd, action: CocoaAction<Any>.selector, for: .touchUpInside)
//        //ending
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        self.title = "done"
        makeConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //makes sure that plus button doesn't show on this view
        super.viewWillAppear(animated);
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}
