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
                .imageScale(.large)
            Text("Hello, world!")
        }
        ._viewDebug { data in
            let string = String(data: data ?? Data(), encoding: .utf8) ?? ""
            print(string)
        }
    }
}
