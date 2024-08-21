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
    @Environment(\.dismiss) private var dismiss
  //  let persistenceController = PersistenceController.shared
  //  @ObservedObject var viewModel : PaintingModel
    
   // let imageState : PaintingModel.ImageState
    
    var artVM : ContentView.ArtViewModel
    
    @State var name  = ""
    @State var artist = ""
    @State var year = ""
    @State var uiImage : UIImage? = nil
    @State var imageSelection: PhotosPickerItem? = nil
    

    
    var body: some View {
        
        VStack {
            /*PaintingImage(imageState: imageState)
                .overlay(alignment: .bottomTrailing){
                    PhotosPicker(selection: $viewModel.imageSelection
                                 , matching: .images, preferredItemEncoding: .automatic) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
            }*/
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 400)
                .clipped()
                .background(Color.gray.opacity(0.2))
            //
            photoPickerButton
             
            Group {
                TextField("Name", text: $name)
                TextField("Artist:", text: $artist)
                TextField("Year:", text: $year)
            }
            Button {
                savePainting()
            } label: {
                Text("Save")
            }.frame(maxWidth: .infinity)
            Spacer()
        }.padding()
            .onChange(of: imageSelection) {
                Task { @MainActor in
                    if let data = try? await imageSelection?.loadTransferable(type: Data.self) {
                        uiImage = UIImage(data: data)
                    }
                }
            }
    }
    var photoPickerButton : some View {
        PhotosPicker(
              selection: $imageSelection,
              matching: .images,
              photoLibrary: .shared()) {
                Image(systemName: "camera.circle.fill")
                  .font(.system(size: 50))
                  .foregroundColor(.gray)
              }
          }

         func savePainting() {
            
             artVM.savePainting(name: name, artist: artist, year: year, uiImage: uiImage!)
             artVM.getData()
             dismiss()
        }
    }
                                      

#Preview {
    //AddArt(viewModel: PaintingModel(), imageState: .empty)
    AddArt(artVM: ContentView.ArtViewModel())
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


