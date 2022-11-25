//
//  ViewController.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit
import RxSwift
import RxCocoa


class MainViewController: UIViewController {
  
  var fromCurrencyPickerView = UIPickerView.init(frame: .zero)
  var toCurrencyPickerView = UIPickerView.init(frame: .zero)
 
  @IBOutlet weak var fromCurrency: UITextField!
  @IBOutlet weak var toCurrency: UITextField!
  @IBOutlet weak var outputValue: UITextField!
  @IBOutlet weak var inputValue: UITextField!
  
  private let disposeBag = DisposeBag()
  
  var currenciesViewModel = CurrenciesViewModel()
  var fromCurrencyPickerViewModel: CurrencyPickerViewModel!
  var toCurrencyPickerViewModel: CurrencyPickerViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fromCurrencyPickerViewModel = CurrencyPickerViewModel.init(pickerView: fromCurrencyPickerView, textField: fromCurrency)
    toCurrencyPickerViewModel = CurrencyPickerViewModel.init(pickerView: toCurrencyPickerView, textField: toCurrency)
    
    self.bindView()
    self.currenciesViewModel.getSymbols()
  }
  
}

// TODO: add protocol
extension MainViewController {
  
  func bindView() {
    // TODO add load/error states
    // Data (available currencies)
    currenciesViewModel.currencies
      .observe(on: MainScheduler.instance)
      .bind(to: fromCurrencyPickerViewModel.symbols)
      .disposed(by: disposeBag)

    currenciesViewModel.currencies
      .observe(on: MainScheduler.instance)
      .bind(to: toCurrencyPickerViewModel.symbols)
      .disposed(by: disposeBag)

    
//    // Event - Changed Currency
//    let _ = currencyPickerView.rx.itemSelected
//        .subscribe(onNext: { [weak self] (row, value) in
//          print(row)
//          print(value)
//          
//          print(value)
//          self?.fromCurrency.resignFirstResponder()
//        })
  }
  
}
