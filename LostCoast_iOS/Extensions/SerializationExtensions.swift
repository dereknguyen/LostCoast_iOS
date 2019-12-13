//
//  SerializeExtensions.swift
//  LostCoast_API
//
//  Created by Derek Nguyen on 8/31/18.
//  Copyright © 2018 Derek Nguyen. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum ProjectError: Error {
    case encodingError
}

extension Encodable {
    
    func toJSON(excluding keys: [String] = [String]()) throws -> [String : Any] {
        
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        
        guard var json = jsonObject as? [String : Any] else { throw ProjectError.encodingError }
        
        for key in keys {
            json[key] = nil
        }
        
        return json
    }
    
}

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type) throws -> T {
        let documentData = try JSONSerialization.data(withJSONObject: data() ?? [:], options: [])
        return try JSONDecoder().decode(objectType, from: documentData)
    }
    
}
