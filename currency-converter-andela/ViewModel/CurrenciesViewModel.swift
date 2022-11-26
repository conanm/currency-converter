//
//  CurrenciesViewModel.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class CurrenciesViewModel {
  public let currencies: PublishSubject<[String]> = PublishSubject()
  public let loading = BehaviorRelay<Bool>(value: true)
  public let convertedOutput: PublishSubject<String> = PublishSubject()
  // TODO add error
  func getSymbols() {
    // return stub for now
    loading.accept(true)
    let symbolsResult = Bundle.main.decode(SymbolsResult.self, from: "getSymbols.json")
    // TODO: do some map to show key: desc so we can take advantage of the data in the .json better.
    let currencyKeys = Array(symbolsResult.symbols.keys).sorted()
    
    currencies.onNext(currencyKeys)
    loading.accept(false)
    // TODO: write network call
  }
  
  func convert(from: String, to: String, amount: String) {
    return
    let url = "https://api.apilayer.com/fixer/convert?to=\(from)&from=\(to)&amount=\(amount)"
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    request.addValue("RqACamdCivMdonCaSCk6zWnUHUyDGXO2", forHTTPHeaderField: "apikey")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      do {
        let currencyConversionResult = try JSONDecoder().decode(ConvertResult.self, from: data)
        self.convertedOutput.onNext(String(format: "%.2f", currencyConversionResult.result))
        print(data)
      } catch let error {
        print(error)
        // TODO: move to error field.
      }
    }
    
    task.resume()
  }
}
