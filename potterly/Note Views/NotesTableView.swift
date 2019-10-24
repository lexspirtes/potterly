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
        notesTableView.backgroundColor = .white
        self.title = "notes"
        notesTableView.separatorColor = UIColor.customColors.lilac
        notesTableView.tableHeaderView = cellLabel
        view.addSubview(notesTableView)
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
        makeConstraints()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(NoteTableCell.self, forCellReuseIdentifier: "noteCell")
        
        viewModel.buttonSignal.observeValues(self.navigateToNewNote)
    }
    
    let helloLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Bold", size: 30)
        label.textColor = UIColor.customColors.midnight
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.text = "hi"
        return label
    }()
    
    //an oops add something
    func showFlower() {
        if viewModel.notes.count == 0 {
            self.view.addSubview(helloLabel)
            helloLabel.snp.makeConstraints { (make) in
                 make.centerX.centerY.equalTo(view)
            }
        }
        else {}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "notes"
        super.viewWillAppear(animated)
        notesTableView.reloadData()
        //bar button comes up every time the view is loaded
        let buttonView = UIButton()
        buttonView.setImage(UIImage(named: "create"), for: .normal)
        
        let button = UIBarButtonItem(customView: buttonView)
        buttonView.reactive.controlEvents(.touchUpInside).observeValues { _ in self.viewModel.tapButton() }
        self.tabBarController?.navigationItem.rightBarButtonItem = button

    }
    
    
        
    func navigateToNewNote() {
        let outputView = NoteDetailView(viewModel: viewModel.getNewNoteViewModel())
        self.navigationController?.pushViewController(outputView, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.notes.count
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
        let outputViewModel = viewModel.getNoteViewModel(atIndex: indexPath.row)
        let outputView = NoteDetailView(viewModel: outputViewModel)
        self.navigationController?.pushViewController(outputView, animated: true)
    }
    
    //sets height of each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          viewModel.deleteNote(atIndex: indexPath.row)
            self.notesTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

