//
//  NoteCell.swift
//  potterly
//
//  Created by Alexandra Spirtes on 6/5/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import CoreData



class NoteAPI {
    static func getNotes() -> [Note]{
        let notes = [
            Note(title: "Glazes", text: "i think i want to try frose", date: "Friday"),
            Note(title: "to Make", text: "stuff to make", date: "06.01.19"),
            Note(title: "Comissions", text: "aduhfjhsdgfaksdfgakdjsgfakdjshgfakjsdgfakds", date: "05.30.19"),
            Note(title: "for Friends", text: "butter holder", date: "05.23.19"),
            Note(title: "Trimming", text: "jars", date: "05.20.19"),
            Note(title: "Christmas Market", text: "make sure you get booth!", date: "04.13.18"),
            Note(title: "Slip", text: "try pedros black", date: "03.12.18"),
            Note(title: "Luster Fire", text: "will happen in may", date: "03.11.18"),
            Note(title: "Retreats", text: "upstate new york thing", date: "03.10.18"),
        ]
        return notes
    }
}

class DataFunctions {
    func createData(){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let noteEntity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        //date stuff
        let isoDate = "2016-04-14T10:44:00+0000"
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from:isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        
        for i in 1...5 {
            
            let note = NSManagedObject(entity: noteEntity, insertInto: managedContext)
            note.setValue("note\(i)", forKey: "title")
            note.setValue("note text\(i)", forKey: "text")
            note.setValue(calendar.date(from:components), forKey: "timestamp")
        }
    
        //Now we have set all the values. The next step is to save them inside the Core Data
        
        do {
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func retrieveData() {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        //        fetchRequest.fetchLimit = 1
        //        fetchRequest.predicate = NSPredicate(format: "username = %@", "Ankur")
        //        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "email", ascending: false)]
        //
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! UUID)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    

}

class NoteTableViewCell: UITableViewCell {
    var note: Note? {
        didSet {
            guard let noteItem = note else {return}
            if let title = noteItem.title {
                titleLabel.text = title
            }
            if let date = noteItem.date {
                dateLabel.text = " \(date) "
            }
            
            if let text = noteItem.text {
                detailLabel.text = text
            }
        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Bold", size: 14)
        label.textColor = UIColor.customColors.midnight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.mauve
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.mauve
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.trailing.equalTo(contentView).offset(-10)
            make.height.equalTo(contentView).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(containerView)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel)
            make.leading.equalTo(dateLabel.snp.trailing).offset(10)
            make.width.equalTo(contentView).dividedBy(3)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(detailLabel)
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}

