//
//  InfoView.swift
//  swiftui_prototype
//
//  Created by Timo van der Haar on 15/09/2022.
//

import SwiftUI

struct InfoView: View {
    var device: BTDevice
    
    var body: some View {
//        NavigationView {
            VStack {
                Text("\(device.name)")
                    .bold()
                    .font(.system(size: 24))
                List {
                    Section(header: Text("Details")) {
                        HStack {
                            Image(systemName: "number")
                            VStack(alignment: .leading) {
                                Text("Id")
                                    .bold()
                                Text("\(device.id)")
                                    .font(.system(size: 10))
                            }
                        }
                        HStack {
                            Image(systemName: "battery.25")
                            VStack(alignment: .leading) {
                                Text("Battery Level")
                                    .bold()
                                Text("\(device.batteryPercentage)")
                                    .font(.system(size: 12))
                            }
                        }
                        HStack {
                            Image(systemName: "house")
                            VStack(alignment: .leading) {
                                Text("Manufacturer")
                                    .bold()
                                Text("\(device.manufacturer)")
                                    .font(.system(size: 10))
                            }
                        }
                    }
                }
            }.navigationTitle("Info")
                .navigationBarTitleDisplayMode(.inline)
//        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InfoView(device: BTDevice.sampleData[0])
        }
    }
}
