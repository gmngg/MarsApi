//
//  CamerasViewModel.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

protocol CamerasViewModelInput {
}

protocol CamerasViewModelOutput {
    func getModel(roverName: String, success: ((CameraItem) -> Void?)?, failure: ((Error) -> Void)?)
}

protocol CamerasViewModelInterfase {
    var updateView: (() -> Void)? {get set}
    var photoItem: CameraItem? {set get}
    
    var roverName: String {get set}
    func getModel()
    
}

class CamerasViewModel: CamerasViewModelInterfase {
    func getModel() {
        output.getModel(roverName: roverName, success: { [weak self] (model) in
            for key in model.dictionary.keys {
               // self?.photoItem?.dictionary[key] = model.dictionary[key]
            }
            return Void()
        }, failure: { [weak self] error in
            print(error)
            
        })
        
    }
    
    var updateView: (() -> Void)?
    
    var output: CamerasViewModelOutput
    
    var roverName: String
    
    var photoItem: CameraItem? = CameraItem(dictionary: ["dsa": [.init(imageURL: "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631280305225E03_DXXX.jpg", dataPhoto: "2015-05-30"),.init(imageURL: "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631270503687E03_DXXX.jpg", dataPhoto: "2015-05-30")]])

    required init(container: Container) {
        roverName = container.roverName
        output = container.output
    }
}

extension CamerasViewModel: Injectable {
    struct Container {
        var roverName: String = RoverName.curiosity
        var output: CamerasViewModelOutput
    }
}
