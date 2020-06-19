//
//  Data+.swift
//  MVVMCExample
//
//  Created by Renan Giannella​  on 12/06/20.
//  Copyright © 2020 cristina. All rights reserved.
//

import Foundation

extension Data {
    var prettyPrintedJsonString: NSString? {
        
        guard let obj = try? JSONSerialization.jsonObject(with: self, options: []), let data =  try? JSONSerialization.data(withJSONObject: obj, options: [.prettyPrinted]), let prettyPrintedJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedJson
    }
}
