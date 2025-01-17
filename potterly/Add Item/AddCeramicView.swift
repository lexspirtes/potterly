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


class AddCeramicView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let viewModel: AddCeramic!
    let containerView = UIScrollView()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        let title = "cancel"
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
    
    let photoTitle: UILabel = {
        let label = UILabel()
        let title = "photo"
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
    
    let segmentedControl: UISegmentedControl = {
        // Initialize
        let items = ["to dry", "to trim", "bisqued", "glazed", "done"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0

        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = UIColor.customColors.lighty
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customColors.midnight]
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        return customSC
    }()
    
    let line: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.customColors.lilac
        return lineView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(statusTitle)
        containerView.addSubview(photoTitle)
        containerView.addSubview(segmentedControl)
        view.addSubview(line)
        //datepicking initializing
        datePicker.date = viewModel.date.value
        
        //status
        segmentedControl.selectedSegmentIndex = viewModel.getEnum()

        //button fixing
        let title = self.viewModel.id == 0 ? "add" : "update"
        addButton.setAttributedTitle(title.attrBoldString(color: UIColor.customColors.appleBlue), for: .normal)
        addButton.setAttributedTitle(title.attrBoldString(color: UIColor.customColors.appleHighlight), for: .highlighted)
        
        //imagetap
        let singleTap = UITapGestureRecognizer()
        singleTap.reactive.stateChanged.observeValues({_ in self.viewModel.photoTap()})
        singleTap.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(singleTap)
        viewModel.photoSignal.observeValues(popUp)
    
        //adding date
        containerView.addSubview(dateTitle)
        containerView.addSubview(datePicker)
        view.backgroundColor = .white
        
        //setting imageView to chosen image
        let myImage = viewModel.photo == nil ?  UIImage(named: "addPhoto") : UIImage(data: viewModel.photo!)
        imageView.image = UIImage.resize(image: myImage!.cropsToSquare(), targetSize: CGSize(width: 150,
                                                                                      height: 150))
        //view model
        viewModel.date <~ datePicker.reactive.dates
        //segmentedControl
        segmentedControl.reactive.controlEvents(.valueChanged).observeValues { _ in self.viewModel.segmentTap(buttonTitle: self.segmentedControl.titleForSegment(at: self.segmentedControl.selectedSegmentIndex) ?? "to dry")}
        //addbutton
        viewModel.addSignal.observeValues(self.navigateToHomeView)
        addButton.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.addTap() }
        //cancel button
        cancelButton.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.cancelTap() }

    }
    
    func navigateToHomeView(){
        self.presentingViewController?.dismiss(animated: true, completion:nil)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.viewModel.id == 0 ? "new pot" : "edit pot"
        
        //bar button item
        let barButton = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = barButton
        let cancel = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = cancel
        makeConstraints()
    }
    
    func popUp() {
        print("photo tapped")
        let myActionSheet =  UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        myActionSheet.addAction(UIAlertAction(title: "Library", style: UIAlertAction.Style.default, handler: { _ in self.makeLibraryAppear()}))
        myActionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { _ in self.makeCameraAppear()}))
        self.present(myActionSheet, animated: true, completion: nil)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+50)
    }
    
    func makeLibraryAppear() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func makeCameraAppear() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self;
            imagePickerController.sourceType = .camera
            imagePickerController.modalPresentationStyle = .fullScreen
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let data = (image?.imageToData())!
       // imageView.image = UIImage(cgImage: (image?.cgImage!.cropping(to: CGRect(x: 0, y: 0, width: 50, height: 50)))!)
        imageView.image = UIImage.resize(image: image!.cropsToSquare(), targetSize: CGSize(width: 150, height: 150))
        viewModel.changePhoto(photo: data)
      //   imageView.image = resizedImage
         self.dismiss(animated: true, completion: nil)
     }
     
    
    init(viewModel: AddCeramic){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //segmented control
    //stack views list and lays out one by one
    
    func makeConstraints() {
        
        //containerView constraints
        containerView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        //image view constraints
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(photoTitle.snp.bottom).offset(16)
            make.leading.equalTo(containerView).offset(16)
        }
        
        //photo title constraints
        photoTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView).offset(16)
            make.top.equalTo(containerView.snp.bottom).offset(32)
        }
        
        //photo title constraints
        segmentedControl.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView)
            make.top.equalTo(statusTitle.snp.bottom).offset(32)
        }
        
        //status title constraints
        statusTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView).offset(16)
            make.top.equalTo(imageView.snp.bottom).offset(32)
        }
        
        //image view constraints
        dateTitle.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView).offset(16)
            make.top.equalTo(segmentedControl.snp.bottom).offset(32)
        }
        
        //datepicker constraints
        datePicker.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.containerView)
            make.top.equalTo(dateTitle.snp.bottom).offset(32)
        }
        
        //line constrinats
        line.snp.makeConstraints { (make) in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)}
    }
}

