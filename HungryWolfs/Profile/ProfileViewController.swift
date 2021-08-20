//
//  ProfileViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 19.08.2021.
//

import UIKit

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
        
        if let url = NSURL(string: "https://www.wolfpack-digital.com/privacy") {
        UIApplication.shared.open(url as URL, options:[:], completionHandler:nil)
        }
    }

}
