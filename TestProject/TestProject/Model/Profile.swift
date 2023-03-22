//
//  Profile.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import Foundation

struct Profile {
    let pictureURL: URL?
    let name: String
    let title: String
    let description: String?
    let url: URL?
    
    init(pictureURL: URL? = nil,
         name: String,
         title: String,
         description: String? = nil,
         url: URL? = nil) {
        self.pictureURL = pictureURL
        self.name = name
        self.title = title
        self.description = description
        self.url = url
    }
}
