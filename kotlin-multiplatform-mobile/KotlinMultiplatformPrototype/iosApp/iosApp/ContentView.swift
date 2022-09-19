import SwiftUI
import shared

struct ContentView: View {
// 	let greet = Greeting().greeting()
    let devices = [
        BTDevice(id: "abcd",name: "Device A",batteryPercentage: 80,manufacturer: "China"),
                BTDevice(id: "efgh",name: "Device B",batteryPercentage: 20,manufacturer:"China"),
                BTDevice(id: "ijkl",name: "Device A",batteryPercentage: 1,manufacturer: "China"),
                BTDevice(id: "mnop",name: "Device B",batteryPercentage: 69,manufacturer: "China")
    ]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(devices, id: \.id) { device in
                        HStack {
                            NavigationLink(destination: InfoView(device: device)) {
                                Text(device.name)
                            }
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                Spacer()
                Button(action: {}){
                    Text("Scan")
                        .foregroundColor(.black)
                        .bold()
                }
                .frame(maxWidth: .infinity)
//                 .buttonStyle(.bordered)
//                 .background(.blue)
//                 .cornerRadius(10)
            }.padding()
                .navigationTitle("Devices")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

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