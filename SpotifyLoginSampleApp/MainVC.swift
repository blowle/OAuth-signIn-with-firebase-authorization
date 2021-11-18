//
//  MainVC.swift
//  SpotifyLoginSampleApp
//
//  Created by YONGCHEOL LEE on 2021/11/19.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
