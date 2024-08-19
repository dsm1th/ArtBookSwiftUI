//
//  AddArt.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 18/08/2024.
//

import SwiftUI
import PhotosUI
import CoreData

struct AddArt: View {
    //@Environment(\.managedObjectContext) private var moc
    let persistenceController = PersistenceController.shared
    @ObservedObject var viewModel : PaintingModel
    let imageState : PaintingModel.ImageState
 
    
    @State var name  = ""
    @State var artist = ""
    @State var year = ""


    
    var body: some View {
        
        VStack {
            PaintingImage(imageState: imageState)
                .overlay(alignment: .bottomTrailing){
                    PhotosPicker(selection: $viewModel.imageSelection
                                 , matching: .images, preferredItemEncoding: .automatic) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
            }
             
            Group {
                TextField("Name", text: $name)
                TextField("Artist:", text: $artist)
                TextField("Year:", text: $artist)
            }
            Button {
                //
            } label: {
                Text("Save")
            }.frame(maxWidth: .infinity)
            Spacer()
        }.padding()
    }
        
         func savePainting() {
            let context = persistenceController.container.viewContext
            
            let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
             newPainting.setValue(name, forKey: "name")
             newPainting.setValue(artist, forKey: "artist")
             if  let iyear = Int(year) {
                 newPainting.setValue(iyear, forKey: "year")
             }
             newPainting.setValue(UUID(), forKey: "id")
             
             //let data = selectedItems.data
        }
    }
                                      

#Preview {
    AddArt(viewModel: PaintingModel(), imageState: .empty)
}

struct PaintingImage: View {
    let imageState:  PaintingModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image("selecticon")
             .resizable()
             .scaledToFit()
             .padding()
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
   /*
        Image("selecticon")
         .resizable()
         .scaledToFit()
         .padding()
        // .onTapGesture {
         //PhotosPicker(selection: $selectedItem,
        // matching: .images, photoLibrary: .shared())
         //} */
    }
}


