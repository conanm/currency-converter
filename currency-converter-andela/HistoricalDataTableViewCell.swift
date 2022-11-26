//
//  HistoricalDataTableViewCell.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit

class HistoricalDataTableViewCell: UITableViewCell {
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var infoLabel: UILabel!
  
  public var cellModel : Rate! {
    didSet {
      self.dateLabel.text = cellModel.date
      self.infoLabel.text = cellModel.currency
      + " : "
      + String(format: "%.2f", cellModel.value)
    }
  }
  
}
