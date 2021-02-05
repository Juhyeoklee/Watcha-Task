//
//  SearchVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

class SearchVC: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchResultCollectionView: UICollectionView! {
        didSet {
            searchResultCollectionView.delegate = self
            searchResultCollectionView.dataSource = self
            searchResultCollectionView.register(GIFImageCVCell.self,
                                                forCellWithReuseIdentifier: GIFImageCVCell.identifier)
            if let layout = searchResultCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
                layout.delegate = self
            }
        }
    }
    // MARK:- Member Variation
    // CollectionView Space 
    let lineSpacing: CGFloat = 5
    let itemSpacing: CGFloat = 5
    let horizontalSpacing: CGFloat = 5
    let verticalSpacing: CGFloat = 10
    var gifImageSizes: [CGFloat] = [100, 200, 50, 30, 90, 100, 100, 200, 300, 150, 90, 100, 100, 200, 300, 150]
    
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Search"
    }
    
    
    // MARK:- Member Method
    private func layoutInit() {
        self.tabBarController?.navigationItem.title = "Search"
        searchTextField.addLeftPadding(left: 20)
        searchTextField.makeRounded(cornerRadius: 20)
    }
}

// MARK:- UICollectionViewDataSource Extensions
extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifImageSizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFImageCVCell.identifier, for: indexPath) as? GIFImageCVCell else {
            return UICollectionViewCell()
        }
        cell.gifImageView.backgroundColor = .brown
        return cell
    }
}

// MARK:- UICollectionViewDelegate Extensions
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dvc = UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(identifier: "DetailVC") as? DetailVC {
            dvc.navigationItem.title = "결과"
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == gifImageSizes.count - 1 {
            
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchResultCollectionView.contentOffset.y + searchResultCollectionView.bounds.height == searchResultCollectionView.contentSize.height {
            
            gifImageSizes.append(contentsOf: [100, 100, 100, 200, 100])
            searchResultCollectionView.reloadData()
            
        }
    }
}


// MARK:- WaterFallCollectionViewLayoutDelegate Extensions
extension SearchVC: WaterFallCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return gifImageSizes[indexPath.item]
    }
}

//// MARK:- UICollectionViewDelegateFlowLayout Extensions
//extension SearchVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print(indexPath)
//        return CGSize(width: (collectionView.frame.width - itemSpacing - 2 * horizontalSpacing )/2, height: arr[indexPath.item])
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return itemSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return lineSpacing
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: verticalSpacing, left: horizontalSpacing, bottom: verticalSpacing, right: horizontalSpacing)
//    }
//}
