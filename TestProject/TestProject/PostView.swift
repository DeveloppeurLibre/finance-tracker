//
//  PostView.swift
//  TestProject
//
//  Created by Quentin Cornu on 21/03/2023.
//

import SwiftUI

struct PostView: View {
    
    let post: Post
    
    // 💡 Mettre TOUTES ses variables d'état en private
    @State private var isLiked: Bool = false
    @State private var isSaved: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                AsyncImage(url: post.profile.pictureURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                } placeholder: {
                    Rectangle()
                        .foregroundColor(.gray)
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(post.profile.name)
                        .bold()
                    Text(post.location)
                }
            }
            .padding(.horizontal)
            AsyncImage(url: post.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .foregroundColor(.gray)
            }
            HStack {
                ActivableButton(
                    iconName: "heart",
                    activatedIconColor: .red,
                    isActive: $isLiked
                )
                ActivableButton(
                    iconName: "flag",
                    activatedIconColor: .blue,
                    isActive: $isSaved
                )
            }
            .padding()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: .preview2)
    }
}
