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
  
  @IBOutlet weak var latestRatesTableView: UITableView!
  @IBOutlet weak var historicalDataTableView: UITableView!
  
  let disposeBag = DisposeBag()
  let historicalDataViewModel =  HistoricalDataViewModel()
  var fromCurrencyValue: String = ""
  var fromCurrencyCode: String = ""
  var toCurrencyCode: String = ""
  var toCurrencyValue: String = ""
  
 
  public var data = PublishSubject<HistoricalDataResult>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupBindings()
    
    historicalDataViewModel
      .historical(fromCurrency: "EUR",
                  toCurrency: "GBP",
                  startDate: "2022-11-22",
                  endDate: "2022-11-24")
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
  }
}
