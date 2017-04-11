//
//  ServiceResponse.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/15/16.
//
//

import Foundation
public let ServiceResposeSuccess: Int = 0
public let ServiceResposeErrorSystemError: Int = 4001
public let ServiceResposeCancelService: Int = -999
public let ServiceResposeErrorSystemErrorMSG: String =  "System Error,Please try again."

public class ServiceResponse : NSObject {
    
    var errCd: Int = 0
    var caller: AnyObject!
    var objectResult: AnyObject!
    var msg: String = ""
    var tag: String = ""
    
    class func getRespsWithRslt(rslt: AnyObject) -> ServiceResponse {
        let sr = ServiceResponse()
        sr.errCd = 0
        sr.objectResult = rslt
        if ((rslt is NSDictionary) == true){
            let info : NSDictionary = rslt as! NSDictionary
            if let error_code = info["error_code"] as? String{
                sr.errCd = Int(error_code)!
                
            }
            if let error_msg = info["error_msg"] as? String{
                sr.msg = error_msg
            }
        }
        return sr
    }

    func success() -> Bool {
        return (errCd == ServiceResposeSuccess)
    }
}


class ErrorRespose : ServiceResponse{
    var prm:String? = ""
    class func getSystemError() -> ErrorRespose {
        let sr : ErrorRespose = ErrorRespose();
        sr.errCd = ServiceResposeErrorSystemError;
        sr.msg = ServiceResposeErrorSystemErrorMSG;
        return sr;
    }
    class func getAlamofireError(er:NSError?) -> ErrorRespose {
        let sr : ErrorRespose = ErrorRespose();
        sr.errCd = (er?.code)!;
        if er?.userInfo["NSLocalizedDescription"] != nil{
            sr.msg = er?.userInfo["NSLocalizedDescription"] as! String;
        }
        else if er?.userInfo["NSDebugDescription"] != nil{
            sr.msg = er?.userInfo["NSDebugDescription"] as! String;
        }
        else{
            sr.msg = ServiceResposeErrorSystemErrorMSG;
        }
        
        return sr;
    }
}
