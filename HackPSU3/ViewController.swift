//
//  ViewController.swift
//  HackPSU3
//
//  Created by Finn McSorley on 11/7/20.
//

import UIKit
import Firebase
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loginButtonTapped(_ sender: Any) {
        if let authUI = FUIAuth.defaultAuthUI(){
            authUI.providers = [FUIOAuth.appleAuthProvider()]
            authUI.delegate = self
            
            let authViewController = authUI.authViewController()
            self.present(authViewController, animated: true)
        }
    }
    func authUI( authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?){
        if let user = authDataResult?.user{
            print("User: \(user.uid)")
        }
    }
}

