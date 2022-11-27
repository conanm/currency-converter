//
//  ModelTests.swift
//  currency-converter-andelaTests
//
//  Created by Conan Moriarty on 27/11/22.
//

import XCTest
@testable import currency_converter_andela
import RxTest
import RxSwift

extension HistoricalDataViewModel {
  func historicalStub() {
    let historicalResult = Bundle.main.decode(HistoricalDataResult.self, from: "getHistorical.json")
    let ratesArray = historicalResult.historicalRates(fromSymbol: "EUR", amount: 1)
    historicalData.onNext(ratesArray)
  }
}

extension LatestRatesDataViewModel {
  
  func latestRatesStub(fromCurrency: String, toCurrency: String, startDate: String, endDate: String) {
    let latestResultsJSON = Bundle.main.decode(LatestRatesResult.self, from: "getLatest.json")
    let historicalRatesArray = latestResultsJSON.latestRates()
    latestResults.onNext(historicalRatesArray)
  }
  
}

final class ModelTests: XCTestCase {
  
  let historicalSUT = HistoricalDataViewModel()
  let scheduler = TestScheduler(initialClock: 0)
  let disposeBag = DisposeBag()
  

  override func setUpWithError() throws {
    
    
  }
  
  override func tearDownWithError() throws {
    // here we can nil out the SUTs but it's not strictly necessary...
  }
  
  func testHistoricalDataParsing() throws {
    let expect = expectation(description: #function)
    let firstRate = Rate(date: "2022-11-25", currency: "GBP", value: 0.860586)
    var firstRateFromJSON: Rate?
    historicalSUT
      .historicalData
      .asObservable()
      .subscribe(onNext: { data in
        firstRateFromJSON = data[0]
        expect.fulfill()
      })
      .disposed(by: disposeBag)

    
    historicalSUT.historicalStub()

    // 4
    waitForExpectations(timeout: 3.0) { error in
      XCTAssertEqual(firstRate, firstRateFromJSON)
    }
    
  }
  
}
