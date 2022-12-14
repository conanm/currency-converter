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
  
  public var data = PublishSubject<HistoricalDataResult>()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    latestRatesTableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: "Cell")
    
    setupBindings()
    
    historicalDataViewModel
      .historical(fromCurrency: fromCurrencyCode,
                  toCurrency: toCurrencyCode,
                  startDate: Date().dateString(daysDifference: -3),
                  endDate: Date().dateString(daysDifference: -1),
                  amount: Double(fromCurrencyValue)!)
    
    latestRatesViewModel
      .latestRates(fromCurrency: fromCurrencyCode,
                   toCurrency: toCurrencyCode,
                   startDate: Date().dateString(daysDifference: -3),
                   endDate: Date().dateString(daysDifference: -1))
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
        cell.dateLabel!.text = track.date
        cell.infoLabel!.text = "\(self.fromCurrencyValue) \(self.fromCurrencyCode) - \(track.currency) \(String(format: "%.2f", track.value ))"
      }.disposed(by: disposeBag)
    
    historicalDataViewModel
      .historicalData
      .observe(on: MainScheduler.instance)
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
        cell.textLabel!.text = "\(self.fromCurrencyCode) \(self.fromCurrencyValue) : \(track.currency) \(String(format: "%.2f", track.value ))"
      }.disposed(by: disposeBag)
    
  }
}

