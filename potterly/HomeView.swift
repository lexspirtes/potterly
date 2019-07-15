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
    let line = UIView()
    let myContainer = UIView()
    override func viewDidLoad() {
        line.backgroundColor = UIColor.customColors.lilac
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
        view.addSubview(line)
        myContainer.snp.makeConstraints { (make) in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view.safeAreaLayoutGuide)}
        line.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(view.safeAreaInsets)
            make.top.equalTo(myContainer)
            }
        super.viewDidLoad()
        
        //appearance for title
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "Karla-Regular" as String, size: 11)!,
             NSAttributedString.Key.kern : CGFloat(0.7)], for: .normal)
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
        self.tabBarController?.navigationItem.title = "potterly"
    }
}


class toDry: UIViewController, IndicatorInfoProvider {
    let line = UIView()
    let subview = UIScrollView()
    
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
        self.title = "toDry"
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "to trim")
    }
}

class toTrim: UIViewController, IndicatorInfoProvider {
    let subview = UIScrollView()
    let line = UIView()
    
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
        // Do any additional setup after loading the view.
        subview.backgroundColor = .white
        view.addSubview(subview)
        view.backgroundColor = .white
        line.backgroundColor = UIColor.customColors.lilac
        subview.addSubview(line)
        makeConstraints()
        
        self.title = "toTrim"
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "to dry")
    }
}

class Bisqued: UIViewController, IndicatorInfoProvider {
    let subview = UIScrollView()
    let line = UIView()
    
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
        // Do any additional setup after loading the view.
        line.backgroundColor = UIColor.customColors.lilac
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.addSubview(line)
        makeConstraints()
        view.backgroundColor = .white
        self.title = "Bisqued"
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "bisqued")
    }
}

class Glazed: UIViewController, IndicatorInfoProvider {
    let line = UIView()
    let subview = UIScrollView()
    
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
        // Do any additional setup after loading the view.
        subview.backgroundColor = .white
        view.addSubview(subview)
        subview.addSubview(line)
        view.backgroundColor = .white
        makeConstraints()
        self.title = "Glazed"
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "glazed")
    }
}
