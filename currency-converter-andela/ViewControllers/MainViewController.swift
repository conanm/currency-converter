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
  
  var currencyPickerView = UIPickerView.init(frame: .zero)
  var symbols: BehaviorRelay<[String:String]> = BehaviorRelay(value: [:])
 
  @IBOutlet weak var fromCurrency: UITextField!
  @IBOutlet weak var toCurrency: UITextField!
  @IBOutlet weak var outputValue: UITextField!
  @IBOutlet weak var inputValue: UITextField!
  
  var currenciesViewModel = CurrenciesViewModel()
  var currencyPickerViewModel: CurrencyPickerViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fromCurrency.inputView = currencyPickerView
    currencyPickerViewModel = CurrencyPickerViewModel.init(pickerView: currencyPickerView, textField: fromCurrency)
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
      .bind(to: symbols)
    
    // Data - setup picker titles
    symbols.bind(to: self.currencyPickerView.rx.itemTitles) { (row, element) in
      return element.value
    }
    
    // Event - Changed Currency
    let _ = currencyPickerView.rx.itemSelected
        .subscribe(onNext: { [weak self] (row, value) in
          print(row)
          print(value)
          
          print(value)
          self?.fromCurrency.resignFirstResponder()
        })
  }
  
}
