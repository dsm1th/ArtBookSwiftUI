//
//  ArtBookSwiftUIApp.swift
//  ArtBookSwiftUI
//
//  Created by Darren Smith on 18/08/2024.
//

import SwiftUI

@main
struct ArtBookSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
