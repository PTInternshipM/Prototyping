//
//  BTDevice.swift
//  swiftui_prototype
//
//  Created by Timo van der Haar on 15/09/2022.
//

import Foundation

struct BTDevice: Identifiable {
    var id: UUID
    var name: String
    var batteryPercentage: Int
    var manufacturer: String
    
    init(id: UUID = UUID(), name: String, batterPercentage: Int, manufacturer: String) {
        self.id = id
        self.name = name
        self.batteryPercentage = batterPercentage
        self.manufacturer = manufacturer
    }
}

extension BTDevice {
    static let sampleData: [BTDevice] =
    [
        BTDevice(name: "Device A", batterPercentage: 50, manufacturer: "China"),
        BTDevice(name: "Device B", batterPercentage: 80, manufacturer: "China"),
        BTDevice(name: "Device C", batterPercentage: 1, manufacturer: "China"),
        BTDevice(name: "Device D", batterPercentage: 20, manufacturer: "China")
    ]
}
