//
//  BundleExtension.swift
//  PlacesToGo
//
//  Created by Claudio Smith on 06/12/2020.
//  Copyright © 2020 smith.c. All rights reserved.
//

import Foundation

extension Bundle {
    
    func loadData(from file: String, `extension`: String = Constants.json) -> Data? {
        
        guard let fileURL = self.url(forResource: file, withExtension: `extension`) else {
            print(Constants.fileNotFound)
            return nil
        }
        do {
            let content = try Data(contentsOf: fileURL)
            return content
            
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func loadJson(from file: String, `extension`: String = Constants.json) -> [String: Any]? {
        
        if let path = self.path(forResource: file, ofType: `extension`) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                   return jsonResult
                }
            } catch { print(error) }
            print(Constants.fileNotFound)
        }
        return nil
    }
    
}
