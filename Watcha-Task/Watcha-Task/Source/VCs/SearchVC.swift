//
//  SearchVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

import SwiftyJSON

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
            if let layout = searchResultCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
                layout.delegate = self
            }
            searchResultCollectionView.delegate = self
            searchResultCollectionView.dataSource = self
            searchResultCollectionView.register(GIFImageCVCell.self,
                                                forCellWithReuseIdentifier: GIFImageCVCell.identifier)
            
        }
    }
    // MARK:- Member Variation
    var gifLinks: [String] = []
    var gifs: [GIFObject] = []
    var gifImageSizes: [CGFloat] = []
    var page: Int = 0
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Search"
        reloadCollectionView()
    }
    
    // MARK:- IBAction Method
    
    @IBAction func touchUpSearchButton(_ sender: UIButton) {
        searchTextField.endEditing(false)
    }
    
    // MARK:- Member Method
    private func layoutInit() {
        tabBarController?.navigationItem.title = "Search"
        searchTextField.addLeftPadding(left: 20)
        searchTextField.makeRounded(cornerRadius: 20)
    }
    
    private func searchFor(keyword: String) {
        GiphyAPIService.shared.search(for: keyword, limit: 10) { networkResult in
            
            switch networkResult {
            case .success(let data):
                if let result = data as? JSON {
                    self.gifs = result.arrayValue.compactMap {
                        var gif = GIFObject()
                        
                        gif.id = $0["id"].stringValue
                        gif.title = $0["title"].stringValue
                        gif.userName = $0["user"]["username"].stringValue
                        gif.userDisPlayName = $0["user"]["display_name"].stringValue
                        gif.fixedWidthDownsampledURL = $0["images"]["fixed_width_downsampled"]["url"].stringValue
                        gif.originalURL = $0["images"]["original"]["url"].stringValue
                        gif.gifHeight = $0["images"]["fixed_width_downsampled"]["height"].floatValue.toCGFloat()
                        
                        return gif
                    }
                    self.reloadCollectionView()
                }
            case .requestErr(let msg):
                print(msg as? String ?? "")
            case .pathErr:
                print("pathErr")
            case .networkFail:
                print("networkFail")
            default:
                print("err")
            }
        }
    }
    
    private func reloadCollectionView() {
        if let layout = searchResultCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
            layout.removeAllCache()
        }
        
        searchResultCollectionView.reloadData()
    }
}

// MARK:- UITextFieldDelegate Extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
           text.count > 0 {
            searchFor(keyword: text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(false)
        return true
    }
}

// MARK:- UICollectionViewDataSource Extensions
extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GIFImageCVCell.identifier, for: indexPath) as? GIFImageCVCell else {
            return UICollectionViewCell()
        }
        cell.gifImageView.imageFromUrl(gifs[indexPath.item].fixedWidthDownsampledURL)
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
            
//            gifImageSizes.append(contentsOf: [100, 100, 100, 200, 100])
//            searchResultCollectionView.reloadData()
            
        }
    }
}


// MARK:- WaterFallCollectionViewLayoutDelegate Extensions
extension SearchVC: WaterFallCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return gifs[indexPath.item].gifHeight
    }
}
