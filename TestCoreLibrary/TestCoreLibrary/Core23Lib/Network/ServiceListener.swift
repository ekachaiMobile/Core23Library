//
//  ServiceListener.swift
//  Pods
//
//  Created by ekachai limpisoot on 4/15/16.
//
//

import Foundation
@objc protocol ServiceListener :NSObjectProtocol{
    @objc optional func startCall()
    @objc optional func updateFromCache(resp:ServiceResponse) -> Bool
    @objc optional func endCall(resp:ServiceResponse) -> Bool
}
