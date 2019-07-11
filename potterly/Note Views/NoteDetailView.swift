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
import CoreData
import RealmSwift

class NoteViewModel {
    let note: MutableProperty<String>
    let title: MutableProperty<String>
    let date: Date
    let (buttonSignal, buttonTapped) = Signal<(), NoError>.pipe()
    let NoteData: NoteData
    let new : Bool
    let id : Int
    
    init(note: Note, NoteData: NoteData) {
        self.title = MutableProperty(note.title)
        self.note = MutableProperty(note.text)
        self.id = note.id
        self.new = NoteViewModel.newNote(title: self.title.value)
        self.date = Date()
        self.NoteData = NoteData
    }
    
    func tapButton() {
        self.buttonTapped.send(value: ())
        print("tapped")
        let newNote = Note()
        newNote.title = self.title.value
        newNote.text = self.note.value
        newNote.lastEdited = self.date
        if self.id == 0 {
            self.NoteData.saveNote(note: newNote)
        }
        else {
            newNote.id = self.id
            self.NoteData.updateNote(note: newNote)
        }
    }
    
    class func newNote(title: String) -> Bool {
        if title.count == 0 {
            return true
        }
        else {
            return false
            
        }
    }
    //maybe have toolbar for pushing done currently

}

//currently just a placeholder UIViewController to display when clicked into specific note
class NoteDetailView: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    let viewModel: NoteViewModel!
    
    let titleField:UITextField = {
        let field = UITextField()
        field.font = UIFont(name: "Karla-Bold", size: 25)
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextField.ViewMode.whileEditing
       // field.backgroundColor = .white
        return field
    }()
    
    let bodyField:UITextView = {
        let field = UITextView()
        field.font = UIFont(name: "Karla", size: 14)
        field.keyboardType = UIKeyboardType.default
      //  field.returnKeyType = UIReturnKeyType.enter
        //field.clearButtonMode = UITextField.ViewMode.whileEditing
      //  field.backgroundColor = .green
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
