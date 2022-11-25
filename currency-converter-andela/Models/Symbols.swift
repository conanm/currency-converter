//
//  Symbols.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation

struct SymbolsResult: Codable {
  let success: Bool
  let symbols:[String:String]
}
