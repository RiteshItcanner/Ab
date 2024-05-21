//
//  Services.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 19/05/24.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

class Services: NSObject, UITextFieldDelegate {
    
    static let shareInstance = Services()
    
    //MARK:  Api Call Method for Post Mathod
    
    func postRequestApi<T: Codable>(url: String,method:String,passToken:Bool,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
    {

        //code to register user
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method
        let dataDictionary = dataDict
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            
            urlRequest.httpBody = requestBody
            
            let dic = ["platform": "IOS", "browser": "", "browserVersion": "", "osVersion": "13", "deviceId": deviceId, "appVersion": "1.0", "ipAddress": "sdsd", "macAddress": ""]
            
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: dic,
                options: []) {
                //            let theJSONText = String(data: theJSONData,
                //                                     encoding: .ascii)
                //            print("JSON string = \(theJSONText!)")
                if let jsonString = String(data: theJSONData, encoding: .utf8) {
                    urlRequest.setValue(jsonString, forHTTPHeaderField: "User_Agent")
                    
                }
                
            }
            
//            urlRequest.setValue(dic.description, forHTTPHeaderField: "User_Agent")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if passToken {
                let token = UserDefaults.standard.object(forKey: "token")
                
                urlRequest.setValue(token as! String, forHTTPHeaderField: "Access-Token")
                
            }
            
            
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
           // print(HTTPURLResponse().statusCode)
            if(data != nil && data?.count != 0)
            {
                do{
                    
                    let result = try JSONDecoder().decode(expecting, from: data!)

                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
                
                // let response = String(data: data!, encoding: .utf8)
                // debugPrint(response)
            }else{
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }
    
    
    //MARK:  Api Call Method for Put Mathod
    
    func putRequestApi<T: Codable>(url: String,method:String,isPassToken:Bool ,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
       {
           //code to register user
           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = method
           let dataDictionary = dataDict
          
           do {
               let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
               
               let dic = ["platform": "IOS", "browser": "", "browserVersion": "", "osVersion": "13", "deviceId": deviceId, "appVersion": "1.0", "ipAddress": "sdsd", "macAddress": ""]
               
               if let theJSONData = try? JSONSerialization.data(
                   withJSONObject: dic,
                   options: []) {
                   
                   if let jsonString = String(data: theJSONData, encoding: .utf8) {
                       urlRequest.setValue(jsonString, forHTTPHeaderField: "User_Agent")
                       
                   }
                   
               }

               urlRequest.httpBody = requestBody
               urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")

               if isPassToken {
                   
                   let token = UserDefaults.standard.object(forKey: "token")
                   
                   urlRequest.addValue(token as! String, forHTTPHeaderField: "Access-Token")
               }
               else {
                   urlRequest.addValue("test", forHTTPHeaderField: "data-hash")
                   urlRequest.addValue("test", forHTTPHeaderField: "device-id")
               }


           } catch let error {
               debugPrint(error.localizedDescription)
           }

           URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

               if(data != nil && data?.count != 0)
               {
                      do{
                         
                          let result = try JSONDecoder().decode(expecting, from: data!)
                         // let result = String(data: data!, encoding: .utf8)
                          completion(.success(result))
                       }
                       catch{
                           completion(.failure(error))
                       }
            
                  // let response = String(data: data!, encoding: .utf8)
                  // debugPrint(response)
               }else{
                   if let error = error {
                       completion(.failure(error))
                   }else{
                       completion(.failure(NetworkError.invalidData))
                   }
               }
           }.resume()
       }
    
    //MARK: Get Api Call Method
    
    func requestGetApi<T: Codable>(url: URL?, shouldSendHeader: Bool,expecting: T.Type ,completion: @escaping(Result<T,Error>) -> Void){
        
        var urlRequest = URLRequest(url: url!)

        if shouldSendHeader {
           // var urlRequest = URLRequest(url: url!)
            let token = UserDefaults.standard.object(forKey: "token")
            urlRequest.httpMethod = "get"
            urlRequest.setValue(token as! String, forHTTPHeaderField: "Access-Token")
           urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")

        }

        
        
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _,error in
    
        guard let data = data else {
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.failure(NetworkError.invalidData))
            }
           return
           }
            do{
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
        }
    

    //MARK:- Register  phone 
    func register<T: Codable>(url: String,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
       {
           //code to register user
           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = "put"
           let dataDictionary = dataDict
          
           do {
               let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)

               urlRequest.httpBody = requestBody
               urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
               urlRequest.addValue("test", forHTTPHeaderField: "data-hash")
               urlRequest.addValue("test", forHTTPHeaderField: "device-id")


           } catch let error {
               debugPrint(error.localizedDescription)
           }

           URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

               if(data != nil && data?.count != 0)
               {
                      do{
                         
                          let result = try JSONDecoder().decode(expecting, from: data!)
                          
                        //  try result.encode(to: "Status" as! Encoder)
                         // let result = String(data: data!, encoding: .utf8)
                          completion(.success(result))
                       }
                       catch{
                           completion(.failure(error))
                       }
            
                  // let response = String(data: data!, encoding: .utf8)
                  // debugPrint(response)
               }else{
                   if let error = error {
                       completion(.failure(error))
                   }else{
                       completion(.failure(NetworkError.invalidData))
                   }
               }
           }.resume()
       }
    
    //MARK:  Api Call Method for Update phone and email id
    
    func putRequestApiForUpdatePhoneEmail<T: Codable>(url: String,method:String,passToken:Bool,expecting: T.Type,dataDict: Dictionary<String,Any>,completion: @escaping(Result<T,Error>) -> Void)
    {
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = method
        let dataDictionary = dataDict
        
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            
            urlRequest.httpBody = requestBody
            urlRequest.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"IOS\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"\(deviceId)\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}", "App-Token": UserDefaults.standard.value(forKey: Constants.AppKeys.fcmKey) as? String ?? ""]
            
            if passToken {
                let token = UserDefaults.standard.object(forKey: "token")
                urlRequest.setValue(token as? String, forHTTPHeaderField: "Access-Token")
            }
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if(data != nil && data?.count != 0)
            {
                do{
                    let result = try JSONDecoder().decode(expecting, from: data!)
                    
                    completion(.success(result))
                }
                catch{
                    completion(.failure(error))
                }
            }else{
                if let error = error {
                    completion(.failure(error))
                }else{
                    completion(.failure(NetworkError.invalidData))
                }
            }
        }.resume()
    }

}


extension UIApplication {

    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }

        return base
    }
}

class ErrorReporting {

    static func showMessage(title: String, msg: String) {
        let alert = UIAlertController(title: "Alert", message: "Please check your internet", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
    }
}
