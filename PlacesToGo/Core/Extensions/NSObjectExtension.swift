//
//  NSObjectExtension.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation

extension NSObject {

    func getBundle() -> Bundle {
        let bundle = Bundle(for: Self.self)
        return bundle
    }
    
    func getClassId() -> String {
        
        var classId: String = self.classForCoder.description()
        if let name = classId.components(separatedBy: ".").last {
            classId = name
        }
        return classId
    } 
}

extension Data {
    
    func toDictionary() -> [String: Any]? {
        var dictionaryValue: [String: Any]?
        do {
            let dictFromData = try PropertyListSerialization
                                   .propertyList(from: self,
                                                 options: PropertyListSerialization.ReadOptions.mutableContainers,
                                                 format: nil) as? [String: Any]
            if let dict = dictFromData {
               dictionaryValue = dict  
            }
        } catch{
            print(error)
        }
       return dictionaryValue 
    }

    func toJsonString() -> String? {
        guard let jsonString = String(bytes: self, encoding: .utf8)
            else { return nil }

        return jsonString
    }
}

extension Dictionary {

    func toJson() -> String? {

        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
           let jsonText = String(data: data, encoding: String.Encoding.utf8) {
           return jsonText
        }
        return nil
    }

}
