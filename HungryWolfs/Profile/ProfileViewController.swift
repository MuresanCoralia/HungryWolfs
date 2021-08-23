//
//  ProfileViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 19.08.2021.
//

import UIKit
import SafariServices

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstView.layer.cornerRadius = 30
        secondView.layer.cornerRadius = 30
        thirdView.layer.cornerRadius = 30
    }
    
    @IBAction func termsAndConditions(_ sender: Any){
        
        if let url = URL(string: "https://www.wolfpack-digital.com/privacy"){
            
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backFavoritesButton(_ sender: Any) {
        tabBarController?.selectedIndex = 1
    }
}
