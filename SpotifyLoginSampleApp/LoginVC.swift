//
//  LoginVC.swift
//  SpotifyLoginSampleApp
//
//  Created by YONGCHEOL LEE on 2021/11/19.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton,
         appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide navigation Bar
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        // Google Sign In
        GIDSignIn.sharedInstance.signIn(
            with: (UIApplication.shared.delegate as! AppDelegate).GIDSignInConfig!,
            presenting: self,
            callback: { user, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                guard let user = user else { return }
                
                user.authentication.do { authentication, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    guard let authentication = authentication else { return }
                    let idToken = authentication.idToken!
                    let accessToken = authentication.accessToken
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                    
                    Auth.auth().signIn(with: credential) { [weak self] _, _ in
                        self?.showMainViewController()
                    }
                }
            }
        )
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: Any) {
        
    }
    
    private func showMainViewController() {
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainVC = storyboard.instantiateViewController(identifier: "MainViewController")

        mainVC.modalPresentationStyle = .fullScreen
        UIApplication.shared.windows.first?.rootViewController?.show(mainVC, sender: nil)
    }
}
