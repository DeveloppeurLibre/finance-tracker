//
//  PreviewData.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import Foundation

extension Profile {
    static let preview1 = Profile(
        pictureURL: URL(string: "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=400"),
        name: "Quentin (preview 2)",
        title: "Autre Développeur",
        url: URL(string: "https://google.com")
    )
    
    static let preview2 = Profile(
        name: "Quentin (preview)",
        title: "Développeur",
        description: "Ceci  est une longue description sur plusieurs lignes Ceci est une longue description sur plusieurs lignes Ceci est une longue description sur plusieurs lignes"
    )
}

extension Post {
    static let preview1 = Post(
        profile: .preview1,
        location: "Paris",
        imageURL: URL(string: "https://images.pexels.com/photos/15954328/pexels-photo-15954328.jpeg")!
    )
    
    static let preview2 = Post(
        profile: .preview2,
        location: "Bali",
        imageURL: URL(string: "https://images.pexels.com/photos/3225531/pexels-photo-3225531.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")!
    )
}
