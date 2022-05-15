//
//  AddNewStockView.swift
//  MyStockList
//
//  Created by Tiff Lu on 5/12/22.
//

import SwiftUI

struct AddNewStockView: View {
    @State private var stockSymbol: String = ""
    @ObservedObject var stockList: StockList = StockList.shared
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
    static var previews: some View {
        AddNewStockView(isPresented: $isPresented)
    }
}
