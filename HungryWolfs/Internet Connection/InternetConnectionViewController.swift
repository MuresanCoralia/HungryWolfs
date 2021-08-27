//
//  InternetConnectionViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 23.08.2021.
//

import UIKit
import Reachability

class InternetConnectionViewController: UIViewController {

    @IBOutlet weak var tryAgainButton: UIButton!
   
    let network = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tryAgainButton.layer.cornerRadius = 30
        tryAgainButton.backgroundColor = .red
        
        NetworkManager.isReachable { _ in self.showOnlinePage() }
        network.reachability.whenReachable = { _ in self.showOnline() }
    }

    private func showOnlinePage() -> Void {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func showOnline() -> Void {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
