//
//  RequestNetwork.swift
//  MarsApiTest
//
//  Created by Malygin Georgii on 23.10.2020.
//

import Foundation

protocol RequestNetworkProtocol {
    func request(
        dataNow: String,
        roverName: String,
        cameraName: String,
        completion: @escaping (Result<Data?, Error>) -> Void)
}

class RequestNetwork: RequestNetworkProtocol {
    private func urlFitst(dataNow: String, roverName: String, cameraName: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        switch roverName {
        case RoverName.curiosity:
            urlComponents.path = "/mars-photos/api/v1/rovers/\(roverName)/photos"
            urlComponents.queryItems = [URLQueryItem(name: "earth_date", value: dataNow), URLQueryItem(name: "camera", value: cameraName), URLQueryItem(name: "api_key", value: API.key)]
            
        default:
            urlComponents.path = "/mars-photos/api/v1/rovers/\(roverName)/photos?sol=\(dataNow)&camera=\(cameraName)&api_key=\(API.key)"
        }
        return urlComponents
    }
    private func createDataTask(
        from request: URLRequest,
        completion: @escaping (Result<Data?, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) {(
            data,
            response,
            error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(
                        .failure(error)
                    )
                } else {
                    completion(
                        .success(data)
                    )
                }
            }
        }
    }
    func request(
        dataNow: String,
        roverName: String,
        cameraName: String,
        completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let url = self.urlFitst(dataNow: dataNow, roverName: roverName, cameraName: cameraName).url else {
            return
        }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
}
