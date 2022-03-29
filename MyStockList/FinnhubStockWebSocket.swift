//
//  StockApiViewModel.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22
//

import UIKit
import Starscream

class FinnhubStockWebSocket: ObservableObject{
    var socket: WebSocket? = nil
    var isConnected: Bool = false
    @Published var latestPrice: String = ""
    var stockSymbol: String = "AAPL"
    
    private func getFinnhubAPIKey() throws -> String {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Cannot get Finnhub api key, please add a FINNHUB_API_KEY in xcconfig")
            throw WebSocketError.noAPIKey
        }
        print("api key", apiKey)
        return apiKey
    }
    
    func isWebSocketConnected() -> Bool{
        return isConnected
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
            socket?.delegate = self
            socket?.connect()
            
        }catch {
            print("Failed to connect to Finnhub Web Socket")
        }
    }
    
    func disconnectFinnHubWebSocket(){
        socket?.disconnect()
        socket?.delegate = nil
    }
    
    func getLastPrice(symbol: String){
        socket?.write(string: "{\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}")
        print("web socket write string: {\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}")
    }
    
    func onTextEventReceived(eventText: String) {
        guard let jsonData = eventText.data(using: .utf8) else{
            return
        }
        do{
            let stockData: StockData = try JSONDecoder().decode(StockData.self, from: jsonData)
            latestPrice = String(format: "%.2f", stockData.data[0].p)
        }
        catch {
            print("Error parsing event: \(error.localizedDescription)")
            latestPrice = eventText
        }
    }
    
}

extension FinnhubStockWebSocket: WebSocketDelegate{
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
                isConnected = true
                getLastPrice(symbol: stockSymbol)
            case .disconnected(let reason, let code):
                print("websocket is disconnected: \(reason) with code: \(code)")
                isConnected = false
            case .text(let string):
                print("Received text: \(string)")
                onTextEventReceived(eventText: string)
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                print("ping")
            case .pong(_):
                print("pong")
            case .viabilityChanged(_):
                print("viabilityChanged")
            case .reconnectSuggested(_):
                print("reconnectSuggested")
            case .cancelled:
                isConnected = false
                print("websocket cancelled")
            case .error(let error):
            print("websocket error: \(String(describing: error))")
            }
    }
}
