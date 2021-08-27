//
//  FavouriteTableViewCell.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 19.08.2021.
//

import UIKit
import Kingfisher

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var favouriteView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func update(with fav: Meal)
    {
        mealName.text = fav.name
        
        guard let imageURL = URL(string: (fav.thumb)) else { return }
        self.mealImage.kf.setImage(with: imageURL)
        self.mealImage.layer.masksToBounds = true
        self.mealImage.layer.cornerRadius = (self.mealImage.bounds.width) / 2
        favouriteView.layer.cornerRadius = 25
    }

}

