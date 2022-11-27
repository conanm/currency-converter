//
//  Extensions.swift
//  currency-converter-andela
//
//  Created by Conan Moriarty on 25/11/22.
//

import UIKit

// Convenience method for loading local JSON easily with decoder
// credit: https://www.hackingwithswift.com/example-code/system/how-to-decode-json-from-your-app-bundle-the-easy-way
extension Bundle {
  func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to locate \(file) in bundle.")
    }
    
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to load \(file) from bundle.")
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = dateDecodingStrategy
    decoder.keyDecodingStrategy = keyDecodingStrategy
    
    do {
      return try decoder.decode(T.self, from: data)
    } catch DecodingError.keyNotFound(let key, let context) {
      fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
    } catch DecodingError.typeMismatch(_, let context) {
      fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
      fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
    } catch DecodingError.dataCorrupted(_) {
      fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
    } catch {
      fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
    }
  }
}

extension Date {
  
  func dateString(daysDifference: Int) -> String {
    // TODO: add validation or this can crash due to !
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    print(self)
    let day = Calendar.current.date(byAdding: .day, value: daysDifference, to: self)!
    return dateFormatter.string(from: day)
  }
  
}

// Convenience method to quickly add done button to any textfield (need to set the option in IB)
// credit: https://stackoverflow.com/questions/28338981/how-to-add-done-button-to-numpad-in-ios-using-swift
extension UITextField {
  @IBInspectable var doneAccessory: Bool{
    get{
      return self.doneAccessory
    }
    set (hasDone) {
      if hasDone{
        addDoneButtonOnKeyboard()
      }
    }
  }
  
  func addDoneButtonOnKeyboard()
  {
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    doneToolbar.barStyle = .default
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
    
    let items = [flexSpace, done]
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    
    self.inputAccessoryView = doneToolbar
  }
  
  @objc func doneButtonAction()
  {
    self.resignFirstResponder()
  }
}
