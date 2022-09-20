package com.example.codenameoneprototype

import com.codename1.system.Lifecycle
import com.codename1.ui.Button
import com.codename1.ui.Dialog
import com.codename1.ui.FontImage
import com.codename1.ui.Form
import com.codename1.ui.Container
import com.codename1.ui.events.ActionEvent
import com.codename1.ui.layouts.BorderLayout
import com.codename1.ui.layouts.BoxLayout

class Device(val name: String, val manufacturer: String, val batteryLevel: Int, val id: String = "id")

open class CodenameOnePrototype : Lifecycle() {
    val devices = listOf(
        Device("BLEDevice1", "Company A", 20),
        Device("BLEDevice2", "Company B", 86),
        Device("BLEDevice3", "Company C", 51),
        Device("BLEDevice4", "Company D", 12)
    )

    override fun runApp() {
        val hi = Form("Devices", BorderLayout())
        val list = Container(BoxLayout.y())
        list.setScrollableY(true)
        for (device in devices) {
            val btn = Button(device.name)
            btn.addActionListener { e: ActionEvent? ->
                Dialog.show(
                    "Device",
                    device.name + " is from " + device.manufacturer + " and has a battery level of " + device.batteryLevel,
                    "OK",
                    null
                )
            }
            list.add(btn)
        }
        hi.add(BorderLayout.CENTER, list)
        hi.show()
    }

    private fun hello() {
        Dialog.show("Hello Codename One", "Welcome to Codename One", "OK", null)
    }
}

