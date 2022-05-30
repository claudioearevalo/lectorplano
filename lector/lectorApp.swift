//
//  lectorApp.swift
//  lector
//
//  Created by Claudio Arevalo on 25/05/2022.
//

import SwiftUI

@main
struct lectorApp: App {
    var body: some Scene {
        WindowGroup {
            //llama al contenido preciamente seteando form min y max
            ContentView().frame(minWidth: 400, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
                .navigationTitle("Lector 1.0")
            }
        }
}

