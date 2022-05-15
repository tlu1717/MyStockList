//
//  StockDataHandler.swift
//  MyStockList
//
//  Created by Tiff Lu on 5/11/22.
//

import Foundation
import Starscream
class StockDataHandler {
    let stockList = StockList.shared

    func onTextEventReceived(eventText: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let jsonData = eventText.data(using: .utf8) else{
                return
            }
            do{
                let stockData: StockData = try JSONDecoder().decode(StockData.self, from: jsonData)
                self.parseStockData(stockData: stockData)
            }
            catch {
                print("decode error")
            }
        }
    }
    
    private func parseStockData(stockData: StockData){
        var stockPriceDict: [String: Double] = [:] // value: sum, key: stock
        var stockNumDict: [String: Int] = [:]
        // get average of packets of the same stock that came in at the same time
        // two dictionaries: one for sum and one for number of items
        for packets in stockData.data {
            let currPrice = stockPriceDict[packets.s] ?? 0
            stockPriceDict[packets.s] = currPrice + packets.p
            let currNum = stockNumDict[packets.s] ?? 0
            stockNumDict[packets.s] = currNum + 1
        }
        
        for (stockSymbol, total) in stockPriceDict {
            guard let totalNum = stockNumDict[stockSymbol] else {
                print("StockDataHandler: cannot find count for stock data. Please revisit logic")
                return
            }
            stockList.updateStockPrice(symbol: stockSymbol, price: total/Double(totalNum))
        }
    }
    
    
}
