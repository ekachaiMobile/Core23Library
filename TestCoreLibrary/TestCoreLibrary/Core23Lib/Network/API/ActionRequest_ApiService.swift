//
//  ActionRequest_ApiService.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/20/16.
//
//

import Foundation
import CryptoSwift
import Alamofire
class ActionRequest_ApiService : ApiService{
    let BASE_URL = "https://www.airmosphere.net/mobile_feed/"
    
    func get_highlight_banner(param: [String: AnyObject]? , completionHandler: @escaping (ServiceResponse) -> ()) -> (Alamofire.Request?) {
        
        let method: String = "mobile_feed/highlight_banner"
        let url: String = "\(BASE_URL)\(method)" 
        
        let req = ApiService.reqToServerAsJSON(url: url, args: param, isPost: false){ responseData, error in
            let response_info :NSDictionary? = responseData
            
            let resService = ApiService.isServiceResponseError(res: response_info, er: error);
            if resService != nil {//error
                return completionHandler(resService!)
                
            }
            return completionHandler(ServiceResponse.getRespsWithRslt(rslt: response_info!))
        }
        return req
    }
    
    
}
