//
//  BookListService.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 15/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

protocol NYTimesStoreProtocol {
    func requestBooks(completion: @escaping(Result<[Book], Error>) -> Void)
}

class BookListService: NYTimesStoreProtocol {
    
    private let service: NYTimesAPIProtocol
    
    init(service: APIService = APIService()) {
        self.service = service
    }
    
    private func requestListHardCover(completion: @escaping (Result<BookListResponse, Error>) -> Void) {
        
        let request = BookRequest()
        
        service.sendRequest(requestObj: request, completion: completion)
    }
    
    func requestBooks(completion: @escaping(Result<[Book], Error>) -> Void) {
        requestListHardCover { (result) in
            
            switch result {
            case .success(let response):
                guard let books = response.results?.books else {
                    
                    let error = NSError(domain: "Livros não encontrados", code: -1, userInfo: nil)
                    completion(.failure(error))
                    return
                    
                }
                
                completion(.success(books))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
}
