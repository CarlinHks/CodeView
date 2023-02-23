//
//  GFError.swift
//  CodeView
//
//  Created by Carlos Pacheco on 17/02/23.
//

import Foundation

enum GFError: String, Error {
  case invalidUsername = "This username created an invalid request. Please try again."
  case unableToComplete = "Unable to complete your request. PLease check your internet connection"
  case invalidResponse = "Invalid response from server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
}
