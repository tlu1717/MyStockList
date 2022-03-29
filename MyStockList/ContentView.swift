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
    @EnvironmentObject var finnhubStockWebSocket: FinnhubStockWebSocket
    
    var body: some View {
        HStack{
                Text(finnhubStockWebSocket.stockSymbol).font(.caption)
            Text(finnhubStockWebSocket.latestPrice).font(.title).layoutPriority(1)
        }
        .padding(50)
        .onAppear {
            finnhubStockWebSocket.connectToFinnHubWebSocket()
        }
        .onDisappear {
            finnhubStockWebSocket.disconnectFinnHubWebSocket()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject private static var finnhubStockWebSocket = FinnhubStockWebSocket()
    static var previews: some View {
        ContentView()
            .environmentObject(finnhubStockWebSocket)
    }
}
