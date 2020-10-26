//
//  ModelDTO.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

struct CameraItem: Hashable {
    
    var dictionary: [String: [CameraData]]
}

struct CameraData: Hashable {
    var imageURL: String?
    var dataPhoto: String?
}

struct LastDayUserSawRowerCameras {
    
    static var curioityCamerasDate: [String: Date] = [
        CameraName.fhaz: Date(),
        CameraName.rhaz: Date(),
        CameraName.mast: Date(),
        CameraName.chemcam: Date(),
        CameraName.mahli: Date(),
        CameraName.mardi: Date(),
        CameraName.navcam: Date()]
    
    static var opportunityCamerasDate: [String: Int] = [
        CameraName.fhaz: 5111,
        CameraName.rhaz: 5111,
        CameraName.navcam: 5111,
        CameraName.pancam: 5111,
        CameraName.minites: 5111
    ]
    
    static var spiritCamerasDate: [String: Int] = [
        CameraName.fhaz: 2210,
        CameraName.rhaz: 2210,
        CameraName.navcam: 2210,
        CameraName.pancam: 2210,
        CameraName.minites: 2210
    ]
}

struct RoverName: Hashable {
    static let curiosity = "curiosity"
    static let opportunity = "opportunity"
    static let spirit = "spirit"
}

struct CameraName: Hashable {
    static let fhaz = "fhaz"
    static let rhaz = "rhaz"
    static let mast = "mast"
    static let chemcam = "shemcam"
    static let mahli = "mahli"
    static let mardi = "mardi"
    static let navcam = "navcam"
    static let pancam = "curiosity"
    static let minites = "minites"
}
