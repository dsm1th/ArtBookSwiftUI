//
//  Paintings.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 18/08/2024.
//

import Foundation
import UIKit
import CoreData


class Painting : ObservableObject, Identifiable {
    var id = UUID()
    var artist = ""
   @Published var name = ""
    var image : Data?
    var year : Int = 2024
    
    init() {
       
    }
    init(name: String, artist: String, year: Int) {
       
        self.artist = artist
        self.name = name
        self.year = year
    }
    func uiImagview() -> UIImage{
        var uiImage = UIImage(systemName:"exclamationmark.triangle.fill")
        if self.image != nil {
            uiImage = UIImage(data: self.image!)
        }
        return uiImage!
    }
}
