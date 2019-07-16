//
//  StageView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import XLPagerTabStrip

class Stage: UIViewController, IndicatorInfoProvider {
    let line = UIView()
    let subview = UIScrollView()
    let viewModel: StageViewModel!
    let infoTitle: String
    
    func makeConstraints() {
        subview.snp.makeConstraints { (make) in
            make.top.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
        }
        line.snp.makeConstraints { (make) in
            make.width.equalTo(subview)
            make.height.equalTo(1)
            make.top.equalTo(subview)}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        line.backgroundColor = UIColor.customColors.lilac
        subview.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(subview)
        subview.addSubview(line)
        makeConstraints()
        // Do any additional setup after loading the view.
        //view.addSubview(scrollView)
        //self.title = "toDry"
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.infoTitle)
    }
    
    init(viewModel: StageViewModel, title: String, infoTitle: String) {
        self.viewModel = viewModel
        self.infoTitle = infoTitle
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

