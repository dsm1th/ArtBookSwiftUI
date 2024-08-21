//
//  DetailedArtView.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 20/08/2024.
//

import SwiftUI
import UIKit

struct DetailedArtView: View {
    let painting: Painting
    var uiImage: UIImage?
    
    
        
    var body: some View {
       
        //Image(uiImage: UIImage(data: painting!.image!) ?? UIImage() )
        VStack {
            Image(uiImage: painting.uiImagview())
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 400)
                .clipped()
                .background(Color.gray.opacity(0.2))
            
            Group {
                Text("Id: \(painting.id.description)")
                    .font(.subheadline)
                Text("Artist: \(painting.artist)")
                Text("Year: \(painting.year)")
            }.padding()
            
        }.navigationTitle(painting.name)
    }
}

#Preview {
    NavigationStack {
        DetailedArtView(painting: previewPaintings[0])
    }
}
