//
//  String+.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 15/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

extension String {
    
    func stringByAppendAPIKey() -> String {
        return stringByAppendingURL(query: "api-key", value: APIService.apiKey)
    }
    
    func stringByAppendingURL(value: String) -> String {
        return "\(self)/\(value)"
    }
    func stringByAppendingURL(query: String, value: String) -> String {
        var separator = "?"
        
        if self.range(of: separator) != nil {
            separator = "&"
        }
        
        return "\(self)\(separator)\(query)=\(value)"
    }
    
}
