//
//  StockApiViewModel.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22
//

import UIKit
import Starscream

class FinnhubStockWebSocket: ObservableObject{
    private var socket: WebSocket? = nil
    
    init(webSocketDelegate: WebSocketDelegate){
        socket?.delegate = webSocketDelegate
    }
    
    private func getFinnhubAPIKey() throws -> String {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Cannot get Finnhub api key, please add a FINNHUB_API_KEY in xcconfig")
            throw WebSocketError.noAPIKey
        }
        print("api key", apiKey)
        return apiKey
    }
    
    func connectToFinnHubWebSocket(){
        do {
            let key = try getFinnhubAPIKey()
            guard let url = URL(string: "wss://ws.finnhub.io?token=\(key)") else{
                throw WebSocketError.urlStringIsNil
            }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 5
        
            socket = WebSocket(request: request)
            socket?.connect()
            
        }catch {
            print("Failed to connect to Finnhub Web Socket")
        }
    }
    
    func disconnectFinnHubWebSocket(){
        socket?.disconnect()
        socket?.delegate = nil
    }
    
    func writeToSocket(query: String){
        socket?.write(string: query)
    }
    
}
