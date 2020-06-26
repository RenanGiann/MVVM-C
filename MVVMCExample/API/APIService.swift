//
//  APIService.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 15/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

protocol NYTimesAPIProtocol {
    func sendRequest<T: Decodable>(requestObj: Request, completion: @escaping (Result<T, Error>) -> Void)
}

protocol Request {
    var path: String { get }
    var method: HTTPMethods { get }
    var body: [String: Any]? { get }
    var header: [String: String]? { get }
    
}

extension Request {
    var body: [String: Any]? {
        return nil
    }
    
    var header: [String: String]? {
        return nil
    }
}

class APIService: NYTimesAPIProtocol {
    
    private let baseURL = "https://api.nytimes.com/svc/books/v3"
    static let apiKey = "RQ31UWrd4CV24nxNpqqplHJR2EcoYkxL"
    private let builder = APIBuilder()
    
    private func sendBuilderRequest<T>(
        requestObj: Request,
        completion: @escaping (Result<T, Error>) -> Void,
        decodingWith decode: @escaping (JSONDecoder, Data) throws -> T) {
        
        let url = baseURL + requestObj.path
        
        return builder.sendRequest(
            url: url,
            method: requestObj.method,
            header: requestObj.header,
            body: requestObj.body) { (data, response, error) in
                
                guard let data = data else {
                    
                    let err = error ?? NSError(domain: "", code: -1, userInfo: nil)
                    return completion(.failure(err))
                    
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    try completion(.success(decode(decoder, data)))
                    
                } catch let decondingError {
                    
                    completion(.failure(decondingError))
                    
                }
        }
        
    }
    
    public func sendRequest<T: Decodable>(
        requestObj: Request,
        completion: @escaping (Result<T, Error>) -> Void) {
        
        return sendBuilderRequest(requestObj: requestObj, completion: completion) { (decoder, data) in
            try decoder.decode(T.self, from: data)
        }
        
    }
    
}
