//
//  SearchVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

class SearchVC: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
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
    var gifImageSizes: [CGFloat] = [100, 200, 50, 30, 90, 100, 100, 200, 300, 150, 90, 100, 100, 200, 300, 150]
    
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "Search"
    }
    
    // MARK:- IBAction Method
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        searchTextField.endEditing(false)
    }
    
    // MARK:- Member Method
    private func layoutInit() {
        self.tabBarController?.navigationItem.title = "Search"
        searchTextField.addLeftPadding(left: 20)
        searchTextField.makeRounded(cornerRadius: 20)
    }
}

// MARK:- UITextFieldDelegate Extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        gifImageSizes.removeAll()
        if let layout = searchResultCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
            layout.removeAllCache()
        }
        
        searchResultCollectionView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
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
}

extension SearchVC: UIScrollViewDelegate {
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
