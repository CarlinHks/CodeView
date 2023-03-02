//
//  Date+ext.swift
//  CodeView
//
//  Created by Carlos Pacheco on 22/02/23.
//

import Foundation

extension Date {

//  func convertToMonthYearFormat() -> String {
//    let dateFormatter = DateFormatter()
//
//    dateFormatter.dateFormat = "MMM yyyy"
//
//    return dateFormatter.string(from: self)
//  }

  func convertToMonthYearFormat() -> String {
    return formatted(.dateTime.month().year())
  }

}
