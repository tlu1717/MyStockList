//
//  ContentView.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StockCardView()
    }
}

struct StockCardView: View {
    @EnvironmentObject var finnhubStockDataSocket: FinnhubStockDataSocket
    
    var body: some View {
        HStack{
                Text(finnhubStockDataSocket.stockSymbol).font(.caption)
            Text(finnhubStockDataSocket.eventStr).font(.title).layoutPriority(1)
        }
        .padding(50)
        .onAppear {
            finnhubStockDataSocket.connectToFinnHubWebSocket()
        }
        .onDisappear {
            finnhubStockDataSocket.disconnectFinnHubWebSocket()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject private static var finnhubStockDataSocket = FinnhubStockDataSocket()
    static var previews: some View {
        ContentView()
            .environmentObject(finnhubStockDataSocket)
    }
}
