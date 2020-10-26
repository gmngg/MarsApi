//
//  CamerasCoordinator.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

protocol CamerasCoordinatorInput {
    func startApp()
}

protocol CamerasCoordinatorOutput {
}

class CamerasCoordinator: NSObject, CamerasCoordinatorInput {
    
    let curiosityCameraName = [CameraName.fhaz, CameraName.rhaz, CameraName.chemcam, CameraName.mahli]
    
    let otherRoverCamera = [CameraName.fhaz, CameraName.rhaz, CameraName.navcam, CameraName.pancam, CameraName.minites]
    
    var interactor: CamerasInteractorInput?
    var router: CamerasRouterInput?
    
    func startApp() {
        router?.startApp()
    }
}

extension CamerasCoordinator: CamerasViewModelOutput {
    func getModel(roverName: String, success: ((CameraItem) -> Void?)?, failure: ((Error) -> Void)?) {
        switch roverName {
        case RoverName.curiosity:
            for i in curiosityCameraName {
                for ins in 0...2 {
                    interactor?.getItems(
                        roverName: roverName,
                        cameraName: i,
                        dataSearch: LastDayUserSawRowerCameras.curioityCamerasDate[i]!.string(format: "yyyy-MM-dd"),
                        seccess: { [weak self] (datas) in
                            guard let countElJSON = datas.photos?.count else {
                                return }
                            
                            
                        }, failure: { (error) in
                            failure?(error)
                        })
                    LastDayUserSawRowerCameras.curioityCamerasDate[i]! = Calendar.current.date(
                        byAdding: .day,
                        value: -1,
                        to: LastDayUserSawRowerCameras.curioityCamerasDate[i]!)!
                }
            }
            
        case RoverName.opportunity:
            for i in otherRoverCamera {
                interactor?.getItems(
                    roverName: roverName,
                    cameraName: i,
                    dataSearch: String(LastDayUserSawRowerCameras.opportunityCamerasDate[i]!),
                    seccess: { [weak self] datas in
                        guard let countElJSON = datas.photos?.count else {
                            return
                        }
                        for i in datas.photos! {
                        }
                    }, failure: { (error) in
                        failure?(error)
                    })
                LastDayUserSawRowerCameras.opportunityCamerasDate[i]! -= 1
            }
            //success?(cameraItem!)
        default:
            for i in otherRoverCamera {
                interactor?.getItems(
                    roverName: roverName,
                    cameraName: i,
                    dataSearch: String(LastDayUserSawRowerCameras.spiritCamerasDate[i]!),
                    seccess: { [weak self] datas in
                        LastDayUserSawRowerCameras.spiritCamerasDate[i]! -= 1
                        guard let countElJSON = datas.photos?.count else {
                            return
                        }
                        
                        for i in datas.photos! {
                        }
                    }, failure: { (error) in
                        failure?(error)
                    })
                
                
            }
        //success?(cameraItem!)
        }
    }
    
}

