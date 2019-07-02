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
    let notesTableView = UITableView() // view
    var viewModel : NotesTableViewModel!
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
    
    
    init(viewModel: NotesTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //footer so that only as many lines as there are notes
        self.notesTableView.tableFooterView = UIView()
        view.backgroundColor = .white
        self.title = "notes"
        notesTableView.separatorColor = UIColor.customColors.lilac
        notesTableView.tableHeaderView = cellLabel
        view.addSubview(notesTableView)
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
        makeConstraints()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(NoteTableCell.self, forCellReuseIdentifier: "noteCell")

        //trying this here
        let buttonView = UIButton()
        buttonView.setImage(UIImage(named: "create"), for: .normal)
        let button = UIBarButtonItem(customView: buttonView)
        buttonView.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.tapButton() }
        viewModel.buttonSignal.observeValues(self.navigateToNewNote)
        self.tabBarController?.navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "notes"
        super.viewWillAppear(animated)
        getData()
        notesTableView.reloadData()
        //bar button comes up every time the view is loaded

    }
    //fetching coredata
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteData")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "title") as! String)
            }
            //changing it to Note() to be used by viewModel
            viewModel.notes = resultToNote(dataList: result as! [NSManagedObject])
        }
        catch {
            print("Failed")
        }
    }
    
    func resultToNote(dataList: [NSManagedObject]) -> [Note] {
        let noteArray = dataList.map {
            Note(title: $0.value(forKey: "title") as! String, text: $0.value(forKey: "text") as! String, lastEdited: $0.value(forKey: "lastEdited") as! Date)
        }
        return noteArray
    }
    
        
    func navigateToNewNote() {
        let outputView = NoteDetailView(viewModel: NoteViewModel(withNote: Note(title: "", text: "", lastEdited: Date())))
        self.navigationController?.pushViewController(outputView, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let count = viewModel.notes.count {
            return viewModel.notes.count
//        }
//        else {
//            return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableCell
        cell.configure(viewModel: viewModel.getNoteCellViewModel(atIndex: indexPath.row))
        //change the selected cell color
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.customColors.lilac.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectedView
        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return cell
    }
    
    //clicking
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let outputViewModel = viewModel.getNoteViewModel(atIndex: indexPath.row)
        let outputView = NoteDetailView(viewModel: outputViewModel)
        self.navigationController?.pushViewController(outputView, animated: true)
    }
    
    //sets height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
