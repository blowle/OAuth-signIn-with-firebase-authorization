//
//  EnterEmailVC.swift
//  SpotifyLoginSampleApp
//
//  Created by YONGCHEOL LEE on 2021/11/19.
//

import UIKit
import FirebaseAuth

class EnterEmailVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMassageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // show navigation bar
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        // Firebase email/password auth
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // new user creation
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // already created email
                    // do login
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMassageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        })
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMassageLabel.text = error.localizedDescription
            } else {
                
            }
        }
        
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainVC = storyboard.instantiateViewController(identifier: "MainViewController")
        mainVC.modalPresentationStyle = .fullScreen
        navigationController?.show(mainVC, sender: nil)
    }
}

extension EnterEmailVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
