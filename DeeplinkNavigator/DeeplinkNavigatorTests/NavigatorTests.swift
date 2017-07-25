//
//  NavigatorTests.swift
//  DeeplinkNavigator
//
//  Created by song on 2017/7/25.
//  Copyright © 2017年 Hanguang. All rights reserved.
//

import Quick
import Nimble
@testable import example

//MARK: 测试Navigator各种跳转方法


class NavigatorTests: QuickSpec {
        
    override func spec(){
      super.spec()
        
        NavigatorViewControllerObj.register()
        
        let nav = UINavigationController.init(rootViewController: UIViewController())
        
        var viewController:UIViewController!
        
        var urlType:UIViewController.Type!
        
        describe("通用跳转-各种方法验证") {
            
            context("open方法验证", closure: {
                
                var boo = false
                beforeEach {
                    let url = "navigator://InitNavigable"
                    boo = Navigator.open(url)
                }
                
                it("验证通过", closure: {
                    expect(boo).toEventually(equal(true))
                })
            })
            
            context("present-ViewController方法验证", closure: {
                beforeEach {
                    urlType = InitViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = InitViewController()
                    Navigator.present(viewController, wrap: true, from: nav, animated: false, completion: nil)
                }
                
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                
//                it("跳转成功", closure: {
//                    beforeEach({ () -> Void in
//                        // 方法2: 触发.viewDidLoad(), .viewWillAppear(), 和 .viewDidAppear() 事件
//                        viewController.beginAppearanceTransition(true, animated: false)
//                        viewController.endAppearanceTransition()
//                    })
//
//                    expect(nav).toEventually(equal(viewController.presentingViewController), timeout: 3)
//                })
                
            })
            
            
            context("present-url方法验证", closure: {
                
                let contextParamter:[String : Any] = ["CityCode":3,"name":"凯迪克"]
                
                beforeEach {
                    let url = "InitViewController"
                    urlType = InitViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.present(url, context: contextParamter, wrap: true, from: nav, animated: false, completion: nil)
                }
                
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                
                it("遵从InitProtocol", closure: {
                    expect(viewController).to(beAKindOf(InitLifeCycleable.self))
                })
                
                it("参数传递成功", closure: {
                    let lifeCycle = viewController as! LifeCycleable
                    guard let param = lifeCycle.navigation?.parameter else {
                        XCTFail("参数为空")
                        return
                    }
                    print("URL传参验证  paramter is \(param)")
                    let boo = contextParamter == param
                    expect(boo).to(equal(true))
                })
                
//                it("跳转成功", closure: {
//                    beforeEach({ () -> Void in
//                        // 方法2: 触发.viewDidLoad(), .viewWillAppear(), 和 .viewDidAppear() 事件
//                        viewController.beginAppearanceTransition(true, animated: false)
//                        viewController.endAppearanceTransition()
//                    })
//                    expect(nav).toEventually(equal(viewController.presentingViewController), timeout: 3)
//                })

            })
            
            
            context("push-ViewController方法验证", closure: {
                beforeEach {
                    urlType = InitViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = InitViewController()
                    Navigator.push(viewController, from: nav, animated: false)
                }
                
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })

                it("跳转成功", closure: {
                    let lastVC = nav.viewControllers.last
                    expect(lastVC).toEventually(equal(viewController))
                })
                
            })
            
            context("push-url方法验证", closure: {
                
                let contextParamter:[String : Any] = ["CityCode":3,"name":"凯迪克"]
                
                beforeEach {
                    let url = "InitViewController"
                    urlType = InitViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url, context: contextParamter, from: nav, animated: false)
                }
                
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                
                it("遵从InitProtocol", closure: {
                    expect(viewController).to(beAKindOf(InitLifeCycleable.self))
                })
                
                it("参数传递成功", closure: {
                    let lifeCycle = viewController as! LifeCycleable
                    guard let param = lifeCycle.navigation?.parameter else {
                        XCTFail("参数为空")
                        return
                    }
                    print("URL传参验证  paramter is \(param)")
                    let boo = contextParamter == param
                    expect(boo).to(equal(true))
                })
 
                it("跳转成功", closure: {
                    let lastVC = nav.viewControllers.last
                    expect(lastVC).toEventually(equal(viewController))
                })
 
            })
            
            context("pop-url方法验证", closure: {
                
                let contextParamter:[String : Any] = ["CityCode":3,"name":"凯迪克"]
                
                beforeEach {
                    let url = "InitViewController"
                    urlType = InitViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = InitViewController()
                    nav.pushViewController(viewController, animated: false)
                    viewController = Navigator.popTo(url, context: contextParamter, from: nav, animated: false)
                }
                
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                
                it("遵从InitProtocol", closure: {
                    expect(viewController).to(beAKindOf(InitLifeCycleable.self))
                })
                
                it("跳转成功", closure: {
                    let lastVC = nav.viewControllers.last
                    expect(lastVC).toEventually(equal(viewController))
                })
                
            })
            
        }
        
    }
    
}
