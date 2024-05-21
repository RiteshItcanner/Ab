//
//  Constants.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import Foundation
import UIKit

var deviceId = UIDevice.current.identifierForVendor!.uuidString

struct Constants {
    
    // MARK: - API Endpoints
    struct API {
        static let baseURL = "https://\(Environment.BASE_API_URL)"
        static let loginEndpoint = "/login"
        // Add more API endpoints as needed
    }
    
    // MARK: - Keys
    struct AppKeys {
        static let userToken = "UserToken"
        static let userID = "UserID"
        static let fcmKey = "fcmKey"

        // Add more keys as needed
    }
    
    // MARK: - Identifiers
    struct Identifiers {
        static let cellIdentifier = "CustomCell"
        static let storyboardID = "MainStoryboard"
        // Add more identifiers as needed
    }
    
    // MARK: - Other Constants
    struct Other {
        static let defaultTimeoutInterval: TimeInterval = 30
        // Add more constants as needed
    }
    
    // MARK: - URLS
    struct URLs {
        static let privacyPolicy = "https://example.com/privacy"
        static let termsOfService = "https://example.com/terms"
        // Add more URLs as needed
    }
}
