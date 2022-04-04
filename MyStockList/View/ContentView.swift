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
    var webSocketEventViewModel = WebSocketEventViewModel()
    
    var body: some View {
        HStack{
                Text(webSocketEventViewModel.stockSymbol).font(.caption)
            Text(webSocketEventViewModel.latestPrice).font(.title).layoutPriority(1)
        }
        .padding(50)
        .onAppear {
            webSocketEventViewModel.connectToFinnhub()
        }
        .onDisappear {
            webSocketEventViewModel.disconnectFromFinnhub()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
