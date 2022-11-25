//
//  ViewController.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var fromCurrency: UITextField!
  @IBOutlet weak var toCurrency: UITextField!
  @IBOutlet weak var outputValue: UITextField!
  @IBOutlet weak var inputValue: UITextField!
  
  var currenciesViewModel = CurrenciesViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.currenciesViewModel.getSymbols()
    
  }

}


