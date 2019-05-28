//
//  FirstViewController.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import SnapLayout
import SnapKit

class RootViewController: UIViewController {
    
    //bannerView: background plus label as subView
    private let bannerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.87, alpha:1.0)
        return view
    }()

    //snapLayout,
    func setUpAutoLayout() {
        bannerView.snap(top: 8, leading: 8, trailing: 16)
        bannerLabel.snap(centerX: 0, centerY: 0)
    }
    
    //snapKit
    func setupContainerView() {
            bannerView.snp.makeConstraints { (make) in
                make.left.equalTo(self.view)
                make.right.equalTo(self.view)
                make.width.equalTo(self.view)
                make.centerX.equalTo(self.view)
                make.top.equalTo(self.view)
                make.height.equalTo(96)
        }
            bannerLabel.snp.makeConstraints { (make) in
                make.centerX.equalTo(self.view)
                make.bottom.equalTo(self.bannerView).offset(-10)
        }
    }
    
    //potterly top label
    private let bannerLabel:UILabel = {
        let txt = UILabel()
        txt.textColor = .black;
        txt.backgroundColor = UIColor(red:0.82, green:0.81, blue:0.87, alpha:1.0);
        txt.text = "potterly";
        txt.font = UIFont (name: "BodoniSvtyTwoITCTT-Book", size: 30);
        return txt
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        bannerView.addSubview(bannerLabel)
        view.addSubview(bannerView)
        setupContainerView()
    }


}

