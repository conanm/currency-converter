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
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var fromCurrency: UITextField!
  @IBOutlet weak var toCurrency: UITextField!
  @IBOutlet weak var outputValue: UITextField!
  @IBOutlet weak var inputValue: UITextField!
  @IBOutlet weak var detailsButton: UIButton!
  @IBOutlet weak var swapButton: UIButton!
  
  private let disposeBag = DisposeBag()
  
  var currenciesViewModel = CurrenciesViewModel()
  var fromCurrencyPickerViewModel: CurrencyPickerViewModel!
  var toCurrencyPickerViewModel: CurrencyPickerViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fromCurrencyPickerViewModel = CurrencyPickerViewModel.init(pickerView: fromCurrencyPickerView,
                                                               textField: fromCurrency)
    toCurrencyPickerViewModel = CurrencyPickerViewModel.init(pickerView: toCurrencyPickerView,
                                                             textField: toCurrency)
    self.bindView()
    self.currenciesViewModel.getSymbols()
  }
  
}

// TODO: add protocol
// Binding
extension MainViewController {
  
  func bindView() {
    currenciesViewModel.loading.asObservable()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [unowned self] loading in
        self.activityIndicator.isHidden = !loading
        self.currenciesViewModel.convert(from: self.fromCurrency.text!,
                                         to: self.toCurrency.text!,
                                         amount: self.inputValue.text!)
      })
      .disposed(by: disposeBag)
    // Data (available currencies)
    currenciesViewModel.currencies
      .observe(on: MainScheduler.instance)
      .bind(to: fromCurrencyPickerViewModel.symbols)
      .disposed(by: disposeBag)
    currenciesViewModel.currencies
      .observe(on: MainScheduler.instance)
      .bind(to: toCurrencyPickerViewModel.symbols)
      .disposed(by: disposeBag)
    // Events (editing ending input text field)
    inputValue.rx.controlEvent([.editingDidEnd])
      .asObservable()
      .subscribe(onNext:{ [unowned self] in
        self.currenciesViewModel.convert(from: self.fromCurrency.text!,
                                         to: self.toCurrency.text!,
                                         amount: self.inputValue.text!)
      }).disposed(by: disposeBag)
    fromCurrency.rx.controlEvent([.editingDidEnd])
      .asObservable()
      .subscribe(onNext:{ [unowned self] in
        self.currenciesViewModel.convert(from: self.fromCurrency.text!,
                                         to: self.toCurrency.text!,
                                         amount: self.inputValue.text!)
      }).disposed(by: disposeBag)
    toCurrency.rx.controlEvent([.editingDidEnd])
      .asObservable()
      .subscribe(onNext:{ [unowned self] in
        self.currenciesViewModel.convert(from: self.fromCurrency.text!,
                                         to: self.toCurrency.text!,
                                         amount: self.inputValue.text!)
      }).disposed(by: disposeBag)
    // Output of the conversion (to text field)
    currenciesViewModel.convertedOutput
      .observe(on: MainScheduler.instance)
      .bind(to: outputValue.rx.text)
      .disposed(by: disposeBag)
    
    let _ = swapButton.rx.tap.bind { [unowned self] in
      let currentInputValue = self.inputValue.text
      self.inputValue.text = self.outputValue.text
      self.outputValue.text = currentInputValue
      let currentCurrencyValue = self.fromCurrency.text
      self.fromCurrency.text = self.toCurrency.text
      self.toCurrency.text = currentCurrencyValue
    }
    
    let _ = detailsButton.rx.tap.bind {
      let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
      let vc = storyboard.instantiateViewController(withIdentifier: "HistoricalDataViewController") as! HistoricalDataViewController
      
      vc.fromCurrencyCode = self.fromCurrency.text!
      vc.fromCurrencyValue = self.inputValue.text!
      vc.toCurrencyCode = self.toCurrency.text!
      vc.toCurrencyValue = self.outputValue.text!
      
      self.present(vc, animated: true)
    }
    
  }
  
}
