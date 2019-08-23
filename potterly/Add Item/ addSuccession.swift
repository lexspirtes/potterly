//
//   addSuccession.swift
//  potterly
//
//  Created by Alexandra Spirtes on 8/23/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import YPImagePicker
import AVFoundation
import AVKit
import Photos
import ReactiveCocoa
import ReactiveSwift


class YPPickerView: UIViewController {
    let viewModel: AddViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        var config = YPImagePickerConfiguration()
        /* Set this to true if you want to force the  library output to be a squared image. Defaults to false */
        config.library.onlySquare = true
        /* Set this to true if you want to force the camera output to be a squared image. Defaults to true */
        config.onlySquareImagesFromCamera = true
        /* Ex: cappedTo:1024 will make sure images from the library or the camera will be
         resized to fit in a 1024x1024 box. Defaults to original image size. */
        config.targetImageSize = .cappedTo(size: 1024)
        /* Choose what media types are available in the library. Defaults to `.photo` */
        config.library.mediaType = .photoAndVideo
        
        
        /* Adds a Filter step in the photo taking process. Defaults to true */
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = false
        config.startOnScreen = .library
        config.screens = [.library, .photo]
        config.showsCrop = .none
        /* Defines the overlay view for the camera. Defaults to UIView(). */
        /* Customize wordings */
        config.wordings.libraryTitle = "Gallery"
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        config.showsPhotoFilters = true
        config.filters = [YPFilter(name: "Normal", coreImageFilterName: ""),
                          YPFilter(name: "Mono", coreImageFilterName: "CIPhotoEffectMono")]
        let picker = YPImagePicker(configuration: config)
        addChild(picker)
        view.addSubview(picker.view)
        picker.didMove(toParent: self)
        //setting imageView to chosen imave
        // let image = UIImage(data: viewModel.photo!)
        //    imageView.image = UIImage.resize(image: image!, targetSize: CGSize(width: 100, height: 100))
        /* Multiple media implementation */
        picker.didFinishPicking { [unowned picker] items, cancelled in
            
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
            }

            if let firstItem = items.first {
                switch firstItem {
                case .photo(let photo):
                    let data = photo.image.imageToData()
                    self.viewModel.photo = data
                    self.navigateToAddView()
                    print("this is touched")
                case .video( _):
                    break
                }
            }
        }
    }
//        if self.pickedImage == false {
//            present(picker, animated: true, completion: nil)
//        }
//        else {}
        //bar button item
        
        //view model
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "new item"
        
    }
    
    func navigateToAddView() {
        //do i want to go back to home or stay in add? adding a lot of things at once?
        let outputView = AddCeramicView(viewModel: viewModel.getAddCeramicViewModel())
        self.present(outputView, animated: true)
    }
    
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    init(viewModel: AddViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
