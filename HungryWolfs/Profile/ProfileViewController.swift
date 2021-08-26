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
        
        //internet connection
        NetworkManager.isUnreachable { _ in self.showOfflinePage() }
    }
    
    // internet connection
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let internetConnectionViewController = mainStoryboard.instantiateViewController(identifier: "InternetConnectionScreen")
            internetConnectionViewController.modalPresentationStyle = .fullScreen
            self.present(internetConnectionViewController, animated: true)
        }
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
