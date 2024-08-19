//
//  PaintingModel-DAta.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 19/08/2024.
//

import SwiftUI
import PhotosUI
import CoreTransferable


@MainActor
class PaintingModel: ObservableObject {
  
    
    enum ImageState {
        case empty, loading(Progress), success(Image), failure(Error)
    }
    enum TransferError : Error {
        case importFailed
    }

   
    struct PImage : Transferable {
        let image: Image
        var imageData: Data?
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image){ data in
    #if canImport(AppKit)
                guard let nsImage = NSImage(data: data) else {
                  throw TransferError.importFailed
                }
                let image = Image(nsImage: nsImage)
    
                return PImage(image: image)
    #elseif canImport(UIKit)
                guard let uiImage = UIImage(data: data) else {
                   throw TransferError.importFailed
                }
              
                let image = Image(uiImage: uiImage)
           
                return PImage(image: image)
    #else
            throw TransferError.importFailed
    #endif
            
        }
      }
    }
    
    @Published private(set) var imageState:ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
                
            } else {
                imageState = .empty
            }
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: PImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let pImage?):
                    self.imageState = .success(pImage.image)
                    
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}
   
