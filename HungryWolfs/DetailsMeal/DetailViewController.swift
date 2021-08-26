//
//  DetailViewController.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 18.08.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController
{
    
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var measure1Label: UILabel!
    @IBOutlet weak var measure2Label: UILabel!
    @IBOutlet weak var measure3Label: UILabel!
    @IBOutlet weak var ingredient1Label: UILabel!
    @IBOutlet weak var ingredient2Label: UILabel!
    @IBOutlet weak var ingredient3Label: UILabel!
    @IBOutlet weak var mealTag1Label: UILabel!
    @IBOutlet weak var mealTag2Label: UILabel!
    @IBOutlet weak var mealTag3Label: UILabel!
    @IBOutlet weak var mealDescription: UILabel!
    @IBOutlet weak var checkButton1: UIButton!
    @IBOutlet weak var checkButton2: UIButton!
    @IBOutlet weak var checkButton3: UIButton!
    @IBOutlet weak var tagView1: UIView!
    @IBOutlet weak var tagView2: UIView!
    @IBOutlet weak var tagView3: UIView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var id = ""
    
    var favId = ""
    var favName = ""
    var favImg = ""
    
    private let viewModelDetails: DetailsViewModel = DetailsViewModel()
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // butoanele bifabile
        checkButton1.setImage(UIImage(systemName: "checkmark.square"),
                          for: [.selected])
        checkButton2.setImage(UIImage(systemName: "checkmark.square"),
                          for: [.selected])
        checkButton3.setImage(UIImage(systemName: "checkmark.square"),
                          for: [.selected])
        
    
        viewModelDetails.getDetails(id: id, completion: { [weak self] in
            
            // pentru favourites
            guard let self = self else { return }
            self.favName = self.viewModelDetails.details[0].name
            self.favImg = self.viewModelDetails.details[0].thumb
            self.favId = self.viewModelDetails.details[0].id

            // pentru details
            self.mealNameLabel.text = self.viewModelDetails.details[0].name
                        
            guard let imageURL = URL(string: (self.viewModelDetails.details[0].thumb)) else { return }
            self.mealImage.kf.setImage(with: imageURL)
            self.mealImage.layer.masksToBounds = true
            self.mealImage.layer.cornerRadius = (self.mealImage.bounds.width) / 2
            
            self.measure1Label.text = self.viewModelDetails.details[0].measure1
            self.measure2Label.text = self.viewModelDetails.details[0].measure2
            self.measure3Label.text = self.viewModelDetails.details[0].measure3
            self.ingredient1Label.text = self.viewModelDetails.details[0].ingredient1
            self.ingredient2Label.text = self.viewModelDetails.details[0].ingredient2
            self.ingredient3Label.text = self.viewModelDetails.details[0].ingredient3
            self.mealDescription.text = self.viewModelDetails.details[0].instructions
            // tagurile
            let array = self.viewModelDetails.details[0].tags
            let tagList = array?.components(separatedBy: ",")
            if tagList?.count == 1
            {
                self.mealTag1Label.text = tagList?[0]
                self.configureView1()
            }
            else if tagList?.count == 2
            {
                self.mealTag1Label.text = tagList?[0]
                self.configureView1()
                self.mealTag2Label.text = tagList?[1]
                self.configureView2()
            }
            else if tagList?.count == 3
            {
                self.mealTag1Label.text = tagList?[0]
                self.configureView1()
                self.mealTag2Label.text = tagList?[1]
                self.configureView2()
                self.mealTag3Label.text = tagList?[2]
                self.configureView3()
            }
        })

        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            self.showOfflinePage()
        }
    }
    
    func configureView1()
    {
        self.tagView1.layer.cornerRadius = 15
        self.tagView1.clipsToBounds = true
        self.tagView1.layer.borderWidth = 1
        self.tagView1.layer.borderColor = UIColor.red.cgColor
    }
    
    func configureView2()
    {
        self.tagView2.layer.cornerRadius = 15
        self.tagView2.clipsToBounds = true
        self.tagView2.layer.borderWidth = 1
        self.tagView2.layer.borderColor = UIColor.red.cgColor
    }
    
    func configureView3()
    {
        self.tagView3.layer.cornerRadius = 15
        self.tagView3.clipsToBounds = true
        self.tagView3.layer.borderWidth = 1
        self.tagView3.layer.borderColor = UIColor.red.cgColor
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
    
    @IBAction func backButtnTapped(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // butoanele bifabile
    @IBAction func toggleButton(_ sender: UIButton)
    {
      sender.isSelected.toggle()
    }
    
    // buton preferate 
    @IBAction func favouriteButton(_ sender: UIButton)
    {
        let meal = Meal(name: favName, thumb: favImg, id: favId)
        
        sender.isSelected.toggle()
        if favouriteButton.isSelected{
            if favourite.contains(meal){
                favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: [.selected])
            }
            else{
                favourite.append(meal)
                favouriteButton.setImage(UIImage(systemName: "heart.fill"), for: [.selected])
            }
        }
    }
 
}


