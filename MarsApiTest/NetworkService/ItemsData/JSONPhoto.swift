//
//  File.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

struct JSONPhoto: Codable, Hashable {
    let photos: [PhotoItemsJSON]?
}

struct PhotoItemsJSON: Codable, Hashable {
    let id:  Int?
    let sol: Int?
    let camera: CameraInfoJSON?
    let img_src: String?
    let earth_date: String?
    let rover: RoverInfoJSON?
}

struct CameraInfoJSON: Codable, Hashable {
    let id: Int?
    let name: String?
    let roverId: Int?
    let cameraFullName: String?
}

struct RoverInfoJSON: Codable, Hashable {
    let id: Int?
    let name: String?
    let landing_date: String?
    let launch_date: String?
    let status: String?
}
