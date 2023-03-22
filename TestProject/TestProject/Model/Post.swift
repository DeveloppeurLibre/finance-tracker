//
//  Post.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let profile: Profile
    let location: String
    let imageURL: URL
}
