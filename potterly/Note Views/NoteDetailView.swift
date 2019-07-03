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

class NoteViewModel {
    let note: MutableProperty<String>
    let title: MutableProperty<String>
    let date: Date
    let (buttonSignal, buttonTapped) = Signal<(), NoError>.pipe()
    
    init(withNote note: Note?) {
        self.title = MutableProperty(note?.title ?? "")
        self.note = MutableProperty(note?.text ?? "")
        self.date = Date()
    }
    
    func tapButton() {
        self.buttonTapped.send(value: ())
        print("tapped")
//        saveNote()
    }
    
    
//    private func saveNote() {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(Note(title: self.title.value, text: self.note.value, lastEdited: self.date)!, toFile: Note.ArchiveURL.path)
//        if isSuccessfulSave {
//            os_log("Note successfully saved.", log: OSLog.default, type: .debug)
//        } else {
//            os_log("Failed to save note...", log: OSLog.default, type: .error)
//        }
//    }
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
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
      //  scroll.backgroundColor = UIColor.customColors.lilac
        return scroll
    }()
    
    func makeConstraints() {
        
        //scroll View
        scrollView.snp.makeConstraints{ (make) in
            make.top.leading.equalTo(view.safeAreaInsets).offset(24)
            make.bottom.trailing.equalTo(view.safeAreaInsets).offset(24)
        }
        
        //title field
        titleField.snp.makeConstraints{ (make) in
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(50)
        }

        //for body textfield
        bodyField.snp.makeConstraints{ (make) in
            make.top.equalTo(titleField.snp.bottom).offset(12)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(titleField)
        scrollView.addSubview(bodyField)
        bodyField.text = viewModel.note.value
        titleField.text = viewModel.title.value
        viewModel.title <~ titleField.reactive.continuousTextValues
        viewModel.note <~ bodyField.reactive.continuousTextValues
        print(viewModel.title.value)
        makeConstraints()
        titleField.delegate = self
        bodyField.delegate = self
        
        //trying this here
        let buttonView = UIButton()
        buttonView.setTitle("done", for: .normal)
        let button = UIBarButtonItem(customView: buttonView)
        buttonView.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.tapButton() }
        viewModel.buttonSignal.observeValues(self.saveNote)
        self.navigationItem.rightBarButtonItem = button
    }
    
    init(viewModel: NoteViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveNote() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let noteEntity = NSEntityDescription.entity(forEntityName: "NoteData", in: context)!
        let newNote = NSManagedObject(entity: noteEntity, insertInto: context)
        newNote.setValue(viewModel.title.value, forKey: "title")
        newNote.setValue(viewModel.note.value, forKey: "text")
        newNote.setValue(Date(), forKey: "lastEdited")
        // Save the data to coredata
        do {
            try context.save()
            print("saved")
        } catch {
            print("Failed saving")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
    
}
