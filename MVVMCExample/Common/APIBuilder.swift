//
//  APIService.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 12/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
}

class APIBuilder {
    
    func sendRequest(url: String, method: HTTPMethods, header: [String: String]? = nil, body: [String: Any]? = nil, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        
        let url = URL (string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let session = URLSession(configuration: .default)
        
        print("📤request:", urlRequest)
        print("----------------------------)")
        
        setHeader(with: &urlRequest, header: header)
        
        setBody(with: &urlRequest, body: body)
        
        task(with: session, urlRequest: urlRequest, completion: completion)
        
    }
    
    func setHeader(with urlRequest: inout URLRequest, header: [String: String]?) {
        
        if let header = header {
            urlRequest.allHTTPHeaderFields = header
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            print("Header:", header)
            print("----------------------------)")
            
        }
        
    }
    
    func setBody(with urlRequest: inout URLRequest, body: [String: Any]?) {
        
        if let body = body {
            urlRequest.httpBody = try?
                JSONSerialization.data(withJSONObject: body)
            
            print("Body:", body)
            print("----------------------------)")
            
        }
        
    }
    
    func task(with session: URLSession, urlRequest: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let response = response {
                print("📥Response:", response)
            }
            
            if let data = data {
                let jsonString =  String(data: data, encoding: String.Encoding.utf8)
                
                print("Json:" , jsonString?.data(using: String.Encoding.utf8)? .prettyPrintedJsonString ?? "Error deconding data object to String")
            }
            
            print("----------------")
            
            completion(data, response, error)
        }
        
        task.resume()
        
    }
    
}
