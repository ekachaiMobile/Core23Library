//
//  ListLoader_BService.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/15/16.
//
//

import Foundation
class Loader_BService : BusinessService{
    
    override func cancel(){
        super.cancel()
    }
    
    func get_homelist(param: [String: AnyObject]?) {
        
        //check Data
        let current_class = self.nameOfClass
        let current_method = "get_homelist";
        var params_string = ""
        if param != nil {
            for (key, value) in param! {
                params_string = params_string + key + "=" + (value as! String)
            }
        }
        
        let cache_key : String = current_class + current_method + params_string
        
        self.cache.fetch(key: cache_key).onSuccess { data in
            //                let dicfromData:NSDictionary? = Utility_AkeKit().DatatoDictionary(data)
            //                let foundationDictionary = NSMutableDictionary(dictionary: dicfromData!)
            //                self.callUpdateFromCache(resp: ServiceResponse.getRespsWithRslt(rslt: foundationDictionary))
        }
        
        //load api
        self.requestService = Loader_ApiService().get_homelist(param: param){ serviceResponse in
            //save cache
            //                if serviceResponse.objectResult != nil{
            //                    let ditoData : NSData = Utility_AkeKit().DictionarytoData(serviceResponse.objectResult)!
            //                    self.cache.set(value: ditoData, key: cache_key)
            //                }
            return self.callendCall(resp: serviceResponse)
        }
    }
    
    

    
    func get_country_display(param: [String: AnyObject]?) {
        
        self.requestService = Loader_ApiService().get_country_display(param: param){ serviceResponse in
            if  serviceResponse.objectResult != nil {
                let result = serviceResponse.objectResult["result"]
            }
            return self.callendCall(resp: serviceResponse)
        }
        
        
    }

    
    
}
