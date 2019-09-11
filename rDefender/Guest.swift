//
//  Guest.swift
//  rDefender
//
//  Created by AlexanderN on 01/09/2019.
//  Copyright © 2019 AlexanderN. All rights reserved.
//

import Foundation

enum TypeOfGuest: String {
    case person
    case car
    case truck
    case unknown
    

    static func getTipeOfGuestFrom(data: [String: Any]) -> TypeOfGuest {
        guard let typeOfGuestString: String = data["typeOfGuest"] as? String else { return .unknown }
        switch typeOfGuestString {
        case "person":
            return .person
        case "car":
            return .car
        case "truck":
            return .truck
        default:
            return .unknown
        }
    }
}


struct Guest {
    let id: String
    let name: String?
    let carModel: String?
    let carNumber: String?
    let date: Date
    let typeOfGuest: TypeOfGuest
    let iconOfGuest: String

    
    
    init(data: [String: Any]) {
        self.id = data["id"] as! String
        self.name = data["name"] as? String
        self.carModel = data["carModel"] as? String
        self.carNumber = data["carNumber"] as? String
        self.date = Date()
        self.typeOfGuest = TypeOfGuest.getTipeOfGuestFrom(data: data)
        self.iconOfGuest = (data["iconOfGuest"] as? String) ?? "❔"
    }

    
    init(id: String, name: String?, carModel: String?, carNumber: String?, date: Date, typeOfGuest: TypeOfGuest) {
        
        func getIconOfGuest(typeOfGuest: TypeOfGuest) -> String {
            let carArray = ["🚗","🚙","🏎", "🚘"]
            let truckArray = ["🚚", "🚛"]
            let personArray = ["👤"]
            switch typeOfGuest {
            case .car:
                return carArray.randomElement()!
            case .truck:
                return truckArray.randomElement()!
            case .person:
                return personArray.randomElement()!
            case .unknown:
                return "❔"
            }
        }
        
        
        self.id = id
        self.name = name
        self.carModel = carModel
        self.carNumber = carNumber
        self.date = date
        self.typeOfGuest = typeOfGuest
        self.iconOfGuest = getIconOfGuest(typeOfGuest: typeOfGuest)
        
    }
}
