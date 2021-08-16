//
//  CategoryCollectionViewCell.swift
//  HungryWolfs
//
//  Created by Wolfpack Digital on 11.08.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var categoryFoodLabel: UILabel!
    @IBOutlet weak var underView: UIView!
    
    // colturi rotunde linia de sub categorii
    
    func configure()
    {
        underView.layer.cornerRadius = 3
    }
    
}
