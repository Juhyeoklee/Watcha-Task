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
    var gifs: [GIFObject] = []
    var keyword: String = ""
    var resultOffset: Int = 0
    var resultTotalCount: Int = 0
    
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
    
    private func searchFor(keyword: String, completion: @escaping ()->()) {
        var limit = 10
        let isFirst = (keyword != self.keyword)
        if self.resultOffset > self.resultTotalCount {
            self.resultOffset = self.resultTotalCount
            return
        }
        if isFirst {
            self.keyword = keyword
            limit = 15
            resultOffset = 0
        }
        
        GiphyAPIService.shared.search(for: keyword, limit: limit, offset: resultOffset) { networkResult in
            
            switch networkResult {
            case .success(let data):
                if let result = data as? JSON {
                    if isFirst {
                        self.resultTotalCount = result["pagination"]["total_count"].intValue
                        self.gifs = result["data"].arrayValue.compactMap {
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
                        
                    }
                    else {
                        let tmpArr: [GIFObject] = result["data"].arrayValue.compactMap {
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
                        
                        self.gifs.append(contentsOf: tmpArr)
                    }
//                    self.resultOffset += limit
                    
//                    if self.resultOffset > self.resultTotalCount {
//                        self.resultOffset = self.resultTotalCount
//                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
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
        self.resultOffset += limit
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
            searchFor(keyword: text) {
                self.reloadCollectionView()
            }
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

        cell.setImageWithLoading(urlString: gifs[indexPath.item].fixedWidthDownsampledURL)
        return cell
    }
}

// MARK:- UICollectionViewDelegate Extensions
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dvc = UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(identifier: "DetailVC") as? DetailVC {
            dvc.navigationItem.title = "결과"
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

extension SearchVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(searchResultCollectionView.contentOffset.y + searchResultCollectionView.bounds.height + 100,searchResultCollectionView.contentSize.height)
        
        if searchResultCollectionView.contentOffset.y + searchResultCollectionView.bounds.height ==
            searchResultCollectionView.contentSize.height {
            
            searchFor(keyword: keyword) {
                self.reloadCollectionView()
            }
        }
    }
}


// MARK:- WaterFallCollectionViewLayoutDelegate Extensions
extension SearchVC: WaterFallCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return gifs[indexPath.item].gifHeight
    }
}
