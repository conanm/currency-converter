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

let currentWeek: [StepCount] = [
  StepCount(date: "2022-11-25", value: 1.1),
  StepCount(date: "2022-11-24", value: 1.321251),
  StepCount(date: "2022-11-23", value: 1.12112)
]

struct HistoricalDataChartView: View {
  var body: some View {
    Chart {
      ForEach(currentWeek) {
        LineMark(
          x: .value("Date", $0.date, unit: .day),
          y: .value("Value", $0.value)
        )
      }
    }
    
  }
}

struct HistoricalDataChartView_Previews: PreviewProvider {
  static var previews: some View {
    HistoricalDataChartView()
  }
}
