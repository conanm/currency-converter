//
//  LatestRatesResult.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 26/11/22.
//

struct LatestRatesResult: Codable {
  let base: String
  let date: String
  let rates: [String: Double]
  let timestamp: Int
  
  func latestRates() -> [Rate] {
    var parsedRates:[Rate] = []
    for rate in self.rates {
      parsedRates.append(Rate.init(date: date, currency: rate.key, value: rate.value))
    }
    return parsedRates
  }
}
