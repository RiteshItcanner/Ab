//
//  Environment.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 20/05/24.
//

import Foundation

enum Environment {
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist not found.")
        }
        return dict
    }()
    
    static let BASE_API_URL: URL = {
        guard let urlString = Environment.infoDict["BASE_API_URL"] as? String else {
            fatalError("BASE_API_URL not found.")
        }
        guard let url = URL(string: urlString) else {
            fatalError("BASE_API_URL not found.")
        }
        return url
    }()
}
