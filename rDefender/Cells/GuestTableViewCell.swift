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
    
    
    
    private func getStatusLabel(guestStatus: GuestStatus) -> String {
        //let emojiCarArray = ["🚗","🚙","🏎", "🚘"]
        //let emojiForWaitingStatus = ["✅", "❌", "⏱", "⚠️"]
        switch guestStatus {
        case .arrived:
            return "✅"
        case .didNotArrive:
            return "❌"
        case .onHisWay:
            return "⏱"
        case .error:
            return "⚠️"
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    
    func setupCell(guest: Guest) {
        leftImageLabel.text = guest.iconOfGuest
       
        rightImageLabel.text = getStatusLabel(guestStatus: guest.status)
        
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
