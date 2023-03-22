//
//  FeedView.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import SwiftUI

struct FeedView: View {
    
    let posts: [Post]
    
    var body: some View {
        ScrollView {
            ForEach(posts) { post in
                PostView(post: post)
                Divider()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(posts: [.preview1, .preview2])
    }
}
