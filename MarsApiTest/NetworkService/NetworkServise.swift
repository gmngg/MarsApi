//
//  Network.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation
protocol NetworkServiseProtocol {
    func getItemsRover(roverName: String, cameraName: String, dataSearch: String, comletion: @escaping(Result<JSONPhoto?, Error>) -> Void)
}

class NetworkServise: NetworkServiseProtocol {
    func getItemsRover(roverName: String, cameraName: String, dataSearch: String, comletion: @escaping (Result<JSONPhoto?, Error>) -> Void) {
        self.fetchJSON(dataNow: dataSearch, roverName: roverName, cameraName: cameraName, response: comletion)
    }
    
    static let networkServise = NetworkServise()
    let requestNetwork = RequestNetwork()
    private func fetchJSON<T : Decodable> (
        dataNow: String,
        roverName: String,
        cameraName: String,
        response: @escaping(Result<T?, Error>) -> Void
    ) {
        requestNetwork.request(
            dataNow: dataNow,
            roverName: roverName,
            cameraName: cameraName,
            completion: { (result) in
            switch result {
            case .success(let data):
                let decodedData = self.decodeJSON(
                    type: T.self, from: data
                )
                response(.success(decodedData))
            case .failure(let error):                response(.failure(error))
            }
        }
        )
    }
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else {
            return nil
        }
        return response
    }
}
