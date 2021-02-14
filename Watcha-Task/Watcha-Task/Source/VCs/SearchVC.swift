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
            searchResultCollectionView
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
    lazy var emptyView: UILabel = {
        let label = UILabel()
        label.text = "Empty Result"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let initialLimit: Int = 15
    let paginationLimit: Int = 10
    
    var searchState: ImageState = .gif
    
    var gifs: [ImageObject] = [] {
        didSet {
            reloadCollectionView()
        }
    }
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
        searchButton.tintColor = .pointColor
        searchTextField.addLeftPadding(left: 20)
        searchTextField.makeRounded(cornerRadius: 20)
        
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: searchResultCollectionView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: searchResultCollectionView.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: searchResultCollectionView.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: searchResultCollectionView.bottomAnchor)
        ])
    }
    
    
    private func searchFor(keyword: String,
                           limit: Int,
                           completion: @escaping ([ImageObject]) -> Void) {
        
        GiphyAPIService.shared.search(for: keyword,
                                      limit: limit,
                                      offset: resultOffset,
                                      state: searchState) { networkResult in
        
            switch networkResult {
            case .success(let result):
                if let result = result as? (Int, [ImageObject]) {
                    self.resultTotalCount = result.0
                    completion(result.1)
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
    
    private func updateResultFor(keyword: String) {
        self.keyword = keyword
        resultOffset = 0
        searchFor(keyword: keyword, limit: initialLimit) { [weak self] result in
            guard let self = self else { return }
            self.gifs = result
            
            if self.gifs.count == 0 {
                self.setEmptyView(state: true)
            }
            else {
                self.setEmptyView(state: false)
            }
            self.resultOffset += self.initialLimit
        }
    }
    
    private func appendResultFor() {
        searchFor(keyword: self.keyword, limit: paginationLimit) { [weak self] result in
            guard let self = self else { return }
            self.gifs.append(contentsOf: result)
            self.resultOffset += self.paginationLimit
            
            if self.resultOffset > self.resultTotalCount {
                self.resultOffset = self.resultTotalCount
            }
        }
    }
    
    private func reloadCollectionView() {
        if let layout = searchResultCollectionView.collectionViewLayout as? WaterFallCollectionViewLayout {
            layout.removeAllCache()
        }
        
        searchResultCollectionView.reloadData()
    }
    
    private func setEmptyView(state: Bool) {
        emptyView.isHidden = !state
    }
}

// MARK:- UITextFieldDelegate Extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
           text.count > 0 {
            updateResultFor(keyword: text)
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
        if searchState == .sticker {
            cell.gifImageView.backgroundColor = .systemGray6
        }
        cell.setImageWithLoading(urlString: gifs[indexPath.item].fixedWidthDownsampledURL)
        return cell
    }
}

// MARK:- UICollectionViewDelegate Extensions
extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let dvc = UIStoryboard
            .detail
            .instantiateViewController(identifier: "DetailVC") as? DetailVC {
            dvc.gifData = gifs[indexPath.item]
            dvc.imageState = searchState
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

// MARK:- UIScrollViewDelegate Extensions
extension SearchVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetMaxY = scrollView.contentOffset.y + scrollView.bounds.height
        let loadingOffset = scrollView.contentSize.height
        
        if currentOffsetMaxY == loadingOffset {
            appendResultFor()
        }
    }
}


// MARK:- WaterFallCollectionViewLayoutDelegate Extensions
extension SearchVC: WaterFallCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return gifs[indexPath.item].fixedWidthDownsampledHeight
    }
}

// MARK:- CategoryTabBarDelegate Extensions
extension SearchVC: CategoryTabBarDelegate {
    func touchUpTabButton(state: ImageState) {
        searchState = state
        if let text = searchTextField.text, text.count > 0{
            updateResultFor(keyword: text)
        }
    }
}
