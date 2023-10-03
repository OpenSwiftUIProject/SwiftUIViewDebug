//
//  ContentView.swift
//  ExampleApp
//
//  Created by Kyle on 2023/10/3.
//

import SwiftUI
import SwiftUIViewDebug

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                ._viewDebug()
            Text("Hello, world!")
                ._viewDebug(exportTo: FileManager.default.temporaryDirectory.appendingPathComponent("text_dump.json"))
        }
    }
}
