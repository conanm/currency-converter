//
//  CurrenciesViewModel.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation
import RxSwift

enum NetworkState {
  case ready
  case loading
  case done
  case error
}

class CurrenciesViewModel {
  public let currencies: PublishSubject<[String]> = PublishSubject()
  public let state: PublishSubject<NetworkState> = PublishSubject()

  func getSymbols() {
    // return stub for now
    state.onNext(.loading)
    let symbolsResult = Bundle.main.decode(SymbolsResult.self, from: "getSymbols.json")
    // TODO: do some map to show key: desc so we can take advantage of the data in the .json better.
    let currencyKeys = Array(symbolsResult.symbols.keys)
    currencies.onNext(currencyKeys)
    state.onNext(.done)
    
    
    // TODO: write network call
  }
}
