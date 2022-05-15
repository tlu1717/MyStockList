//
//  StockApiViewModel.swift
//  MyStockList
//
//  Created by Tiff Lu on 3/21/22
//

import UIKit
import Starscream

class FinnhubStockWebSocket {
    private var socket: WebSocket? = nil
    private var stockDataHandler = StockDataHandler()
    
    func connectToFinnHubWebSocket(){
        do {
            let key = try FinnhubUtility.getFinnhubAPIKey()
            guard let url = URL(string: "wss://ws.finnhub.io?token=\(key)") else{
                throw WebSocketError.urlStringIsNil
            }
            
            var request = URLRequest(url: url)
            request.timeoutInterval = 5
            
            socket = WebSocket(request: request)
            socket?.onEvent = { event in
                self.eventReceptor(event: event)
            }
            socket?.connect()
            print("Connecting to Finnhub Web Socket")
            
        }catch {
            print("Failed to connect to Finnhub Web Socket")
        }
    }
    
    func disconnectFinnHubWebSocket(){
        socket?.disconnect()
        socket?.delegate = nil
        print("Disconnect from finnhub web socket")
    }
    
    private func writeToSocket(query: String){
        guard let finnhubSocket = socket else {
            print("FinnhubStockWebSocket: finnhub socket not initialized")
            return
        }
        finnhubSocket.write(string: query)
        print("web socket write string: \(query)")
    }
    
    func subscribeToStock(symbol: String){
        self.writeToSocket(query: "{\"type\":\"subscribe\",\"symbol\":\"\(symbol)\"}")
    }
    
    func unsubscribeToStock(symbol: String){
        self.writeToSocket(query: "{\"type\":\"unsubscribe\",\"symbol\":\"\(symbol)\"}")
       
    }
    
    func eventReceptor(event: WebSocketEvent) {
        //DispatchQueue.main.async {
            switch event {
            case .connected(let headers):
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                self.stockDataHandler.onTextEventReceived(eventText: string)
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
        //}
    }
}

