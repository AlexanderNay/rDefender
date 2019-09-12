//
//  CarModelTableViewCell.swift
//  rDefender
//
//  Created by AlexanderN on 12/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

class CarModelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    private func setupUI() {
        
    }
    
    func setupCell(carModel: String) {
        carLabel.text = carModel
        carImageView.image = setImagePng(imageName: carModel)
        carImageView.tintColor = #colorLiteral(red: 0.5176470588, green: 0.4, blue: 0.1529411765, alpha: 1)
    }
    
    
    private func setImagePng(imageName: String) -> UIImage {
        let originImage = UIImage(named: imageName) ??  UIImage(named: "unknown_car")!
        
        let tintedImage = originImage.withRenderingMode(.alwaysTemplate)
        return tintedImage
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
