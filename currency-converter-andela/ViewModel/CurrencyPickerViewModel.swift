//
//  CurrencyPickerViewModel.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit
import RxCocoa
import RxSwift

class CurrencyPickerViewModel {
  
  private let pickerView: UIPickerView
  private let textField: UITextField
  public var symbols: BehaviorRelay<[String]> = BehaviorRelay(value: [])
  private let disposeBag = DisposeBag()
  
  init(pickerView: UIPickerView, textField: UITextField) {
    self.pickerView = pickerView
    self.textField = textField
    setupBindings()
  }
  
  func setupBindings() {
    textField.inputView = pickerView
    symbols.bind(to: self.pickerView.rx.itemTitles) { (row, element) in
      return element
    }.disposed(by: disposeBag)


    let _ = pickerView.rx.itemSelected
      .subscribe(onNext: {  [weak self] (row, value) in
        self?.textField.text = self?.symbols.value[row]
        self?.textField.resignFirstResponder()
      })

  }
  
}
