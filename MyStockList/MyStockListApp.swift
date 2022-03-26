//
//  MyStockListApp.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22.
//

import SwiftUI

@main
struct MyStockListApp: App {
    @StateObject private var finnhubStockDataSocket = FinnhubStockDataSocket()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(finnhubStockDataSocket)
        }
    }
}
