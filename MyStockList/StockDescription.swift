//
//  StockDescription.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/25/22.
//

import Foundation
struct StockDescription: Decodable {
    var p: Double
    var c: [String]
    var v: Int
    var t: Int
    var s: String
}
