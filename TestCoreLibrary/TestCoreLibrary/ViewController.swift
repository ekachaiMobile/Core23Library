//
//  ViewController.swift
//  TestCoreLibrary
//
//  Created by ekachai limpisoot on 4/10/17.
//  Copyright © 2017 ekachai limpisoot. All rights reserved.
//

import UIKit
import SwiftyJSON
class ViewController: UIViewController,ServiceListener {
    var listLoader_bService:Loader_BService!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getHomeListService() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func getHomeListService() {
        let param:[String: AnyObject] = ["page" : "1" as AnyObject ,
                                         "type_view" : "latest_view" as AnyObject]
     
        self.listLoader_bService = Loader_BService()
        self.listLoader_bService.listener = self
        self.listLoader_bService.pushServiceToQueue(method:#selector(Loader_BService.get_homelist(param:)), object: param)
        self.listLoader_bService.onServiceDidFinish = { (resp) in
         
        }
    }
    
    
    
    func endCall(resp res : ServiceResponse) ->Bool{
    
        print(res.success())
        if res.caller.isEqual(self.listLoader_bService){
            if res.success(){
            let response_obj_result:JSON = JSON(res.objectResult)
            print(response_obj_result)
                
            self.listLoader_bService.cancel()
            self.listLoader_bService = nil
            }
        }  else{
            
        }
        return true
    }

}

