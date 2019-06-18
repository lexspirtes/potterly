//
//  HomeView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SnapKit

//parent VC
class homeTabStrip: ButtonBarPagerTabStripViewController {
    var isReload = false
    let myContainer = UIView()
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = UIColor.customColors.midnight
        settings.style.buttonBarItemFont = UIFont(name: "Karla-Regular", size: 14) ?? .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.customColors.lilac
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        //changes color of current index
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.customColors.lilac
            newCell?.label.textColor = UIColor.customColors.midnight
        }
        view.addSubview(myContainer)
        myContainer.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.left.right.equalTo(view)}
        super.viewDidLoad()
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = toDry()
        let child2 = toTrim()
        let child3 = Bisqued()
        let child4 = Glazed()
        return [child1, child2, child3, child4]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
}


class toDry: UIViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subview = UIView()
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.left.right.equalTo(view)}
        // Do any additional setup after loading the view.
        //view.addSubview(scrollView)
        self.title = "toDry"
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "to trim")
    }
}

class toTrim: UIViewController, IndicatorInfoProvider {
    let subview = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.left.right.equalTo(view)}
        view.backgroundColor = .blue
        self.title = "toTrim"
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "to dry")
    }
}

class Bisqued: UIViewController, IndicatorInfoProvider {
    let subview = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.left.right.equalTo(view)}
        view.backgroundColor = .lightGray
        self.title = "Bisqued"
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "bisqued")
    }
}

class Glazed: UIViewController, IndicatorInfoProvider {
    override func viewDidLoad() {
        super.viewDidLoad()
        let subview = UIView()
        // Do any additional setup after loading the view.
        subview.backgroundColor = .white
        view.addSubview(subview)
        view.backgroundColor = .white
        subview.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(view)
            make.bottom.equalTo(view)
            make.left.right.equalTo(view)}
        
        self.title = "Glazed"
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "glazed")
    }
}
