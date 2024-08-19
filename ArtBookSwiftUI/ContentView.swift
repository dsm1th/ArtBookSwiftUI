//
//  ContentView.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 18/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    var paintings : [Painting] = []
    @State var isPresented : Bool = false
    @StateObject var viewModel = PaintingModel()
  //  @State var path : NavigationPath
    var body: some View {
        NavigationStack {
            
            
            List{
                ForEach(paintings) { painting in
                    Text(painting.name)
                }
            }
            .navigationTitle("Paintings")
            .font(.headline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                   isPresented = true
                } label: {
                    Image(systemName: "plus")
                }.navigationDestination(isPresented: $isPresented) {
                    AddArt(viewModel: viewModel, imageState: viewModel.imageState)
    
                }
            }
            }
        }
    }
}

#Preview {
    ContentView(paintings: previewData)
}

let art1  = Painting()

let previewData = [
    Painting(name: "Mona Lisa", artist: "Da Vinci", year: 1508),
    Painting(name: "Blue Poles", artist: "Pollock", year: 1948)
    ]

