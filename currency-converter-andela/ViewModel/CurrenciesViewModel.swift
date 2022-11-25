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
  
  func getSymbols() {
    // return stub for now
    loading.accept(true)
    let symbolsResult = Bundle.main.decode(SymbolsResult.self, from: "getSymbols.json")
    // TODO: do some map to show key: desc so we can take advantage of the data in the .json better.
    let currencyKeys = Array(symbolsResult.symbols.keys)
    currencies.onNext(currencyKeys)
    loading.accept(false)
    
    
    // TODO: write network call
  }
  
  func convert(from: String, to: String, amount: String) {
    convertedOutput.onNext("1.50")
  }
}
