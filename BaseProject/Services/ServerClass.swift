//
//  ServerClass.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//


import UIKit
import Alamofire
import SwiftyJSON

var appLoginToken : String?

public struct ERNetworkManagerResponse {    /// The server's response to the URL request
    public let responseDict: NSDictionary?
    /// The error encountered while executing or validating the request.
    public let message: String?
    
    /// Status of the request.
    public let success: Bool?
    var _metrics: AnyObject?
    init(response: NSDictionary?, status: Bool?,error: String?) {
        
        self.message = error
        self.responseDict = response
        self.success = status
    }
}

class ServerClass: NSObject {
    var arrRes = [[String:AnyObject]]()
    class var sharedInstance:ServerClass {
        struct Singleton {
            static let instance = ServerClass()
        }
        return Singleton.instance
    }

    
    private static var Manager: Session = {
//        //change "kidyview.com" for live url
//        let manager = ServerTrustManager(evaluators: ["kidyview.com": DisabledTrustEvaluator()])
        
        // Change "chawtechsolutions.ch" for Staging url
        let manager = ServerTrustManager(evaluators: ["identity.prod.ltytech.ch": DisabledTrustEvaluator()])
        
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()
    
    
    func postRequestWithUrlParameters(_ sendJson:[String:Any], path:String, successBlock:@escaping (_ response: JSON )->Void , errorBlock: @escaping (_ error: NSError) -> Void ){
//        var headerField : [String : String] = [:]
        var headerField : HTTPHeaders = [:]
 
        let token = UserDefaults.standard.object(forKey: "token") as! String
        
        let dic = ["platform": "IOS", "browser": "", "browserVersion": "", "osVersion": "13", "deviceId": deviceId, "appVersion": "1.0", "ipAddress": "sdsd", "macAddress": ""]

        
        
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dic,
            options: []) {
            if let jsonString = String(data: theJSONData, encoding: .utf8) {
                headerField = ["Content-Type":"application/json", "Access-Token":token, "User_Agent": jsonString, "App-Token": UserDefaults.standard.value(forKey: Constants.AppKeys.fcmKey) as? String ?? ""]            }
            
        }
        
        ServerClass.Manager.request(path, method: .post, parameters: sendJson, encoding: JSONEncoding.default, headers: headerField).responseJSON { (response) in
            if response.response?.statusCode == 401 {
//               self.logOutUser()
            }
            switch response.result {
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))
            case .failure(let error):
                errorBlock(error as NSError)
            }
        }
    }
    
    func sendMultipartRequestToServer(urlString:String,fileName:String,  sendJson:[String:Any], imageUrl:URL?, successBlock:@escaping (  _ response: JSON)->Void , errorBlock: @escaping ( _ error: NSError) -> Void )
    {
        let token = UserDefaults.standard.object(forKey: "token") as! String
        var headerField : HTTPHeaders = ["Access-Token":token]

        AF.upload(multipartFormData: { multipartFormData in
            for (key,value) in sendJson {
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
                else
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                
            }
            if let url = imageUrl
            {
                multipartFormData.append(url, withName: fileName)
            }
        },to: urlString, method: .post, headers : headerField)
        .responseJSON {  response in
            if response.response?.statusCode == 403 {
                //self.manageSession()
            }
            switch response.result {
                
                
            case .success(let value):
                // print(String(data: value as! Data, encoding: .utf8)!)
                successBlock(JSON(value ))
                
            case .failure( let error):
                errorBlock(error as NSError)
                print("ERROR RESPONSE: \(error)")
            }
        }
        
    }

    
}

