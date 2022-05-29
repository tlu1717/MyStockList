//
//  StockList.swift
//  MyStockList
//
//  Created by Tiff Lu on 4/24/22.
//

import Foundation

class StockList: ObservableObject {
    static let shared = StockList()
    
    @Published var stocks: [StockInfo]
    private var stockCount = 0
    var finnhubStockWebSocket: FinnhubStockWebSocket?
    
    init() {
        self.stocks = []
    }
    
    // find the index of the Stock symbol
    // return index of the stock if found
    // -1 if not found
    // assuming that each stock symbol is unique
    func findStockIndex(symbol: String) -> Int {
        // we can use swift's where function on lists, but I want to code it out
        // O(n) because we do not sort the list alphabetically every time
        for index in stocks.indices{
            if stocks[index].symbol == symbol { return index }
        }
        return -1
    }
    
    func updateStockPrice(symbol: String, price: Double) {
        let index = findStockIndex(symbol: symbol)
        if index != -1 {
            stocks[index].price = String(format: "%.2f", price)
        }
    }
    
    func addStock(symbol: String) {
        // we are limiting our stock list to maximum 50
        // this number is the max subscription we can get from finnhub free account
        if stockCount < 50 {
            // check if stock is already added
            // we don't want duplicate entries
            if findStockIndex(symbol: symbol) != -1 {
                print("Stock is already in the list. Please enter a different stock")
                return
            }
            
            // add to our stock list to display to UI
            stocks.append(StockInfo(symbol: symbol))
        
            // subscribe to stock list
            guard let socket = finnhubStockWebSocket else {
                print("stockList: socket is nil")
                return
            }
            socket.subscribeToStock(symbol: symbol)
            
            stockCount += 1
        }
        else {
            // TODO: pop up dialog telling user that the maximum is reached
            print("maximum stock reached")
        }
    }
    
    func removeStock(at offsets: IndexSet) {
        guard let socket = finnhubStockWebSocket else {
            print("stockList: socket is nil")
            return
        }
        let stocksTobeRemoved = offsets.map { self.stocks[$0] }
        
        for s in stocksTobeRemoved {
            // unsubscribe
            socket.unsubscribeToStock(symbol: s.symbol)
        }
        
        // remove from list
        stocks.remove(atOffsets: offsets)
        
        stockCount -= 1
    }
    
    func moveStockPositionInList(from source: IndexSet, to destination: Int) {
        stocks.move(fromOffsets: source, toOffset: destination)
    }
    
}
