//
//  TimeSeriesResult.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation

struct HistoricalDataResult: Codable {
  let base, endDate: String
  let rates: [String: [String: Double]]
  let startDate: String
  let success, timeseries: Bool
  
  enum CodingKeys: String, CodingKey {
    case base
    case endDate = "end_date"
    case rates
    case startDate = "start_date"
    case success, timeseries
  }
  
  /// fromSymbol -> symbol to ignore in results (this will be static, e.g. we're always checking static input, e.g. 1 EUR or 12 USD
  /// amount -> amount of the base value, e.g. EUR 0.96 -> USD will result in a mutliplication of 0.96.
  func historicalRates(fromSymbol: String, amount: Double) -> [Rate] {
    var parsedRates:[Rate] = []
    for dateDictionary in self.rates {
      let dateString = dateDictionary.key
      let ratesForDate = dateDictionary.value
      for (symbol, rate) in ratesForDate {
        if (symbol != fromSymbol) {
          parsedRates.append(Rate.init(date: dateString, currency: symbol, value: Double(rate) * amount))
        }
      }
    }
    
    return parsedRates.sorted { rate1, rate2 in
      rate1.date > rate2.date
    }
  }
}
