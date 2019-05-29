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
    fileprivate let navFlexContainer = UIView()
    fileprivate let topBanner = UIView()
    fileprivate let view2 = UIView()
    let color = colors()
    init() {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        
        //banner
        topBanner.backgroundColor = .gray
        let potterly = UILabel()
        potterly.formatLabel(text: "potterly", spacing: 2, font: "BodoniSvtyTwoITCTT-Book", fontSize: 30)
        
        
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
        
    rootFlexContainer.flex.direction(.column).paddingBottom(10).justifyContent(.spaceEvenly).define { (flex) in
        
            flex.addItem().height(96).direction(.column).backgroundColor(color.darkBlue).define { (flex) in
                flex.justifyContent(.end).alignItems(.center).paddingBottom(10).addItem(potterly)
            }
            flex.addItem().backgroundColor(.lightGray)
            //line and bar one flex item
            flex.addItem().backgroundColor(.white).direction(.column).marginBottom(10).define { (flex) in
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
        
        
    }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout the flexbox container using PinLayout
        // NOTE: Could be also layouted by setting directly rootFlexContainer.frame
            rootFlexContainer.pin.top().horizontally()
        // Then let the flexbox container layout itself
            rootFlexContainer.flex.layout(mode: .adjustHeight)
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
    
    fileprivate var mainView: IntroView {
        return self.view as! IntroView
    }
    
    override func loadView() {
        view = NavBar()
    }
}
