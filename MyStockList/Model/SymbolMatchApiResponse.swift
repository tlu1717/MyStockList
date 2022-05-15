//
//  SymbolMatchApiResponse.swift
//  MyStockList
//
//  Created by Tiff Lu on 4/10/22.
//

import Foundation
struct SymbolMatchApiResponse: Decodable {
    var count: Int
    var result: [BestMatchSymbol]
}
