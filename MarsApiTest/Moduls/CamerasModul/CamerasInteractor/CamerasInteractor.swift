//
//  CamerasInteractor.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

protocol CamerasInteractorInput {
    func getItems(roverName: String, cameraName: String, dataSearch: String, seccess: ((JSONPhoto) -> Void)?, failure: ((Error) -> Void)?)
}

protocol CamerasInteractorOutput {
}

class CamerasInteractor: CamerasInteractorInput {
    func getItems(roverName: String, cameraName: String, dataSearch: String, seccess: ((JSONPhoto) -> Void)?, failure: ((Error) -> Void)?) {
        networkServise.getItemsRover(roverName: roverName, cameraName: cameraName, dataSearch: dataSearch, comletion: { (response) in
            switch response {
            case .success(let data):
                guard let sdata = data else {
                    return
                }
                seccess?(sdata)
            case .failure(let error):
                failure?(error)
            }
            
        })
    }
    
    let networkServise: NetworkServiseProtocol
    
    required init(container: Container) {
        networkServise = container.networkServise
    }
}

extension CamerasInteractor: Injectable {
    struct Container {
        let networkServise: NetworkServiseProtocol
    }
}
