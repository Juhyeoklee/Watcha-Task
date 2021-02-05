//
//  DetailVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/05.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK:- IBOutlet Variation
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    // MARK:- Member Variation
    var gifImageTitle: String = "Title"
    
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = gifImageTitle
    }
    
}
