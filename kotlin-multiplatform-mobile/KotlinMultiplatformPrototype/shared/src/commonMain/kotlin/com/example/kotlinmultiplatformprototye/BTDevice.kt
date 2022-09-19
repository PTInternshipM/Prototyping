package com.example.kotlinmultiplatformprototye

//class BTDevice {
//    var id: String = ""
//    var name: String = ""
//    var batteryPercentage: Int = 0
//    var manufacturer: String = ""
//}

data class BTDevice(val id: String, val name: String, val batteryPercentage: Int, val manufacturer: String) {
    companion object {
        fun sampleData() = listOf(
        BTDevice("abcd", "Device A", 80, "China"),
        BTDevice("efgh", "Device B", 20,"China"),
        BTDevice("ijkl", "Device A", 1, "China"),
        BTDevice("mnop", "Device A", 69, "China")
        )
    }
}