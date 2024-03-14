//
//  User.swift
//  SimplySetsiOS
//
//  Created by Andrew Blad on 3/9/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return "1"
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Billy Bob", email: "billybob@gmail.com")
}
