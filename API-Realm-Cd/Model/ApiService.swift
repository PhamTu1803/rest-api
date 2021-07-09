//
//  ApiService.swift
//  API-Realm-Cd
//
//  Created by phamtu on 08/07/2021.
//

import Foundation
import UIKit

typealias ApiCompletion = (_ data: Any?, _ error: Error?) -> ()

typealias ApiParam = [String: Any]

enum ApiMethod: String {
    case GET = "GET"
    case POST = "POST"
}
extension String {
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            if value is String {
                let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            }
            else {
                return "\(percentEscapedKey)=\(value)"
            }
        }
        return parameterArray.joined(separator: "&")
    }
}
class APIService:NSObject {
    static let shared: APIService = APIService()

    func requestSON(_ url: String,
                    param: ApiParam?,
                    method: ApiMethod,
                    loading: Bool,
                    completion: @escaping ApiCompletion)
    {
        var request:URLRequest!
        
        // set method & param
        if method == .GET {
            if let paramString = param?.stringFromHttpParameters() {
                request = URLRequest(url: URL(string:"\(url)?\(paramString)")!)
            }
            else {
                request = URLRequest(url: URL(string:url)!)
            }
        }
        else if method == .POST {
            request = URLRequest(url: URL(string:url)!)
            
            // content-type
            let headers: Dictionary = ["Content-Type": ""]
            request.allHTTPHeaderFields = headers
            
            do {
                if let p = param {
                    request.httpBody = try JSONSerialization.data(withJSONObject: p, options: .prettyPrinted)
                }
            } catch { }
        }
        
        request.timeoutInterval = 30
        request.httpMethod = method.rawValue
        
        //
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                // check for fundamental networking error
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                
                // check for http errors
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200, let res = response {
                }
                
                if let resJson = self.convertToJson(data) {
                    completion(resJson, nil)
                }
                else if let resString = String(data: data, encoding: .utf8) {
                    completion(resString, error)
                }
                else {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    private func convertToJson(_ byData: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: byData, options: [])
        } catch {
            //            self.debug("convert to json error: \(error)")
        }
        return nil
    }
    
    func GetCharacter(closure: @escaping (_ response: [CharacterModel]?, _ error: Error?) -> Void) {
        requestSON("https://rickandmortyapi.com/api/character", param: nil, method: .GET, loading: true) { (data, error) in
            if let d = data as? [String: Any] {
                var listCharacterReturn:[CharacterModel] = [CharacterModel]()
                if let listCharacter = d["results"] as? [[String : Any]] {
                    for item1 in listCharacter{
                        var characterAdd:CharacterModel = CharacterModel()
                        characterAdd = characterAdd.initLoad(item1)
                        listCharacterReturn.append(characterAdd)
                        print(listCharacterReturn)
                    }
                }
                
                closure(listCharacterReturn, nil)
            }
            else {closure(nil,nil)}
        }
    }
    func GetLocation(closure: @escaping (_ response: [LocationModel]?, _ error: Error?) -> Void) {
        requestSON("https://rickandmortyapi.com/api/location", param: nil, method: .GET, loading: true) { (data, error) in
            if let d = data as? [String: Any] {
                var listLocationReturn:[LocationModel] = [LocationModel]()
                if let listLocation = d["results"] as? [[String : Any]] {
                    for item1 in listLocation{
                        var locationAdd:LocationModel = LocationModel()
                        locationAdd = locationAdd.initLoad(item1)
                        listLocationReturn.append(locationAdd)
                        print(listLocationReturn)
                    }
                }
                
                closure(listLocationReturn, nil)
            }
            else {closure(nil,nil)}
        }
    }
}
