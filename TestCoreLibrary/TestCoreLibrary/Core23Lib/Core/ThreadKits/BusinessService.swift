//
//  BusinessService.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/15/16.
//
//

import Foundation
import Alamofire
import Haneke

typealias OnServiceDidFinish = (ServiceResponse?) -> Void
typealias OnServiceInProgress = (NSDictionary?) -> Void

class BusinessService : NSObject{
    let cache = Shared.dataCache
    var requestService: Alamofire.Request?
    var listener: ServiceListener? = nil
    var onServiceDidFinish : OnServiceDidFinish!
    var onServiceInProgress : OnServiceInProgress!
    
    func pushServiceToQueue(method:Selector ,object arg:[String: AnyObject]?) {
        
        DispatchQueue.main.async(execute: {
            Thread.detachNewThreadSelector(method, toTarget:self, with:arg)
        })
        
    }
    
    func callStartCall(object :AnyObject?){
        if self.listener!.responds(to: #selector(ServiceListener.startCall)) {
            DispatchQueue.main.async(execute: {
                self.listener!.startCall!()
            })
        }
    }
    
    func callUpdateFromCache(resp:ServiceResponse){
        resp.caller = self;
        if (resp.errCd == ServiceResposeCancelService) {return}
        if self.listener!.responds(to: #selector(ServiceListener.updateFromCache)) {
            DispatchQueue.main.async(execute: {
                let _ = self.listener!.updateFromCache!(resp: resp)
            })
        }
    }
    
    func callendCall(resp:ServiceResponse){
    
        resp.caller = self;
        if (resp.errCd == ServiceResposeCancelService) {return}
        if self.listener!.responds(to: #selector(ServiceListener.endCall)) {
            DispatchQueue.main.async(execute: {
                let _ = self.listener!.endCall!(resp: resp)
            })
        }
        
        DispatchQueue.main.async(execute: {
            if self.onServiceDidFinish != nil{
                self.onServiceDidFinish(resp);
            }
        })
        
        
    }
    
    func callstartCall(resp:ServiceResponse){
        
        resp.caller = self;
        
        if self.listener!.responds(to: #selector(ServiceListener.startCall)) {
            DispatchQueue.main.async(execute: {
                self.listener!.startCall!()
            })
        }
    }
    
    func cancel(){
        if self.requestService != nil {
            self.requestService!.cancel()
            print("cancel service")
        }
    }
    
}
