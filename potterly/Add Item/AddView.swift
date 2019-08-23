//
//  AddView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import ReactiveCocoa
import ReactiveSwift



class AddView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let containerView = UIView()
    var pickedImage: Bool = false
    let viewModel: AddCeramic
    
    public let libraryButton:UIButton = {
        let myString = "library"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.midnight
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return button
    }()
    
    
    public let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColors.lilac
        return view
    }()
   
    public let photoButton:UIButton = {
        let myString = "photo"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        let myMutableStringHighlighted = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.midnight
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        button.setAttributedTitle(myMutableStringHighlighted, for: .highlighted)
        return button
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = image?.imageToData()
        navigateToAddItemView()
     //   imageView.image = resizedImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func navigateToAddItemView() {
        self.tabBarController?.navigationItem.title = ""
   //     let outputView = AddCeramicView(viewModel: viewModel.getAddCeramicViewModel())
   //     self.navigationController?.pushViewController(outputView, animated: true)
    }
    
    func makeConstraints(){
        //containerView constraints
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaInsets)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaInsets)}

        //libraryButton constraints
        libraryButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.containerView.snp.bottom).multipliedBy(0.95)
            make.centerX.equalTo(self.containerView.snp.centerX).multipliedBy(0.5)
        }

        //photoButton constraints
        photoButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.containerView.snp.bottom).multipliedBy(0.95)
            make.centerX.equalTo(self.containerView.snp.centerX).multipliedBy(1.5)
        }
        
        //lineView
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.bottom.equalTo(containerView.snp.bottom).multipliedBy(0.9)
            make.width.equalTo(containerView)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        containerView.backgroundColor = .white
        
        //adding subviews
        view.addSubview(containerView)
        containerView.addSubview(libraryButton)
        containerView.addSubview(photoButton)
        containerView.addSubview(lineView)
        
        //making constraints
        makeConstraints()
        
        
        // Do any additional setup after loading the view.
        self.title = "add"
        
        //
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "photo"
    }
    
    func switchTab() {
  //      self.tabBarController?.selectedIndex = 0
    }
    

    func makeLibraryAppear() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func makeCameraAppear() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
            pickedImage = true
            
            
        }
    }
    
    
    init(viewModel: AddCeramic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
