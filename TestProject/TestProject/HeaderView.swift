//
//  HeaderView.swift
//  TestProject
//
//  Created by Quentin Cornu on 20/03/2023.
//

import SwiftUI

// MARK: Partie I
// MARK: - Partie I

struct HeaderView: View {
    
    let profile: Profile
    
    @State var showMore = false

    // Tout est rendu dans la variable body
    var body: some View {
        VStack(alignment: .leading) {
            // Image + stats
            HStack {
                ZStack {
                    Image("landscape")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(4)
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 4))
                        .foregroundColor(.gray)
                }
                .padding(2)
                .frame(width: 70, height: 70)
                
                Spacer()
                HStack(spacing: 10) {
                    VStack {
                        Text("829")
                            .bold()
                        Text("Posts")
                    }
                    VStack {
                        Text("829")
                            .bold()
                        Text("Followers")
                    }
                    VStack {
                        Text("829")
                            .bold()
                        Text("Follows")
                    }
                }
                .font(.title3)
                Spacer()
            }
            
            
            // Description
            VStack(alignment: .leading) {
                Text(profile.name)
                    .fontWeight(.black)
                    .lineLimit(1)
                Text(profile.title)
                    .bold()
                    .foregroundColor(Color.gray)
                if profile.description != nil {
                    Text(profile.description!)
                        .lineLimit(showMore ? nil : 3)
                    
                    Button {
                        showMore.toggle()
                    } label: {
                        Text(showMore ? "Voir moins" : "Voir plus")
                            .bold()
                            .foregroundColor(showMore ? .green : .red)
                    }
                }
                if profile.url != nil {
                    Link("Voir le site", destination: profile.url!)
                }
//                if let url = profile.url {
//                    Link("Voir le site", destination: url)
//                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct HeaderView_Previews: PreviewProvider {
    
    static var previews: some View {
        HeaderView(profile: .preview1)
            .previewLayout(.sizeThatFits)
        HeaderView(profile: .preview2)
            .previewLayout(.sizeThatFits)
    }
}
