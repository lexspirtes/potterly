//
//  NotesView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import ReactiveSwift
import ReactiveCocoa


class NotesView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //assigning APP Delegate
    let appDelegateObj : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var dataArray = [NSManagedObject]()
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let notes = NoteAPI.getNotes() // model
 //   private let notes = DataFunctions.createData()
    let notesTableView = UITableView() // view
    //var viewModel : NoteListViewModel!
    
    func makeConstraints(){
        notesTableView.snp.makeConstraints{ (make) in
            make.top.left.right.bottom.equalTo(self.view.safeAreaInsets)
        }
    }
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Bold", size: 30)
        label.textColor = UIColor.customColors.midnight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    let myAction = Action<UIBarButtonItem, (), Never> { _ in
        return SignalProducer { observer, _ in
            observer.send(value: ())
            observer.sendCompleted()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.myAction.events.observeValues { [unowned self] _ in
            self.onButtonTap()
        }
        
        let buttonView = UIButton()
        buttonView.setImage(UIImage.imageFromSystemItem(UIBarButtonItem.SystemItem.add), for: .normal)
        let button = UIBarButtonItem(customView: buttonView)
        button.reactive.pressed = CocoaAction(self.myAction) { sender in
            return sender
        }
        
        self.tabBarController?.navigationItem.rightBarButtonItem = button
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //footer so that only as many lines as there are notes
        self.notesTableView.tableFooterView = UIView()
        view.backgroundColor = .white
        notesTableView.separatorColor = UIColor.customColors.lilac
       // cellLabel.reactive.text <~ viewModel.currentProgress
        notesTableView.tableHeaderView = cellLabel
        view.addSubview(notesTableView)
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
        makeConstraints()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "noteCell")

    
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        fetchData()
    }
    
    func fetchData() {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Note")
        fetchRequest.entity = entityDescription
        
        do {
            dataArray = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
         //   self.tableView.reloadData()
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        cell.note = notes[indexPath.row]
        
        //change the selected cell color
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.customColors.lilac.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectedView
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cell
    }
    
    //sets height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    private func onButtonTap() {
        print("Button was tapped.")
    }
    
    
}
