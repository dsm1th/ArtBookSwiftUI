//
//  ArtViewModel.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 19/08/2024.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

extension ContentView {
    @Observable
    class ArtViewModel   {
        
        var paintings : [Painting] = []
        let persistenceController = PersistenceController.shared
        
        init () {
            
        }
        init (paintings: [Painting]) {  // for preview
            self.paintings = paintings
        }
        
        
        func getData() {
            //let context = persistanceController.container.viewContext
            self.paintings.removeAll()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let context = persistenceController.container.viewContext
            
            fetchRequest.returnsObjectsAsFaults  = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results as! [NSManagedObject] {
                    let painting = Painting()
                    if  let name = result.value(forKey: "name") as? String {
                        painting.name = name
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        painting.id = id
                    }
                    if let artist = result.value(forKey: "artist") as? String {
                        painting.artist = artist
                    }
                    if let image = result.value(forKey: "image") as? Data {
                        painting.image = image
                    }
                    self.paintings.append(painting)
                }
                
            } catch {
                print("Error:")
            }
        }
        
        func savePainting(name: String, artist: String, year: String, uiImage: UIImage) {
            
            let context = persistenceController.container.viewContext
            
            let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
            newPainting.setValue(name, forKey: "name")
            newPainting.setValue(artist, forKey: "artist")
            if  let iyear = Int(year) {
                newPainting.setValue(iyear, forKey: "year")
            }
            newPainting.setValue(UUID(), forKey: "id")
            
            let data = uiImage.jpegData(compressionQuality: 0.5)
            
            newPainting.setValue(data,forKey: "image")
            
            do {
                try context.save()
                print("success")
            } catch {
                print("error")
            }
            
        }
        func deletePainting(painting: Painting){
            let context = persistenceController.container.viewContext
           // context.delete(painting)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        
            
            fetchRequest.returnsObjectsAsFaults  = false
            fetchRequest.predicate = NSPredicate(format: "id == %@", painting.id as CVarArg)
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject] {
                    context.delete(result)
                }
                
            } catch {
                print("Error:")
            }
            
            
        }
    }
}
