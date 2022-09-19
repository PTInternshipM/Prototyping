//
//  swiftui_prototypeApp.swift
//  swiftui_prototype
//
//  Created by Timo van der Haar on 15/09/2022.
//

import SwiftUI

@main
struct swiftui_prototypeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(devices: .constant(BTDevice.sampleData))
        }
    }
}
