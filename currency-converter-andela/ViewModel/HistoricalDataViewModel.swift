//
//  HistoricalDataViewModel.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation
import RxSwift

class HistoricalDataViewModel {
  
  public var historicalData: PublishSubject<[Rate]> = PublishSubject()
  
  func historical(fromCurrency: String, toCurrency: String, startDate: String, endDate: String) {
    let url = "https://api.apilayer.com/fixer/timeseries?start_date=\(startDate)&end_date=\(endDate)&symbols=\(fromCurrency),\(toCurrency)"
    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    request.addValue("RqACamdCivMdonCaSCk6zWnUHUyDGXO2", forHTTPHeaderField: "apikey")
    
    let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      do {
        let historicalDataResult = try JSONDecoder().decode(HistoricalDataResult.self, from: data)
        self?.historicalData.onNext(historicalDataResult.historicalRates(symbol: toCurrency))
        print(data)
      } catch let error {
        print(error)
        // TODO: move to error field.
      }
    }

    task.resume()
    
  }
}

extension HistoricalDataViewModel {
  func historicalStub(fromCurrency: String, toCurrency: String, startDate: String, endDate: String) {
    let historicalResult = Bundle.main.decode(HistoricalDataResult.self, from: "getHistorical.json")
    let ratesArray = historicalResult.historicalRates(symbol: toCurrency)
    historicalData.onNext(ratesArray)
  }
}
