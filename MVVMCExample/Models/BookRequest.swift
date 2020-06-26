//
//  BookRequest.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 15/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

class BookRequest: Request {
    var path: String {
        
        return "/lists/hardcover-fiction.json".stringByAppendAPIKey()
        
    }
    var method: HTTPMethods {
        return .get
    }
    
}
