//
//  Injectable.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

protocol Injectable {
    associatedtype Container
    init(container: Container)
}
