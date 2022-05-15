//
//  ContentView.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22.
//

import SwiftUI

struct ContentView: View {
    var finnhubStockWebSocket =  FinnhubStockWebSocket()
    var stockDataHandler = StockDataHandler()
    @StateObject var stockList: StockList = StockList.shared
    @State var showAddScreen = false
    var body: some View {
        NavigationView{
            List{
                ForEach(stockList.stocks.indices, id: \.self){
                    index in
                    StockCardView(stock: stockList.stocks[index])
                }
                .onDelete(perform: stockList.removeStock)
                .onMove(perform: stockList.moveStockPositionInList)
            }
            .navigationTitle("My Stock List")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showAddScreen = true
                    }label: {
                        Image(systemName: "plus.square")
                    }
                }
            }
            .popover(isPresented: $showAddScreen){
                AddNewStockView(stockList: stockList, isPresented: $showAddScreen)
            }
            .onAppear {
                //                 connect to web socket
                finnhubStockWebSocket.connectToFinnHubWebSocket()
                stockList.finnhubStockWebSocket = finnhubStockWebSocket
            }
            .onDisappear {
                // disconnect to web socket
                finnhubStockWebSocket.disconnectFinnHubWebSocket()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct StockCardView: View {
    var stock: StockInfo
    var body: some View {
        GeometryReader { geometry in
            HStack(){
                Text(stock.symbol)
                    .padding()
                    .frame(width: geometry.size.width*0.33)
                Text(stock.price).font(.title)
                    .frame(width: geometry.size.width*0.67)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
