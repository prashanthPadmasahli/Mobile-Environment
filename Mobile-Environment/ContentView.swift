//
//  ContentView.swift
//  Mobile-Environment
//
//  Created by mac on 06/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear {
            print(Bundle.main.object(forInfoDictionaryKey: "appVersion"))
            print(Bundle.main.infoDictionary?["appBuildNumber"])
            #if DEBUG
            print("Current environment is DEV")
            #elseif PROD
            print("Current environment is PROD")
            #elseif UAT
            print("Current environment is UAT")
            #endif
        }
    }
}

#Preview {
    ContentView()
}
