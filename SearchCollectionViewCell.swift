//
//  SearchCollectionViewCell.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 16.08.2021.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var nameSearchMealLabel: UILabel!
    @IBOutlet weak var imageSearchMealImage: UIImageView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    @IBOutlet weak var viewBottom: NSLayoutConstraint!
    
    // imaginea rotunda si view cu colturi rotunde
    
    func configure(thumbnailUrl: String, title: String)
    {
        
        nameSearchMealLabel.text = title
        guard let imageURL = URL(string: thumbnailUrl) else { return }
        imageSearchMealImage.kf.setImage(with: imageURL)
        imageSearchMealImage.layer.masksToBounds = true
        imageSearchMealImage.layer.cornerRadius = imageSearchMealImage.bounds.width / 2
        
        // colturi si shadow
        
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
    
    func configureOddRow(thumbnailUrlString: String, mealName: String)
    {
        configure(thumbnailUrl: thumbnailUrlString, title: mealName)
       
        viewTop.constant = 35
        viewBottom.constant = 2
    }
    
    func configureEvenRow(thumbnailUrlString: String, mealName: String)
    {
        configure(thumbnailUrl: thumbnailUrlString, title: mealName)
        
        viewTop.constant = 0
        viewBottom.constant = 30
    }
    
}
