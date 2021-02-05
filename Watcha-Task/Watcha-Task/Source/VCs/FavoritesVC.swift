//
//  FavoritesVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView! {
        didSet {
            favoritesCollectionView.dataSource = self
            favoritesCollectionView.delegate = self
            
            favoritesCollectionView
                .register(ProfileHeaderCollectionReusableView.self,
                          forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                          withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier)
            
            favoritesCollectionView
                .register(GIFImageCVCell.self,
                          forCellWithReuseIdentifier: GIFImageCVCell.identifier)
            if let layout = favoritesCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
                layout.delegate = self
            }
            
        }
    }
    
    var gifImageSizes: [CGFloat] = [100, 200, 50, 30, 90, 100, 100, 200, 300, 150, 200, 300, 100, 200, 300]
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Favorites"
    }
}

extension FavoritesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dvc = UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(identifier: "DetailVC") as? DetailVC {
            dvc.navigationItem.title = "결과"
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension FavoritesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFImageCVCell.identifier, for: indexPath) as? GIFImageCVCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print(indexPath)
        
        
        if kind == UICollectionView.elementKindSectionHeader {
            if let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: ProfileHeaderCollectionReusableView.identifier,
                                                  for: indexPath) as? ProfileHeaderCollectionReusableView {
                return header
            }
        }
        return UICollectionReusableView()
    }
    
}

//extension FavoritesVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 200)
//    }
//}

// MARK:- WaterFallCollectionViewLayoutDelegate Extensions
extension FavoritesVC: WaterFallCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return gifImageSizes[indexPath.item]
    }
}
