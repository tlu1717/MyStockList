//
//  FinnhubUtility.swift
//  MyStockList
//
//  Created by Tiff Lu on 4/10/22.
//

import Foundation
class FinnhubUtility {
    static func getFinnhubAPIKey() throws -> String {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Cannot get Finnhub api key, please add a FINNHUB_API_KEY in xcconfig")
            throw WebSocketError.noAPIKey
        }
        print("Successfully get api key", apiKey)
        return apiKey
    }
}
