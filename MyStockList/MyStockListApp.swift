//
//  MyStockListApp.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22.
//

import SwiftUI

@main
struct MyStockListApp: App {
    @StateObject private var finnhubStockWebSocket = FinnhubStockWebSocket()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(finnhubStockWebSocket)
        }
    }
}
