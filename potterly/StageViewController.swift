//
//  StageViewController.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout



class NavBar: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate let topBanner = UIView()
    fileprivate let contentView = UIScrollView()
    fileprivate let navView = UIView()
    fileprivate let view2 = UIView()
    let color = colors()
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        //banner
        topBanner.backgroundColor = .gray
        let potterly = UILabel()
        potterly.formatLabel(text: "potterly", spacing: 2, font: "BodoniSvtyTwoITCTT-Book", fontSize: 30)
        
        //creating topBanner as flex container
        topBanner.flex.addItem().height(96).direction(.column).backgroundColor(color.darkBlue).define { (flex) in
            flex.justifyContent(.end).alignItems(.center).paddingBottom(10).addItem(potterly)
        }
        
        //trying to change thing
        rootFlexContainer.backgroundColor = .lightGray
        
        //done button and label
        let doneLabel = UILabel()
        doneLabel.formatLabel(text: "done", textColor: color.lightPurple)
        let potImage = UIImage(named: "potsmall")
        let doneButton = UIButton(type: UIButton.ButtonType.custom)
        doneButton.setImage(potImage, for: .normal)
        
        //home button and label
        let homeLabel = UILabel()
        homeLabel.formatLabel(text: "home", textColor: color.lightPurple)
        homeLabel.numberOfLines = 0
        let homeImage = UIImage(named: "home")
        let homeButton = UIButton(type: UIButton.ButtonType.custom)
        homeButton.setImage(homeImage, for: .normal)
        
        //notes button and label
        let notesLabel = UILabel()
        notesLabel.formatLabel(text: "notes", textColor: color.lightPurple)
        notesLabel.numberOfLines = 0
        let notesImage = UIImage(named: "notes")
        let notesButton = UIButton(type: UIButton.ButtonType.custom)
        notesButton.setImage(notesImage, for: .normal)
        
        //add button and label
        let addLabel = UILabel()
        addLabel.formatLabel(text: "add", textColor: color.lightPurple)
        addLabel.numberOfLines = 0
        let addImage = UIImage(named: "add")
        let addButton = UIButton(type: UIButton.ButtonType.custom)
        addButton.setImage(addImage, for: .normal)
    
    
        navView.flex.direction(.column).direction(.column).addItem().backgroundColor(.white).marginBottom(10).define { (flex) in
            //adding purple line to bottom
            flex.addItem().height(2).backgroundColor(color.lightPurple).marginBottom(10)
            flex.addItem().backgroundColor(.white).direction(.row).alignItems(.center).justifyContent(.spaceAround).define { (flex) in
                //creating home button
                flex.addItem().direction(.column).justifyContent(.center).define { (flex) in
                    flex.addItem(homeButton)
                    flex.marginBottom(5).addItem(homeLabel)
                    
                }
                //creating notes button
                flex.addItem().direction(.column).justifyContent(.center).define { (flex) in
                    flex.addItem(notesButton)
                    flex.marginBottom(5).addItem(notesLabel)
                    
                }
                //creating add button
                flex.addItem().direction(.column).justifyContent(.center).define { (flex) in
                    flex.addItem(addButton)
                    flex.marginBottom(5).addItem(addLabel)
                    
                }
                //creating done button
                flex.addItem().direction(.column).justifyContent(.center).define { (flex) in
                    flex.addItem(doneButton)
                    flex.marginBottom(5).addItem(doneLabel)
                    
                }
            }
        }

//    rootFlexContainer.flex.direction(.column).paddingBottom(10).define { (flex) in
//
//      //  flex.addItem(topBanner)
//        flex.addItem().backgroundColor(.lightGray)
//      //  flex.addItem(navView)
//        }
        rootFlexContainer.flex.height(300)
        addSubview(rootFlexContainer)
        addSubview(topBanner)
        addSubview(navView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
            rootFlexContainer.pin.top().horizontally()
            topBanner.pin.top().horizontally()
            navView.pin.bottom(pin.safeArea).horizontally()
        // Then let the flexbox container layout itself
            rootFlexContainer.flex.layout(mode: .adjustHeight)
        navView.flex.layout(mode: .adjustHeight)
        topBanner.flex.layout(mode: .adjustHeight)
    }
}

class NavViewController: UIViewController {
    
    //make status bar white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate var mainView: NavBar {
        return self.view as! NavBar
    }
    
  //  load view function
    override func loadView() {
        view = NavBar()
    }
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
