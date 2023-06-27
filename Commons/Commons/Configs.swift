//
//  Configs.swift
//  Commons
//
//  Created by hoseinAlimoradi on 6/23/23.
//

import Foundation

// App Globals
public let APP_NAME = " "
public let APP_LINK = " "
public let SHARED_FROM_EXPENSO = """
  Shared from \(APP_NAME) App: \(APP_LINK)
  """


// User Defaults
public let UD_USE_BIOMETRIC = "useBiometric"
public let UD_EXPENSE_CURRENCY = "expenseCurrency"



// Transaction tags

public func getDateFormatter(date: Date?, format: String = "yyyy-MM-dd") -> String {
  guard let date = date else { return "" }
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = format
  return dateFormatter.string(from: date)
}

