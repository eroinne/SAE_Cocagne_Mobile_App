//
//  ContentView.swift
//  Sae_Cocagne
//
//  Created by Ero on 28/02/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
             
            ScanView()
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("Scan")
                }
        }
       
    }
       
}

#Preview {
    ContentView()
}
