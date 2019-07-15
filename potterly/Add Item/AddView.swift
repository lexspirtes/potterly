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



class AddViewModel {
    let CeramicData: CeramicData
    let photo: Data?
    
    init(CeramicData: CeramicData) {
        self.CeramicData = CeramicData
        self.photo = nil
    }
    
    
    func getAddPhotoViewModel() -> AddPhotoViewModel {
        return AddPhotoViewModel(photo: self.photo, CeramicData: self.CeramicData)
    }
}

class AddView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let containerView = UIView()
    let buttonView = UIView()
    let imageView = UIImageView()
    var pickedImage: Bool = false
    let viewModel: AddViewModel
    
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
    
    init(viewModel: AddViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let lineView: UIView = {
        let view = UIView()
        return view
    }()
   
    public let photoButton:UIButton = {
        let myString = "photo"
        let myMutableString = NSMutableAttributedString(string: myString, attributes:
            [NSAttributedString.Key.font:UIFont(name: "Karla-Regular", size: 18.0)!,
             NSAttributedString.Key.kern: CGFloat(0.7),
             NSAttributedString.Key.foregroundColor: UIColor.customColors.lilac
            ])
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setAttributedTitle(myMutableString, for: .normal)
        return button
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
      //  imageView.image = image
        let resizedImage = resizeImage(image: image!, newWidth: 200.0)
        imageView.image = resizedImage
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
    
    func makeConstraints(){
//        //containerView constraints
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaInsets)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaInsets)}
//
//        //libraryButton constraints
        libraryButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.containerView).offset(-32)
            make.centerX.equalTo(self.containerView.snp.centerX).multipliedBy(0.5)
        }
//        imageView.snp.makeConstraints { (make) in
//            make.centerY.equalTo(self.containerView)
//            make.centerX.equalTo(self.containerView)
//        }
//        //photoButton constraints
        photoButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.containerView).offset(-32)
            make.centerX.equalTo(self.containerView.snp.centerX).multipliedBy(1.5)
        }
        //lineView
        buttonView.snp.makeConstraints { (make) in
            make.height.equalTo(2)
            make.bottom.equalTo(photoButton.snp.top).offset(-16)
            make.width.equalTo(containerView)
        }
    }
    
    
    
    override func viewDidLoad() {
        //  proceedWithCameraAccess(identifier: "hi")
        view.backgroundColor = .white
        containerView.backgroundColor = .white
        buttonView.backgroundColor = UIColor.customColors.lilac
        view.addSubview(containerView)
      //  containerView.addSubview(buttonView)
        containerView.addSubview(libraryButton)
        containerView.addSubview(photoButton)
        containerView.addSubview(buttonView)
//        containerView.addSubview(imageView)
        makeConstraints()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "add"
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) && !pickedImage {
//            let imagePickerController = UIImagePickerController()
//            imagePickerController.delegate = self;
//            imagePickerController.sourceType = .camera
//            self.present(imagePickerController, animated: true, completion: nil)
//            pickedImage = true
//        }
        super.viewWillAppear(animated)
    }
}
