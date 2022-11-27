//
//  Rate.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 26/11/22.
//

import Foundation

struct Rate: Identifiable, Equatable {
  let id = UUID()
  let date: String
  let currency :String
  let value: Double
  
  func dateValue() -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: date) ?? Date.distantPast
  }
  
  static func == (lhs: Rate, rhs: Rate) -> Bool {
          return
              lhs.date == rhs.date &&
              lhs.currency == rhs.currency &&
              lhs.value == rhs.value
      }

}
