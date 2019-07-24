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
    let viewModel: HomeViewModel!
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
            make.top.equalTo(view.safeAreaInsets)
            }
        super.viewDidLoad()
        
        //appearance for title
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "Karla-Regular" as String, size: 11)!,
             NSAttributedString.Key.kern : CGFloat(0.7)], for: .normal)
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = Stage(viewModel: viewModel.getChildViewModel(status: Status.dry), title: "toDry", infoTitle: "to dry")
        let child2 = Stage(viewModel: viewModel.getChildViewModel(status: Status.trim), title: "toTrim", infoTitle: "to trim")
        let child3 = Stage(viewModel: viewModel.getChildViewModel(status: Status.bisqued), title: "bisqued", infoTitle: "bisqued")
        let child4 = Stage(viewModel: viewModel.getChildViewModel(status: Status.glazed), title: "glazed", infoTitle: "glazed")
        return [child1, child2, child3, child4]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.title = "potterly"
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

