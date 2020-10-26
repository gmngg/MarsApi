//
//  ExtensionData.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 25.10.2020.
//

import Foundation

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
