//
//  ContentView.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 18/08/2024.
//

import SwiftUI
import CoreData



struct ContentView: View {
    
    // var paintings : [Painting] = []
    @State  var artVM  = ArtViewModel()
    
    @State var isPresented : Bool = false
    //@StateObject var viewModel = PaintingModel()
    
    //  @State var path : NavigationPath
    var body: some View {
        NavigationStack {
            
            
            List{
                ForEach(artVM.paintings) { painting in
                    NavigationLink {
                        DetailedArtView(painting: painting)
                    } label: {
                        Text(painting.name)
                    }
                }.onDelete(perform: deletePainting(at:))
                
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
                        // AddArt(viewModel: viewModel, imageState: viewModel.imageState)
                        AddArt(artVM: artVM)
                        
                    }
                }
            }
        }.onAppear {
            artVM.getData()
            print(artVM.paintings.count)
        }
    }
    public func deletePainting(at offsets: IndexSet) {
        for index in offsets {
            let paintingDB = artVM.paintings[index]
            artVM.deletePainting(painting: paintingDB)
        }
        
    }
}

#Preview {
    ContentView(artVM: previewArtVM)
}

let previewArtVM = ContentView.ArtViewModel(paintings: previewPaintings)


let  previewPaintings =  [
    Painting(name: "Mona Lisa", artist: "Da Vinci", year: 1508),
    Painting(name: "Blue Poles", artist: "Pollock", year: 1948)
    ]

