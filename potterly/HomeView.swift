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
import SnapLayout

//parent VC
class homeTabStrip: ButtonBarPagerTabStripViewController {
    let collectionView = UIView()
    var isReload = false
    let color = colors()
    override func viewDidLoad() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view).offset(-64)
            make.left.equalTo(view)
            make.right.equalTo(view)}
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = color.darkBlue
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = color.lightPurple
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        //changes color of current index
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            let color = colors()
            oldCell?.label.textColor = color.lightPurple
            newCell?.label.textColor = color.darkBlue
        }
        super.viewDidLoad()
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = toDry()
        let child2 = toTrim()
        let child3 = Bisqued()
        let child4 = Glazed()
        return [child1, child2, child3, child4]
    }
}

class toDry: UIViewController, IndicatorInfoProvider {
    
    let scrollView = UIScrollView()
    func setupContainerView() {
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(64)
            make.center.left.right.equalTo(self.view)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let subview = UIScrollView()
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view).offset(-64)
            make.left.equalTo(view)
            make.right.equalTo(view)}
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        //view.addSubview(scrollView)
        self.title = "home"
       // scrollView.snap(top: 64, leading: 0, bottom: 64, trailing: 0)
        //        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        //        self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        //        self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "To Trim")
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
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view).offset(-64)
            make.left.equalTo(view)
            make.right.equalTo(view)}
        view.backgroundColor = .blue
        self.title = "home"
        //        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        //        self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        //        self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "To Dry")
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
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view).offset(-64)
            make.left.equalTo(view)
            make.right.equalTo(view)}
        view.backgroundColor = .blue
        self.title = "home"
        //        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        //        self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        //        self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Bisqued")
    }
}

class Glazed: UIViewController, IndicatorInfoProvider {
    let subview = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.bottom.equalTo(view).offset(-64)
            make.left.equalTo(view)
            make.right.equalTo(view)}
        view.backgroundColor = .blue
        self.title = "home"
        //        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        //        self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        //        self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Glazed")
    }
}
