//
//  AddView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit

class AddView: UIViewController {
    override func viewDidLoad() {
        
        let myLabel = UILabel()
        myLabel.text = "hi"
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(myLabel)
        self.title = "add"
    }
}
