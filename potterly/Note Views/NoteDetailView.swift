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
        field.font = UIFont(name: "Karla", size: 16)
        field.keyboardType = UIKeyboardType.default
        return field
    }()
    
    let line: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.customColors.lilac
        return lineView
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
        
        line.snp.makeConstraints { (make) in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)}

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleField)
        view.addSubview(bodyField)
        bodyField.text = viewModel.note.value
        titleField.text = viewModel.title.value
        viewModel.title <~ titleField.reactive.continuousTextValues
        viewModel.note <~ bodyField.reactive.continuousTextValues
        view.addSubview(line)
        self.bodyField.keyboardDistanceFromTextField = -8
        print(viewModel.title.value)
        self.bodyField.backgroundColor = .white
        makeConstraints()
        titleField.delegate = self
        bodyField.delegate = self
        navigationItem.reactive.title <~ viewModel.title
        placeHolder()
        
    }
    
    //view did disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.saveNote()
    }
    
    
    init(viewModel: NoteViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func placeHolder() {
        if viewModel.id == 0 {
            self.titleField.placeholder = "Title"
        }
        if viewModel.note.value == "" {
            self.bodyField.text = "note text here..."
            self.bodyField.textColor = .lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "..."
            textView.textColor = UIColor.lightGray
        }
    }
    
}
