# MyStockList
Medium Post: TBA

A app to keep track of stocks. Users can make a list of stocks that they want to follow. Users are able to edit the list of stocks and order it the way they want. 
Data from [Finnhub.io websocket](https://finnhub.io/)

<img src="https://github.com/tlu1717/MyStockList/blob/stock_list/stocklist_screenshot.png" width="300">

## Setup
1. Download [XCode](https://developer.apple.com/xcode/), needs version > 11 for SwiftUI. 
2. Download [Cocoapods](https://guides.cocoapods.org/using/getting-started.html)
3. Clone git repo
    ```git clone https://github.com/tlu1717/MyStockList.git```
4. Open XCode, click on 'open a project or file', choose "MyStockList.xcworkspace" 
5. In terminal, run this command to install starscream.  
```pod install``` 
6. Go to https://finnhub.io/ and get an API key
7. Create a xcconfig file and put the API key down as FINNHUB_API_KEY
