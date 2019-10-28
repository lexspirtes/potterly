//
//  enlargedView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 10/25/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift


class EnlargedView: UIViewController {

    let viewModel: enlargedViewModel!
    
    let imageView:UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        
        //adding singleTap
        let singleTap = UITapGestureRecognizer()
        singleTap.reactive.stateChanged.observeValues({ _ in self.viewModel.singleTap()})
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        viewModel.tapSignal.observeValues(dismissView)
        
        //set image
        imageView.image = UIImage.resize(image: UIImage(data: self.viewModel.photo)!, targetSize: CGSize(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        
        makeConstraints()
    }
    
    func dismissView(){
        self.dismiss(animated: true, completion:nil)
        print("dismissing")
    }
    init(viewModel: enlargedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        //containerView constraints
          imageView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
          }
    }
    
}
