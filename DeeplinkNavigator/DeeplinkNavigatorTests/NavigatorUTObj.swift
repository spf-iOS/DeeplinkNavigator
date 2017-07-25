//
//  NavigatorUTObj.swift
//  DeeplinkNavigator
//
//  Created by song on 2017/7/24.
//  Copyright © 2017年 Hanguang. All rights reserved.
//

import UIKit
@testable import example

class NavigatorUTObj {
    
    static func isXibVC(vc:UIViewController?) -> Bool{
       return vc is XibViewController
    }
    
    static func register(){
        Navigator.scheme = "navigator"
        Navigator.map("InitViewController", InitViewController.self, context: "I am a InitViewController")
        Navigator.map("XibViewController", XibViewController.self, context: "I am a XibViewController")
        Navigator.map("StoryboardViewController", StoryboardViewController.self, context: "I am a StoryboardViewController")
        Navigator.map("navigator://<path>") {(url, context, from, values) -> Bool in
            return Navigator.push(url) != nil
        }
    }
}

extension Dictionary :Equatable {
    public static func == (lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>) -> Bool {
        if lhs.keys.count != rhs.keys.count  {
            return false
        }
        
        var isSame = true
        
        for (key,value) in lhs {
            if rhs.keys.contains(key){
                
                if let lvalue = value as? String, let rvalue = rhs[key] as? String{
                    isSame = (lvalue == rvalue)
                    if !isSame { break }
                }
                else if let lvalue = value as? NSNumber, let rvalue = rhs[key] as? NSNumber{
                    isSame = (lvalue == rvalue)
                    if !isSame { break }
                }
                else if let lvalue = value as? Dictionary, let rvalue = rhs[key] as? Dictionary{
                    isSame = (lvalue == rvalue)
                    if !isSame { break }
                }
                else {
                    isSame = false
                    if !isSame { break }
                }
            }
            else{
                isSame = false
                if !isSame { break }
            }
        }
        return isSame
    }

}
