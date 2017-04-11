//
//  NSObject+NameOfClass.swift
//  airmosphere
//
//  Created by ekachai limpisoot on 4/30/16.
//  Copyright © 2016 com.airasia. All rights reserved.
//

import Foundation
public extension NSObject{
    public class var nameOfClass: String{
        return NSStringFromClass(self).components(separatedBy:".").last!
    }
    
    public var nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy:".").last!
    }
}
