//
//  NetworkManager.swift
//  HDRepositories
//
//  Created by Chinna Venkata Raju on 5/13/18.
//  Copyright © 2018 Chinna Venkata Raju. All rights reserved.
//

import Foundation
import SystemConfiguration
import Security

protocol RequestObject {
    var host:String{get}
    var path:String{get}
    var url:URL{get}
    var method:String{get}
    var header:[[String:Any]]?{get}
    var body:[String:Any]?{get}
    
    associatedtype response:DecodableResponse
}

protocol DecodableResponse {
    static func parse(data:Data,success:Bool)->Self?
}

typealias CompletetionBlock<T:RequestObject> = (_ success: Bool,_ response: T.response?,_ error: ErrorType?) -> Void

class NetworkManager: NSObject {
    
    //MARK: Singleton Instance
    static let sharedInstance = NetworkManager()
    
    //MARK:- Declare Error
    fileprivate var serverError:String? = "Cannot establish secure connection with App and Server, please try later."
    
    //MARK:- URL Request/Response
    func send<T:RequestObject>(requestObject:T,completion:@escaping CompletetionBlock<T>) {
        let url = requestObject.url
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = requestObject.method
        request.timeoutInterval = 10
        if requestObject.header != nil{
            for header in requestObject.header! {
                let key = header.keys.first
                request.setValue(header[key!] as? String, forHTTPHeaderField: key!)
            }
        }
        
        if requestObject.body != nil {
            let bodyData = try! JSONSerialization.data(withJSONObject: requestObject.body!, options: .prettyPrinted)
            var bodyStr = String(data: bodyData, encoding: .utf8)
            bodyStr = bodyStr?.replacingOccurrences(of: "\\", with: "")
            request.httpBody = bodyStr!.data(using: .utf8)!
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(false, nil, .Normal(error!.localizedDescription))
                return
            }
            guard response is HTTPURLResponse else{
                completion(false, nil, .Unknown)
                return
            }
            guard (response as! HTTPURLResponse).statusCode != ResponseCode.NotFound.rawValue else {
                completion(false, nil, .Normal("System Unavailable"))
                return
            }
            
            guard (response as! HTTPURLResponse).statusCode != ResponseCode.BadRequest.rawValue else {
                completion(false,nil,.Normal("Bad Request"))
                return
            }
            guard data != nil else {
                completion(false, nil, .Unknown)
                return
            }
            guard (response as! HTTPURLResponse).statusCode == ResponseCode.Success.rawValue else {
                let res = T.response.parse(data: data!, success: false)
                completion(false, res, nil)
                return
            }
            let res = T.response.parse(data: data!, success: true)
            
            guard res != nil else {
                completion(false, nil, .Normal("System Unavailable"))
                return
            }
            completion(true, res, nil)
        }
        task.resume()
    }
}

enum ResponseCode: Int {
    case InternalError = 500,
    NotFound = 404,
    Success = 200,
    BadRequest = 400,
    ServerTemporarilyUnavilable = 503
}

enum ErrorType:Error {
    case Unknown
    case Normal(String)
}
