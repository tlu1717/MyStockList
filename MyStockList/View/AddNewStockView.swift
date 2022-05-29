//
//  AddNewStockView.swift
//  MyStockList
//
//  Created by Tiff Lu on 5/12/22.
//

import SwiftUI

struct AddNewStockView: View {
    @State private var stockSymbol: String = ""
    @ObservedObject var stockList: StockList
    @Binding var isPresented: Bool
    var body: some View {
        NavigationView{
            VStack{
                TextField(
                    "Type stock symbol",
                    text: $stockSymbol
                )
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing])
                Button("Add Stock to List", action: {
                    stockList.addStock(symbol: stockSymbol)
                    
                    // dismiss view
                    isPresented = false
                })
            }
            .toolbar{
                Button{
                    isPresented = false
                }label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}

struct AddNewStockView_Previews: PreviewProvider {
    @State static var isPresented = false
    @StateObject static var stockList = StockList.shared
    static var previews: some View {
        AddNewStockView(stockList: stockList, isPresented: $isPresented)
    }
}
