//
//  ApiService.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/15/16.
//
//

import Foundation
import Alamofire
import DeviceKit
public class ApiService : NSObject {
    static let sharedInstance = ApiService()
    
    class func decodeFromUTF8UsingISO1Latin( encStr : String?) -> String?{
        var encStr = encStr
        if encStr == nil {
            return nil;
        }
        if !(encStr! is String) {
            encStr = "\(encStr)"
        }
        let cstr = encStr!.cString(using: String.Encoding.isoLatin1)
        if (cstr == nil) {
            return encStr;
        }
        
        let decodedStr = String(cString: cstr!)
   
        if decodedStr.isEmpty {
            return nil;
        }
        return decodedStr;
    }
    
    
    class func isServiceResponseError(res :NSDictionary?,er:NSError?) -> ErrorRespose?{
        //res is error by my server , er is error by Alamofire
        var sr:ErrorRespose? = nil
        if er != nil {
            return ErrorRespose.getAlamofireError(er: er)
        }
        else if res == nil {
            return ErrorRespose.getSystemError()
        }else {
            if let code:NSNumber = res!["error_code"] as? NSNumber{
                let resCode:Int = Int(code)
                if (resCode == 0) {
                    return nil;// no error
                }else {
                    sr = ErrorRespose()
                    sr!.errCd = resCode;
                    let msgDt:String = res!["error_msg"] as! String;
                    sr!.msg = ApiService.decodeFromUTF8UsingISO1Latin(encStr: msgDt)!
                    let paramData:String? = res?["prm"] as? String;
                    sr?.prm = paramData;
                    return sr;
                }
            }else{
                return nil;// no error
            }
        }
    }
    
    class func reqToServerAsJSON(url: String, args:[String: AnyObject]!, isPost: Bool , completionHandler: @escaping (NSDictionary?, NSError?) -> ()) -> (Alamofire.Request?) {
        var request: Alamofire.Request?

        // set GET or POST method
        let param = args
        
        print("URL = \(url)?")
        print("param = \(args)")
        
        let deviceType = Device().model;
        let deviceVersion = Device().systemVersion;
        let devicePlatform = Device().systemName
        let sendUserAgent = "\(deviceType),\(deviceVersion),\(devicePlatform)"
        
        let headers = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Content-Type": "application/x-www-form-urlencoded",
            "Cache-Control" : "max-age=0",
            "User-Agent": sendUserAgent
        ]
        
        if isPost {
            
            request = Alamofire.request(url , method: .post , parameters: param, encoding: URLEncoding.default , headers: headers   ) //  encoding:.JSON
                .responseJSON { response in
                    switch response.result {
                    case .success(let responseValue):
                        completionHandler(responseValue as? NSDictionary, nil)
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                    } 
            }
        }
        else{
            request = Alamofire.request(url , method: .get , parameters: param, encoding: URLEncoding.default , headers: headers   )
                .responseJSON { response in
                    switch response.result {
                    case .success(let responseValue):
                        completionHandler(responseValue as? NSDictionary, nil)
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                    }
            }
        }
        return request
        
    }
    
}


