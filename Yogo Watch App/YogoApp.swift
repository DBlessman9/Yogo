//
//  YogoApp.swift
//  Yogo Watch App
//
//  Created by Derald Blessman on 3/19/25.
//

import SwiftUI
import HealthKit
import AVKit
import Combine
import WatchKit

@main
struct Yogo_Watch_AppApp: App {
    init() {
        // Enable battery monitoring to help keep screen active
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Keep screen on while app is active
                    WKInterfaceDevice.current().isBatteryMonitoringEnabled = true
                }
                .onDisappear {
                    // Allow screen to dim when app is not active
                    WKInterfaceDevice.current().isBatteryMonitoringEnabled = false
                }
        }
    }
}
