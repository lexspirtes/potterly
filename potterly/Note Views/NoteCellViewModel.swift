//
//  NoteCellViewModel.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/6/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//
import UIKit
import RxCocoa
import ReactiveSwift

struct Note {
    let title:String?
    let text:String?
    let date:String?
}

struct Notes {
    let notes = MutableProperty([Note]())
}


//final class DemoViewController: UITableViewController {
//    fileprivate var sortedIntegers = [1, 2, 3]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
//        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewInteger))
//        navigationItem.rightBarButtonItem = addButtonItem
//    }
//    @objc func addNewInteger() {
//        let number = Int(arc4random_uniform(10))
//        let insertionIndex = (sortedIntegers.count-1)
//        sortedIntegers.insert(number, at: insertionIndex)
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: insertionIndex, section: 0)], with: .automatic)
//        tableView.endUpdates()
//    }
//}
//extension DemoViewController {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return sortedIntegers.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
//        cell.textLabel?.text = "\(sortedIntegers[indexPath.row])"
//        return cell
//    }
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        guard editingStyle == .delete else { return }
//        sortedIntegers.remove(at: indexPath.row)
//        tableView.beginUpdates()
//        tableView.deleteRows(at: [indexPath], with: .automatic)
//        tableView.endUpdates()
//    }
//}

//MVVM

extension Array where Element: Comparable {
    func upperBoundary(of key: Element) -> Index {
        var low = startIndex
        var high = endIndex
        while low < high {
            let mid = low + (high - low) / 2
            if self[mid] <= key {
                low = mid + 1
            } else {
                high = mid
            }
        }
        
        return low
    }
}

struct State {
    enum EditingStyle {
        case insert(Int, IndexPath)
        case delete(IndexPath)
        case none
    }
    
    private(set) var sortedIntegers: [Int]
    var editingStyle: EditingStyle {
        didSet {
            switch editingStyle {
            case let .insert(new, indexPath):
                sortedIntegers.insert(new, at: indexPath.row)
            case let .delete(indexPath):
                sortedIntegers.remove(at: indexPath.row)
            default:
                break
            }
        }
    }
    
    init(sortedIntegers: [Int]) {
        self.sortedIntegers = sortedIntegers
        self.editingStyle = .none
    }
    
    func text(at indexPath: IndexPath) -> String {
        return "\(sortedIntegers[indexPath.row])"
    }
}

final class DemoViewModel {
    private(set) var state = State(sortedIntegers: [1, 2, 3]) {
        didSet {
            callback(state)
        }
    }
    let callback: (State) -> ()
    
    init(callback: @escaping (State) -> ()) {
        self.callback = callback
    }
    
    func addNewInteger() {
        let integer = Int(arc4random_uniform(10))
        let insertionIndex = state.sortedIntegers.upperBoundary(of: integer)
        state.editingStyle = .insert(integer, IndexPath(row: insertionIndex, section: 0))
    }
    
    func removeInteger(at indexPath: IndexPath) {
        state.editingStyle = .delete(indexPath)
    }
}

final class DemoViewController: UITableViewController {
    fileprivate var viewModel: DemoViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let buttonView = UIButton()
        buttonView.setImage(UIImage(named: "potsmall"), for: .normal)
        buttonView.addTarget(self, action: #selector(addNewInteger), for: UIControl.Event.touchUpInside)
        let button = UIBarButtonItem(customView: buttonView)
//        let addButtonItem = UIBarButtonItem(barButtonSystemItem: buttonView, target: self, action: #selector(addNewInteger))
        self.tabBarController?.navigationItem.rightBarButtonItem = button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        
       
        
        viewModel = DemoViewModel { [unowned self] (state) in
            switch state.editingStyle {
            case .none:
                self.tableView.reloadData()
            case let .insert(_, indexPath):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            case let .delete(indexPath):
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
        }
    }
    
    @objc func addNewInteger() {
        viewModel?.addNewInteger()
    }
}

extension DemoViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.state.sortedIntegers.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.text = viewModel?.state.text(at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        viewModel?.removeInteger(at: indexPath)
    }
}
