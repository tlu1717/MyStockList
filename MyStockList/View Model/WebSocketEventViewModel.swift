//
//  WebSocketEventViewModel.swift
//  MyStockList
//
//  Created by Tiff Lu on 4/3/22.
//

import Foundation
import Starscream

class WebSocketEventViewModel {
    var finnhubStockWebSocket: FinnhubStockWebSocket? = nil
    @Published var latestPrice: String = ""
    var stockSymbol: String = "AAPL"
    
    func connectToFinnhub(){
        finnhubStockWebSocket = FinnhubStockWebSocket()
        finnhubStockWebSocket?.connectToFinnHubWebSocket(delegate: self)
    }
    
    func disconnectFromFinnhub(){
        finnhubStockWebSocket?.disconnectFinnHubWebSocket()
    }
    
    func getLastPrice(symbol: String){
        finnhubStockWebSocket?.writeToSocket(query: "{\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}")
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

extension WebSocketEventViewModel: WebSocketDelegate{
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
//                onTextEventReceived(eventText: string)
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
                print("websocket cancelled")
            case .error(let error):
            print("websocket error: \(String(describing: error))")
            }
    }
}
