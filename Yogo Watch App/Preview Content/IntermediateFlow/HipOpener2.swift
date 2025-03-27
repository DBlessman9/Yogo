//
//  HipOpener2.swift
//  Yogo Watch App
//
//  Created by Whitney Wordlaw on 3/25/25.
//

import SwiftUI
import HealthKit
import Combine

struct HipOpener2: View {
    @EnvironmentObject var currentYoga: CurrentYoga
    @EnvironmentObject var audioManager: AudioManager

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HipOpener2()
        .environmentObject(AudioManager())
        .environmentObject(CurrentYoga())
}
