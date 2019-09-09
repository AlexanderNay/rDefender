//
//  GuestTableViewCell.swift
//  rDefender
//
//  Created by AlexanderN on 09/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import UIKit

class GuestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerLeftImageView: UIView!
    @IBOutlet weak var leftImageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var rightImageLabel: UILabel!
    
    let emojiCarArray = ["🚗","🚙","🏎", "🚘"]
    let emojiForWaitingStatus = ["✅", "❌", "⏱"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    func setupCell(guest: Guest) {
        let indexForEmojy = Int.random(in: 0..<emojiCarArray.count)
        leftImageLabel.text = emojiCarArray[indexForEmojy]
        
        let indexForEmojyWaitingStatus = Int.random(in: 0..<emojiForWaitingStatus.count)
        rightImageLabel.text = emojiForWaitingStatus[indexForEmojyWaitingStatus]
        
        nameLabel.text = guest.name
        descriptionLabel.text = guest.carNumber! + " " + guest.carModel!
    }
    
    private func setupUI() {
        containerLeftImageView.layer.cornerRadius = 8
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
