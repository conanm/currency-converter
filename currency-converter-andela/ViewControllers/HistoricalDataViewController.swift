//
//  HistoricalDataViewController.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

class HistoricalDataViewController: UIViewController {
  
  @IBOutlet weak var historicalDataTableView: UITableView!
  @IBOutlet weak var latestRatesTableView: UITableView!
  @IBOutlet weak var chartContainerView: UIView!
  
  let disposeBag = DisposeBag()
  let historicalDataViewModel =  HistoricalDataViewModel()
  let latestRatesViewModel =  LatestRatesDataViewModel()
  var fromCurrencyValue: String = ""
  var fromCurrencyCode: String = ""
  var toCurrencyCode: String = ""
  var toCurrencyValue: String = ""
  var baseCurrency = "EUR"
  var baseVal = 1
  
  
  public var data = PublishSubject<HistoricalDataResult>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    latestRatesTableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: "Cell")
    
    setupBindings()
    
    historicalDataViewModel
      .historical(fromCurrency: "EUR",
                  toCurrency: "GBP",
                  startDate: "2022-11-22",
                  endDate: "2022-11-24")
    
    latestRatesViewModel
      .latestRates(fromCurrency: "",
                   toCurrency: "",
                   startDate: "",
                   endDate: "")
  }
  
  private func setupChartView(rates: [Rate]) {
    let childView = UIHostingController(rootView: HistoricalDataChartView(rates: rates))
    addChild(childView)
    childView.view.frame = chartContainerView.frame
    view.addSubview(childView.view)
    childView.didMove(toParent: self)
  }
  
  private func setupBindings() {
    historicalDataViewModel
      .historicalData
      .bind(to: historicalDataTableView
        .rx
        .items(cellIdentifier: "historicalDataTableViewCell",
               cellType: HistoricalDataTableViewCell.self)) {
        (row,track,cell) in
        cell.cellModel = track
      }.disposed(by: disposeBag)
    
    historicalDataViewModel
      .historicalData
      .subscribe(onNext: { rates in
        self.setupChartView(rates: rates)
      }).disposed(by: disposeBag)
    
    latestRatesViewModel
      .latestResults
      .bind(to: latestRatesTableView
        .rx
        .items(cellIdentifier: "Cell",
               cellType: UITableViewCell.self)) {
        (row,track,cell) in
        cell.textLabel!.text = "\(self.baseCurrency) \(self.baseVal) : \(track.currency) \(String(format: "%.2f", track.value ))"
      }.disposed(by: disposeBag)
    
  }
}

