//
//  ContentView.swift
//  swiftui_prototype
//
//  Created by Timo van der Haar on 15/09/2022.
//

import SwiftUI

struct ContentView: View {
    @Binding var devices: [BTDevice]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(devices) { device in
                        HStack {
                            NavigationLink(destination: InfoView(device: device)) {
                                Text(device.name)
                            }
                            Spacer()
                            Button(action: deleteBtDevice(device: device)) {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                Spacer()
                Button(action: {}){
                    Text("Scan")
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                .background(.blue)
                .cornerRadius(10)
            }.padding()
                .navigationTitle("Devices")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func deleteBtDevice(device: BTDevice) -> () -> () {
        devices = devices.filter { $0.name != device.name}
        return {}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(devices: .constant(BTDevice.sampleData))
    }
}
