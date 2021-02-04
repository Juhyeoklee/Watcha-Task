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
    
    // MARK:- Member Variation
    
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutInit()
        
    }
    
    // MARK:- Member Method
    private func layoutInit() {
        searchTextField.addLeftPadding(left: 20)
        searchTextField.makeRounded(cornerRadius: 20)
    }
}
