//
//  StockInfo.swift
//  MyStockList
//
//  Created by Tiff Lu on 4/24/22.
//

import Foundation
struct StockInfo: Identifiable {
    var id: String {symbol}
    var symbol: String
    var price: String = "Loading"
}

#if DEBUG
let sampleStockInfo = [
    StockInfo(symbol: "AAPL", price: "$100"),
    StockInfo(symbol: "AMD", price: "$110"),
    StockInfo(symbol: "TSLA", price: "$120"),
    StockInfo(symbol: "NIO", price: "$130"),
    StockInfo(symbol: "SOFI", price: "$140")
]
#endif
