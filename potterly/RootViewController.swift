//
//  FirstViewController.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import FlexLayout

class RootViewController: UIViewController {
    //setting view model
    var viewModel: RootViewModel!
    
    private let disposeBag = DisposeBag()
    
    //bannerView: background plus label as subView
    public let bannerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.10, blue:0.25, alpha:1.0)
        return view
    }()
    
    //flex container
    public let navBar:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    //done button view
    public let doneButton:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    //done button button
    public let potButton:UIButton = {
        let buttonImage = UIImage(named: "pot pdf")
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(buttonImage, for: .normal)
        return button
    }()
    
    //done button label
    public let potLabel:UILabel = {
        let txt = UILabel()
        txt.formatLabel(text: "done", textColor: UIColor(red:0.82, green:0.81, blue:0.87, alpha:1.0))
        return txt
    }()
    
    //home button view
    public let homeView:UIView = {
        let view = UIView()
        return view
    }()
    
    //done button button
    public let homeButton:UIButton = {
        let buttonImage = UIImage(named: "home")
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(buttonImage, for: .normal)
        return button
    }()
    
    //done button label
    public let homeLabel:UILabel = {
        let txt = UILabel()
        txt.formatLabel(text: "home", textColor: UIColor(red:0.82, green:0.81, blue:0.87, alpha:1.0))
        return txt
    }()
    
    //potterly top label
    public let bannerLabel:UILabel = {
        let txt = UILabel()
        txt.formatLabel(text: "potterly", spacing: 2, font: "BodoniSvtyTwoITCTT-Book", fontSize: 30)
        return txt

    }()
    
    //snapKit creating layout constraints
    func setupContainerView() {
        bannerView.snp.makeConstraints { (make) in
            make.left.right.width.centerX.top.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.111)
        }
        bannerLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.bannerView).offset(-10)
        }
        
        navBar.snp.makeConstraints { (make) in
            make.left.right.width.centerX.bottom.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.111)
        }
        
//        doneButton.snp.makeConstraints { (make) in
//            make.left.right.width.centerX.bottom.equalTo(self.navBar)
//            make.centerY.equalTo(self.navBar)
//        }

        potButton.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(self.doneButton)
        }

        potLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.potButton.snp_bottom).offset(5)
            make.centerX.equalTo(self.potButton)
        }
        homeButton.snp.makeConstraints { (make) in
            make.centerY.centerX.equalTo(self.homeView)
        }
        
        homeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.homeButton.snp_bottom).offset(5)
            make.centerX.equalTo(self.homeButton)
        }
        
    }
    
    //make status bar white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        bannerView.addSubview(bannerLabel)
        navBar.addSubview(potButton)
        doneButton.addSubview(potLabel)
        doneButton.addSubview(potButton)
        homeView.addSubview(homeLabel)
        homeView.addSubview(homeButton)
        view.addSubview(bannerView)
        view.addSubview(navBar)
        //navBar is flexcontainer for buttons
        navBar.flex.addItem(doneButton).direction(.row).marginLeft(100)
        navBar.flex.addItem(homeView).direction(.row).marginLeft(100)
        navBar.flex.justifyContent(.spaceAround)
        setupContainerView()

    }
}

