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
        
        collectionView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(self.line.snp.bottom).offset(32)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        line.snp.makeConstraints { (make) in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(line)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CeramicCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        makeConstraints()
    //    viewModel.singleSignal.observeValues(self.printMe)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "my pots"
        self.collectionView.reloadData()
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
        return viewModel.getItemsCount(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CeramicCell
            cell.configure(viewModel: viewModel.getCeramicSectionViewModel(index: indexPath))
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
        return viewModel.getSectionCount()
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
                let vm = self.viewModel.edit(indexPath: item)
                let vc = UINavigationController(rootViewController: AddCeramicView(viewModel: vm))
                vc.navigationBar.isTranslucent = false
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
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
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.singleTap(section: indexPath.section, row: indexPath.row)
//    //    guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
            case UICollectionView.elementKindSectionHeader:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! SectionHeader
                headerView.configure(viewModel: viewModel.getSectionViewModel(date: viewModel.distinctDates[indexPath.section]))
              //  headerView.backgroundColor = .blue
                return headerView
            default:
                fatalError("Unexpected element kind")
        }
        }
    }




