import SwiftUI
import Charts

struct StepCount: Identifiable {
  let id = UUID()
  let date: Date
  let value: Double
  
  init(date: String, value: Double) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    self.date = formatter.date(from: date) ?? Date.distantPast
    self.value = value
  }
}

struct HistoricalDataChartView: View {
  let rates:[Rate]
  init(rates:[Rate]) {
    self.rates = rates
  }
  
  var body: some View {
    Chart {
      ForEach(rates) {
        LineMark(
          x: .value("Date", $0.dateValue(), unit: .day),
          y: .value("Value", $0.value)
        )
      }
    }
  }
}
