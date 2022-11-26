//
//  HistoricalDataViewModel.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation
import RxSwift

class LatestRatesDataViewModel {
  
  public var latestResults: PublishSubject<[Rate]> = PublishSubject()
  
  func parseLatestRates(baseSymbol: String, rates: [String: [String: Double]]) {
    
  }
  
  func latestRates(fromCurrency: String, toCurrency: String, startDate: String, endDate: String) {
    let latestResultsJSON = Bundle.main.decode(LatestRatesResult.self, from: "getLatest.json")
    let historicalRatesArray = latestResultsJSON.latestRates()
    latestResults.onNext(historicalRatesArray)
    
    //    let url = "https://api.apilayer.com/fixer/timeseries?start_date=\(startDate)&end_date=\(endDate)&symbols=\(fromCurrency),\(toCurrency)"
    //    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    //    request.httpMethod = "GET"
    //
    //    request.addValue("RqACamdCivMdonCaSCk6zWnUHUyDGXO2", forHTTPHeaderField: "apikey")
    //
    //    let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //      guard let data = data else {
    //        print(String(describing: error))
    //        return
    //      }
    //      do {
    //        let historicalDataResult = try JSONDecoder().decode(HistoricalDataResult.self, from: data)
    ////        self.historicalData.onNext(historicalDataResult)
    ////        self.convertedOutput.onNext(String(format: "%.2f", currencyConversionResult.result))
    //        print(data)
    //      } catch let error {
    //        print(error)
    //        // TODO: move to error field.
    //      }
    //    }
    //
    //    task.resume()
    
  }
}
