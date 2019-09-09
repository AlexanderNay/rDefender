//
//  Guest.swift
//  rDefender
//
//  Created by AlexanderN on 01/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import Foundation


struct Guest {
    let id: String
    let name: String?
    let carModel: String?
    let carNumber: String?
    let date: Date
    
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.name = data["name"] as? String
        self.carModel = data["carModel"] as? String
        self.carNumber = data["carNumber"] as? String
        self.date = Date()
    }
    
    init(id: String, name: String?, carModel: String?, carNumber: String?, date: Date) {
        self.id = id
        self.name = name
        self.carModel = carModel
        self.carNumber = carNumber
        self.date = date
    }
}
