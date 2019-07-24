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
        viewModel.singleSignal.observeValues(self.printMe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "finished work"
    }
    
    func printMe() {
        print("tapped collection Item")
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
            cell.configure(viewModel: viewModel.getCeramicSectionViewModel(section: indexPath.section, atIndex: indexPath.row))
            //uiimageview mode how to display the image scale aspect fit
            cell.backgroundColor = UIColor.customColors.lilac
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
        return viewModel.sections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.singleTap(section: indexPath.section, row: indexPath.row)
    //    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
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




