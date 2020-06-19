//
//  Book.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 15/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

struct BookListResponse: Decodable {
    var results: BookResult?
}

struct BookResult: Decodable {
     var books: [Book]?
}

struct Book: Decodable {
    
    var title: String?
    var author: String?
    var description: String?
    var urlImage: String?
    
    enum CondingKeys: String, CodingKey {
        case title = "title"
        case author = "author"
        case description = "description"
        case urlImage = "book_image"
    }
    
}
