//
//  ActionRequest_BService.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/19/16.
//
//

import Foundation
class ActionRequest_BService : BusinessService{
    
    override func cancel(){
        super.cancel()
    }
    
    
    func get_highlight_banner(param: [String: AnyObject]?) {
        self.requestService = ActionRequest_ApiService().get_highlight_banner(param: param){ serviceResponse in
            return self.callendCall(resp: serviceResponse)
        }
    }
    
    
}
