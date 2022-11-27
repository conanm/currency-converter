//
//  ConvertResult.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import Foundation

// MARK: - Welcome
struct ConvertResult: Codable {
  let date: String
  let info: ConvertResultInfo
  let query: ConvertResultQuery
  let result: Double
  let success: Bool
}
struct ConvertResultInfo: Codable {
  let rate: Double
  let timestamp: Int
}
struct ConvertResultQuery: Codable {
  let amount: Double
  let from, to: String
}
