//
//  StageView.swift
//  potterly
//
//  Created by Alexandra Spirtes on 7/16/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import XLPagerTabStrip

class Stage: UIViewController, IndicatorInfoProvider {
    let viewModel: StageViewModel!
    let infoTitle: String

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
    
    //flower view
    let nothingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let image = UIImageView()
        image.image = UIImage(named: "flower")
        let label = UILabel()
        view.addSubview(image)
        return view
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
        
//        //nothing view constraints
//        nothingView.snp.makeConstraints { (make) in
//            make.centerX.centerY.equalTo(collectionView)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.addSubview(line)
        collectionView.delegate = self
        print(self.infoTitle)
        collectionView.dataSource = self
        collectionView.register(CeramicCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        view.addSubview(line)
        makeConstraints()
        viewModel.doubleSignal.observeValues(self.reloadData)
//        view.addSubview(nothingView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
        
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: self.infoTitle)
    }
    
    
    
    init(viewModel: StageViewModel, title: String, infoTitle: String) {
        self.viewModel = viewModel
        self.infoTitle = infoTitle
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension Stage: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemsCount(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CeramicCell
        cell.configure(viewModel: viewModel.getCeramicSectionViewModel(section: indexPath.section, atIndex: indexPath.row))
        cell.backgroundColor = UIColor.customColors.lilac
        //double tap
        let doubleTap = UITapGestureRecognizer()
        doubleTap.reactive.stateChanged.observeValues({_ in self.viewModel.doubleTap(indexPath: indexPath)})
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        cell.addGestureRecognizer(doubleTap)
        //single tap
        let singleTap = UITapGestureRecognizer()
        singleTap.reactive.stateChanged.observeValues({_ in self.viewModel.singleTap(indexPath: indexPath)})
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        cell.addGestureRecognizer(singleTap)
        singleTap.require(toFail: doubleTap)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
        
    @objc func gesture(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            print(indexPath)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sections = viewModel.getSectionCount()
        if sections == 0 {
            self.collectionView.backgroundView = self.nothingView
        }
        return sections
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    @available(iOS 13.0, *)
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let item = indexPath

          return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in

              // Create an action for sharing
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { _ in
                self.viewModel.edit(indexPath: item)
            }
            let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { _ in }
            let deleteConfirmation = UIAction(title: "Delete", image: UIImage(systemName: "checkmark"), attributes: .destructive) { _ in self.viewModel.delete(indexPath: item)
                self.collectionView.reloadData()
                //switch to deleteItem at
                
            }
            
            let delete = UIMenu(title: "Delete", image: UIImage(systemName: "trash"), options: .destructive, children: [deleteCancel, deleteConfirmation])

            return UIMenu(title: "", children: [edit, delete])
          }
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


