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
    
    private let viewModelDetails: DetailsViewModel = DetailsViewModel()
    private let viewModelMeal: MealsViewModel = MealsViewModel()
    
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
            self?.mealNameLabel.text = self?.viewModelDetails.details[0].name
           
            guard let imageURL = URL(string: (self?.viewModelDetails.details[0].thumb)!) else { return }
            self?.mealImage.kf.setImage(with: imageURL)
            self?.mealImage.layer.masksToBounds = true
            self?.mealImage.layer.cornerRadius = (self?.mealImage.bounds.width)! / 2

            
            self?.measure1Label.text = self?.viewModelDetails.details[0].measure1
            self?.measure2Label.text = self?.viewModelDetails.details[0].measure2
            self?.measure3Label.text = self?.viewModelDetails.details[0].measure3
            self?.ingredient1Label.text = self?.viewModelDetails.details[0].ingredient1
            self?.ingredient2Label.text = self?.viewModelDetails.details[0].ingredient2
            self?.ingredient3Label.text = self?.viewModelDetails.details[0].ingredient3
            self?.mealDescription.text = self?.viewModelDetails.details[0].instructions
            // tagurile
            let array = self?.viewModelDetails.details[0].tags
            let tagList = array?.components(separatedBy: ",")
            if tagList?.count == 1
            {
                self?.mealTag1Label.text = tagList?[0]
                self?.tagView1.layer.cornerRadius = 15
                self?.tagView1.clipsToBounds = true
                self?.tagView1.layer.borderWidth = 1
                self?.tagView1.layer.borderColor = UIColor.red.cgColor
            }
            else if tagList?.count == 2
            {
                self?.mealTag1Label.text = tagList?[0]
                self?.tagView1.layer.cornerRadius = 15
                self?.tagView1.clipsToBounds = true
                self?.tagView1.layer.borderWidth = 1
                self?.tagView1.layer.borderColor = UIColor.red.cgColor
                self?.mealTag2Label.text = tagList?[1]
                self?.tagView2.layer.cornerRadius = 15
                self?.tagView2.clipsToBounds = true
                self?.tagView2.layer.borderWidth = 1
                self?.tagView2.layer.borderColor = UIColor.red.cgColor
            }
            else if tagList?.count == 3
            {
                self?.mealTag1Label.text = tagList?[0]
                self?.tagView1.layer.cornerRadius = 15
                self?.tagView1.clipsToBounds = true
                self?.tagView1.layer.borderWidth = 1
                self?.tagView1.layer.borderColor = UIColor.red.cgColor
                self?.mealTag2Label.text = tagList?[1]
                self?.tagView2.layer.cornerRadius = 15
                self?.tagView2.clipsToBounds = true
                self?.tagView2.layer.borderWidth = 1
                self?.tagView2.layer.borderColor = UIColor.red.cgColor
                self?.mealTag3Label.text = tagList?[2]
                self?.tagView3.layer.cornerRadius = 15
                self?.tagView3.clipsToBounds = true
                self?.tagView3.layer.borderWidth = 1
                self?.tagView3.layer.borderColor = UIColor.red.cgColor
            }
        })

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
    @IBAction func favouriteButton(_ sender: Any)
    {
        
        if favouriteButton.isSelected{
            
            
        }
        else{
            
        }
        
        
        
        /*
        // de luat datele
        if let id:String? = viewModelMeal.meals[0].id,
           let name:String? = viewModelMeal.meals[0].name,
           let thumb:String? = viewModelMeal.meals[0].thumb
        {
            
        }
        */

        
    }
    
 
}

