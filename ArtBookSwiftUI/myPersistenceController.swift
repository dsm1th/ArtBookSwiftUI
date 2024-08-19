//
//  myPersistenceController.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 19/08/2024.
//

import Foundation
import CoreData
    
struct PersistenceController {
    // a singleton for our entire app
    
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    // test configuration for Swift UI previws
    
    static var preview : PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        for i in 0..<previewData.count {
            let art  = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: shared.container.viewContext)
            art.setValue(previewData[i].name, forKey: "name")
            art.setValue(previewData[i].artist, forKey: "artist" )
            art.setValue(previewData[i].year, forKey: "year")
            art.setValue(previewData[i].id, forKey: "id")
        }
        return controller
    } ()
   
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "ArtBookModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
    }
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
