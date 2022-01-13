//
//  HomeViewController.swift
//  Instagram
//
//  Created by 1 on 08/01/22.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        
        
        
        
    }
    private func handleNotAuthenticated() {
        // Check auth status
        if Auth.auth().currentUser ==  nil {
            // Show login
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
            
        }
    }
    
    
    
    
    
}
