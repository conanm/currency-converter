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
  public let currencies: PublishSubject<[String:String]> = PublishSubject()
  public let state: PublishSubject<NetworkState> = PublishSubject()

  func getSymbols() {
    // return stub for now
    state.onNext(.loading)
    let symbolsResult = Bundle.main.decode(SymbolsResult.self, from: "getSymbols.json")
    currencies.onNext(symbolsResult.symbols)
    state.onNext(.done)
    
    
    // TODO: write network call
  }
}
