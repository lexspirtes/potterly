//
//  NoteDetailView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/6/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import os.log
import RealmSwift


//currently just a placeholder UIViewController to display when clicked into specific note
class NoteDetailView: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    let viewModel: NoteViewModel!
    
    let titleField:UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Karla-Bold", size: 25)
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
        return field
    }()
    
    let bodyField:UITextView = {
        let field = UITextView()
        field.font = UIFont(name: "Karla", size: 14)
        field.keyboardType = UIKeyboardType.default
        return field
    }()
    
    func makeConstraints() {
        
        //title field
        titleField.snp.makeConstraints{ (make) in
            make.top.leading.equalTo(view.safeAreaInsets).offset(24)
            make.trailing.equalTo(view.safeAreaInsets).offset(-24)
            make.height.equalTo(50)
        }

        //for body textfield
        bodyField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleField)
            make.bottom.equalTo(view.safeAreaInsets).offset(-24)
        }

    }
    
    let postAction: Action<String, Void, NoError> = Action<String, Void, NoError> { (input: String) in
        return SignalProducer<Void, NoError> { _ , _ in
            let data = input
            print("hihihi")
        }
    }
        //zipping properties together, waiting for signal to come through both of them
        //turn into signal
        //map because signal doesn't care about extra information, return type ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleField)
        view.addSubview(bodyField)
        bodyField.text = viewModel.note.value
        titleField.text = viewModel.title.value
        viewModel.title <~ titleField.reactive.continuousTextValues
        viewModel.note <~ bodyField.reactive.continuousTextValues
        self.bodyField.keyboardDistanceFromTextField = 8
        print(viewModel.title.value)
        makeConstraints()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.reactive.title <~ viewModel.title
        //trying this here
        let buttonView = UIButton()
        buttonView.setTitle("done", for: .normal)
        self.navigationItem.backBarButtonItem?.reactive.pressed = CocoaAction(postAction) { button in
            _ = button
            return "hi"
            }
        self.postAction.values.observeValues { data in
            print("Received data: \(data)")
        }
        let button = UIBarButtonItem(customView: buttonView)
        buttonView.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.tapButton() }
        self.navigationItem.rightBarButtonItem = button
        placeHolder()
        
    }
    
    init(viewModel: NoteViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func placeHolder() {
        if viewModel.new {
            self.titleField.placeholder = "Title"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
