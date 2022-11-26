//
//  HistoricalDataViewController.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit
import RxSwift
import RxCocoa

class HistoricalDataViewController: UIViewController {
  
  @IBOutlet weak var historicalDataTableView: UITableView!
  @IBOutlet weak var latestRatesTableView: UITableView!
  
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
    
    latestRatesViewModel
      .latestResults
      .bind(to: latestRatesTableView
        .rx
        .items(cellIdentifier: "Cell",
                     cellType: UITableViewCell.self)) {
        (row,track,cell) in
        cell.textLabel!.text = "Balls"
      }.disposed(by: disposeBag)
  }
}

