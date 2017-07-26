//
//  DeeplinkConvertible.swift
//  DeeplinkNavigator
//
//  Created by song on 2017/7/25.
//  Copyright © 2017年 Hanguang. All rights reserved.
//

import Quick
import Nimble
@testable import example

class DeeplinkConvertibleTests: QuickSpec {
        
    override func spec() {
        super.spec()
        
        describe("URL验证") {
            
            context("参数验证", closure: {
                
                it("alert", closure: {
                    expect("myapp://alert".queryParameters.isEmpty) == true
                })
                
                it("alert?", closure: {
                    expect("myapp://alert?".queryParameters.isEmpty) == true
                })
                
                it("alert?title", closure: {
                    expect("myapp://alert?title".queryParameters.isEmpty) == true
                })
                
                it("alert?title=", closure: {
                    expect("myapp://alert?title=".queryParameters) == ["title": ""]
                })
                
                it("alert?title=Hello+World!", closure: {
                    expect("myapp://alert?title=Hello+World!".queryParameters) == ["title": "Hello World!"]
                })
                
                it("alert?title=Hello%20World!", closure: {
                    expect("myapp://alert?title=Hello%20World!".queryParameters) == ["title": "Hello World!"]
                })
                
                it("title=Hello+World!&message=Nice+to+meet+you+:", closure: {
                    expect("myapp://alert?title=Hello+World!&message=Nice+to+meet+you+:".queryParameters) == ["title": "Hello World!", "message": "Nice to meet you :"]
                })
                
                it("title=Hello%20World!&message=Nice%20to%20meet%20you%20:", closure: {
                    expect("myapp://alert?title=Hello%20World!&message=Nice%20to%20meet%20you%20:)".queryParameters) == ["title": "Hello World!", "message": "Nice to meet you :)"]
                })

            })
        }
        
        describe("VCType验证") {
            context("VCType验证", closure: {
               it("InitViewController对应的URL", closure: {
                    let url = Navigator.url(InitViewController.self)
                    expect(url) == "navigator:/InitViewController"
               })
            })
        }
    }
}
