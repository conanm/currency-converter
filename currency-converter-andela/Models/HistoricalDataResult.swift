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
  
  func historicalRates(symbol: String) -> [Rate] {
    var parsedRates:[Rate] = []
    for rate in self.rates {
      let date = rate.key
      if let rateValue = rate.value[symbol] {
        parsedRates.append(Rate.init(date: date, currency: symbol, value: rateValue))
      }
    }
    return parsedRates
  }
}
