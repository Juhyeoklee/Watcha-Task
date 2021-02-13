//
//  FavoritesVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

import SwiftyJSON

class FavoritesVC: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView! {
        didSet {
            if let layout = favoritesCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
                layout.delegate = self
            }
            favoritesCollectionView.dataSource = self
            favoritesCollectionView.delegate = self
            
            favoritesCollectionView
                .register(GIFImageCVCell.self,
                          forCellWithReuseIdentifier: GIFImageCVCell.identifier)
        }
    }
    @IBOutlet weak var categoryTabBarView: CategoryTabBarView! {
        didSet {
            categoryTabBarView.delegate = self
            categoryTabBarView.changeStyle(to: .dark)
        }
    }
    
    
    // MARK:- Member Variation
    let initialLimit: Int = 15
    let paginationLimit: Int = 10
    
    var ids: [String] = []
    var gifs: [GIFObject] = []
    var imageState: ImageState = .gif
    
    var resultOffset: Int = 0
    var resultTotalCount: Int = 0

    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Favorites"
        updateLikeIDsbyInAppData()
        updateGIFData()
    }
    
    // MARK:- Member Method
    private func updateLikeIDsbyInAppData() {
        ids = DataManager.shared.fetchData(as: imageState)
        resultTotalCount = ids.count
    }
    
    private func updateGIFData() {
        resultOffset = 0
        
        let lowerBounds = resultOffset
        let upperBounds = resultOffset + initialLimit > ids.count ? ids.count : resultOffset + initialLimit
        let ids = makeArrayToString(arr: makeRange(lowerBounds: lowerBounds, upperBounds: upperBounds))
        
        if ids.count == 0 {
            gifs = []
            reloadCollectionView()
            return
        }
        
        fetchGIFs(ids: ids, limit: initialLimit) { [weak self] result in
            guard let self = self else { return }
            self.gifs = result
            self.resultOffset += self.initialLimit
            
            self.reloadCollectionView()
        }
    }
    
    private func appendGIFData() {
        let lowerBounds = resultOffset
        let upperBounds = resultOffset + paginationLimit > ids.count ? ids.count : resultOffset + paginationLimit
        let ids = makeArrayToString(arr: makeRange(lowerBounds: lowerBounds, upperBounds: upperBounds))
        
        if lowerBounds == upperBounds {
            return
        }
        
        fetchGIFs(ids: ids ,limit: paginationLimit) { [weak self] result in
            guard let self = self else { return }
            
            self.gifs.append(contentsOf: result)
            self.resultOffset += self.paginationLimit
            
            if self.resultOffset > self.resultTotalCount {
                self.resultOffset = self.resultTotalCount
            }
            self.reloadCollectionView()
        }
    }
    
    private func reloadCollectionView() {
        if let layout = favoritesCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
            layout.removeAllCache()
        }
        
        favoritesCollectionView.reloadData()
    }
    
    private func makeRange(lowerBounds: Int, upperBounds: Int) -> [String] {
        
        return ids[lowerBounds..<upperBounds].map{ return $0 }
    }
    
    private func fetchGIFs(ids: String
                           ,limit: Int,
                           completion: @escaping ([GIFObject]) -> Void) {
        GiphyAPIService.shared.fetchLikeGIFData(ids: ids,
                                                limit: limit){ networkResult in
            switch networkResult {
            case .success(let result):
                
                if let result = result as? (Int, [GIFObject]) {
                    
                    completion(result.1)
                }
//
//                if let data = json as? JSON {
//                    let result:[GIFObject] = data["data"].arrayValue.compactMap {
//                        let user = $0["user"]
//                        let images = $0["images"]
//                        let sampleImage = images["fixed_width_downsampled"]
//                        let originalImage = images["original"]
//
//                        return GIFObject(id: $0["id"].stringValue,
//                                         title: $0["title"].stringValue,
//                                         userDisPlayName: user["display_name"].stringValue,
//                                         userName: user["username"].stringValue,
//                                         source: $0["source"].stringValue,
//                                         fixedWidthDownsampledURL: sampleImage["url"].stringValue,
//                                         fixedWidthDownsampledHeight: sampleImage["height"].floatValue.toCGFloat(),
//                                         originalURL: originalImage["url"].stringValue,
//                                         originalHeight: originalImage["height"].floatValue.toCGFloat())
//                    }
//
//                    completion(result)
//                }
            case .requestErr(let msg):
                print(msg as? String ?? "")
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("sererErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    private func makeArrayToString(arr: [String]) -> String {
        var result = ""
        
        for i in 0..<arr.count {
            if i == arr.count - 1 {
                result += arr[i]
            }
            else {
                result += "\(arr[i]),"
            }
        }
        
        return result
    }
}

// MARK:- UICollectionViewDelegate Extensions
extension FavoritesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dvc = UIStoryboard(name: "Detail", bundle: nil)
            .instantiateViewController(identifier: "DetailVC") as? DetailVC {
            dvc.navigationItem.title = "결과"
            dvc.gifData = gifs[indexPath.item]
            dvc.imageState = imageState
            self.navigationController?.pushViewController(dvc, animated: true)
        }
    }
}
// MARK:- UICollectionViewDataSource Extensions
extension FavoritesVC: UICollectionViewDataSource {
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

// MARK:- WaterFallCollectionViewLayoutDelegate Extensions
extension FavoritesVC: WaterFallCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return gifs[indexPath.item].fixedWidthDownsampledHeight
    }
}

// MARK:- CategoryTabBarDelegate Extensions
extension FavoritesVC: CategoryTabBarDelegate {
    func touchUpTabButton(state: ImageState) {
        imageState = state
        updateLikeIDsbyInAppData()
        updateGIFData()
    }
}

// MARK:- UIScrollViewDelegate Extensions
extension FavoritesVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if favoritesCollectionView.contentOffset.y + favoritesCollectionView.bounds.height ==
            favoritesCollectionView.contentSize.height {
            appendGIFData()
        }
    }
}
