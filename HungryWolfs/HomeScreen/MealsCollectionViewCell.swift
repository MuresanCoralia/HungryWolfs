//
//  MealsCollectionViewCell.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 12.08.2021.
//

import UIKit
import Kingfisher

class MealsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameMealLabel: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var view: UIView!
    
    // imaginea rotunda si view cu colturi rotunde + shadow
    
    func configure(thumbnailUrl: String, title: String)
    {
        nameMealLabel.text = title
        guard let imageURL = URL(string: thumbnailUrl) else { return }
        mealImage.kf.setImage(with: imageURL)
        mealImage.layer.masksToBounds = true
        mealImage.layer.cornerRadius = mealImage.bounds.width / 2
        
        // mai modifica la colturi si shadow
        
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 1.5

        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.masksToBounds = true
        
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 7.0)
        view.layer.shadowRadius = 7.0
        view.layer.shadowOpacity = 0.2
        view.layer.masksToBounds = false
        view.layer.shadowPath = UIBezierPath(roundedRect:view.bounds, cornerRadius:view.layer.cornerRadius).cgPath

    }
}
