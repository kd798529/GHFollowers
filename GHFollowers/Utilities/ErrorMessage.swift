//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Kwaku Dapaah on 1/24/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unableTocomplete = "Unable to complete your request please check your internet connection"
    case invalidResponse = "Invalid Response from the server, please try again"
    case invalidData = "The data received from the server was invalid, please try again"
}
