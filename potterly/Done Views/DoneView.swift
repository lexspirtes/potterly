//
//  DoneView.swift
//  potterly
//
//  Created by Lex Spirtes on 5/31/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

//placeholder of DoneView
class DoneStage: UIViewController {
    let viewModel: StageViewModel!
    
    let cellId = "cellId"
    let headerId = "headerId"

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.darkGray
        collection.isScrollEnabled = true
        // collection.contentSize = CGSize(width: 2000 , height: 400)
        return collection
    }()
    
    let line: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.customColors.lilac
        return lineView
    }()
    
    func makeConstraints() {
        //        scrollView.snp.makeConstraints { (make) in
        //            make.top.trailing.bottom.leading.equalTo(view.safeAreaLayoutGuide)
        //        }
        
        collectionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        line.snp.makeConstraints { (make) in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.top.equalTo(view.safeAreaLayoutGuide)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.addSubview(line)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CeramicCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        //  collectionView.addSubview(line)
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "finished work"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    init(viewModel: StageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DoneStage: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalForDates()[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CeramicCell
            cell.configure(viewModel: viewModel.getCeramicCellViewModel(atIndex: indexPath.row))
            //uiimageview mode how to display the image scale aspect fit
            cell.backgroundColor = UIColor.customColors.midnight
            cell.layer.cornerRadius = 5
            return cell
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(viewModel.getDates())
        return viewModel.sections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SectionHeader
                headerView.configure(viewModel: viewModel.getSectionViewModel(date: viewModel.getDates()[indexPath.section]))
              //  headerView.backgroundColor = .blue
                return headerView
            default:
                assert(false, "Unexpected element kind")
        }
        }
    }


class SectionViewModel {
    let date: String
    
    init(date: Date) {
        self.date = SectionViewModel.DateFormat(date: date)
    }
    
    class func DateFormat(date: Date) -> String{
        let today = Date()
        let formatter = DateFormatter()
        //set from data timestamp
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: date)
        let newDate = formatter.date(from: dateString)
        if today.days(from: date) < 1 {
            return "Today"
        }
        else if today.days(from: date) < 2 {
            return "Yesterday"
        }
        else if today.days(from: date) < 7 {
            formatter.dateFormat = "EEEE"
        }
            
        else {
            formatter.dateFormat = "MM.dd.YY"
        }
        
        let formattedString = formatter.string(from: newDate!)
        return formattedString
    }
}

class SectionHeader: UICollectionReusableView {
    var viewModel: SectionViewModel!
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Karla-Regular", size: 12)
        label.textColor = UIColor.customColors.midnight
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
//    func makeConstraints() {
//        containerView.snp.makeConstraints { (make) in
//        //    make.centerY.center.equalTo(self.view)
//            make.leading.equalTo(self.view).offset(10)
//            make.trailing.equalTo(self.view).offset(-10)
//            make.height.equalTo(self.view)
//        }
//
//        titleLabel.snp.makeConstraints { (make) in
//            make.top.leading.trailing.equalTo(containerView)
//        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: SectionViewModel){
        self.viewModel = viewModel
        //setting the label text
        dateLabel.text = viewModel.date
        
    }
    convenience init(frame: CGRect, viewModel: SectionViewModel){
        self.init(frame: frame)
        self.viewModel = viewModel
    }
        
    override init(frame: CGRect){
        super.init(frame: frame)
        self.addSubview(dateLabel)
        makeConstraints()
    }
    
    func makeConstraints() {
        dateLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(6)
            make.centerY.equalTo(self.snp.centerY).offset(6)
        }
    }
}
