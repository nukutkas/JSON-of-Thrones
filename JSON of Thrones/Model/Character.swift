//
//  Character.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 13.05.2021.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String
    let imageUrl: String
    
    var description: String {
        """
    First name: \(firstName)
    Last name: \(lastName)
    Title: \(title)
    Family: \(family)
    """
    }
}

enum URLS: String {
    case characterApi = "https://thronesapi.com/api/v2/Characters"
}
