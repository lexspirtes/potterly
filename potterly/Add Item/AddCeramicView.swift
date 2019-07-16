//
//  AddCeramicView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import FlexLayout


class AddCeramicView: UIViewController {
    let viewModel: AddCeramic!
    let containerView = UIScrollView()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        let title = "add"
        button.setAttributedTitle(title.attrBoldString(color: UIColor.customColors.appleBlue), for: .normal)
        button.setAttributedTitle(title.attrBoldString(color: UIColor.customColors.appleHighlight), for: .highlighted)
        return button
    }()
    
    let statusTitle: UILabel = {
        let label = UILabel()
        let title = "status"
        label.attributedText = title.attrBoldString(color: UIColor.customColors.midnight)
        return label
    }()
    
    let dateTitle: UILabel = {
       let label = UILabel()
        let title = "date"
        label.attributedText = title.attrBoldString(color: UIColor.customColors.midnight)
        return label
    }()
    
    
    let datePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.setValue(UIColor.customColors.midnight, forKeyPath: "textColor")
        return datePicker
    }()
    
    let toDry: UIButton = {
        let button = UIButton()
        let title = "to dry"
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.midnight, bold: true), for: .selected)
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.mauve, bold: false), for: .normal)
        return button
    }()
    
    let toTrim: UIButton = {
        let button = UIButton()
        let title = "to trim"
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.midnight, bold: true), for: .selected)
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.mauve, bold: false), for: .normal)
        return button
    }()
    
    let bisqued: UIButton = {
        let button = UIButton()
        let title = "bisqued"
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.midnight, bold: true), for: .selected)
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.mauve, bold: false), for: .normal)
        return button
    }()
    
    let glazed: UIButton = {
        let button = UIButton()
        let title = "glazed"
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.midnight, bold: true), for: .selected)
        button.setAttributedTitle(title.attrSmallString(color: UIColor.customColors.mauve, bold: false), for: .normal)
        return button
    }()
    
    let toggleContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(statusTitle)
        containerView.addSubview(toggleContainer)

    
        //toggle container stuff
        toggleContainer.addSubview(toDry)
        toggleContainer.addSubview(toTrim)
        toggleContainer.addSubview(bisqued)
        toggleContainer.addSubview(glazed)
        containerView.addSubview(dateTitle)
        containerView.addSubview(datePicker)
        view.backgroundColor = .white
        
        //setting imageView to chosen imave
        let image = UIImage(data: viewModel.photo!)
        let width = UIScreen.main.bounds.width * 0.3
        imageView.image = resizeImage(image: image!, newWidth: width)
        
        //bar button item
        let barButton = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = barButton
        makeConstraints()
        
        //view model
        viewModel.date <~ datePicker.reactive.dates
        //toggle viewModel
        toDry.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.toggleTap(buttonTitle: Status.dry)}
        toTrim.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.toggleTap(buttonTitle: Status.trim)}
        bisqued.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.toggleTap(buttonTitle: Status.bisqued)}
        glazed.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.toggleTap(buttonTitle: Status.glazed)}
        viewModel.toggleSignal.observeValues { (value) in
            self.highlight(status: value)
        }
        //addbutton
        viewModel.addSignal.observeValues(self.printHi)
        addButton.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.addTap() }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "new item"
        toDry.isSelected = true
    }
    
    func printHi() {
        print("add me baby")
    }
    
    func highlight(status: Status) {
        if status == Status.dry {
            toDry.isSelected = true
            toTrim.isSelected = false
            bisqued.isSelected = false
            glazed.isSelected = false
        }
        else if status == Status.trim {
            toDry.isSelected = false
            toTrim.isSelected = true
            bisqued.isSelected = false
            glazed.isSelected = false
        }
        else if status == Status.bisqued {
            toDry.isSelected = false
            toTrim.isSelected = false
            bisqued.isSelected = true
            glazed.isSelected = false
        }
        else {
            toDry.isSelected = false
            toTrim.isSelected = false
            bisqued.isSelected = false
            glazed.isSelected = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+50)
    }
    
    init(viewModel: AddCeramic){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func makeConstraints() {
        
        //containerView constraints
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        //image view constraints
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView).offset(16)
            make.leading.equalTo(containerView).offset(16)
        }
        
        //image view constraints
        statusTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(32)
        }
        
        
        //toggle constraints
        toggleContainer.snp.makeConstraints { (make) in
            make.width.equalTo(containerView)
            make.top.equalTo(statusTitle.snp.bottom)
            make.height.equalTo(containerView).multipliedBy(0.15)
        }
        
        //toDry constraints
        toDry.snp.makeConstraints { (make) in
            make.centerY.equalTo(toggleContainer)
            make.leading.equalTo(statusTitle).offset(16)
        }
        
        //toDry constraints
        toTrim.snp.makeConstraints { (make) in
            make.centerY.equalTo(toggleContainer)
            make.leading.equalTo(toDry.snp.trailing).offset(32)
        }
        
        //toDry constraints
        bisqued.snp.makeConstraints { (make) in
            make.centerY.equalTo(toggleContainer)
            make.leading.equalTo(toTrim.snp.trailing).offset(32)
        }
        
        //toDry constraints
        glazed.snp.makeConstraints { (make) in
            make.centerY.equalTo(toggleContainer)
            make.leading.equalTo(bisqued.snp.trailing).offset(32)
        }
        
        
        //image view constraints
        dateTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView)
            make.top.equalTo(toggleContainer.snp.bottom).offset(32)
        }
        
        //datepicker constraints
        datePicker.snp.makeConstraints { (make) in
            make.leading.equalTo(imageView)
            make.top.equalTo(dateTitle.snp.bottom).offset(32)
        }
    }
}

