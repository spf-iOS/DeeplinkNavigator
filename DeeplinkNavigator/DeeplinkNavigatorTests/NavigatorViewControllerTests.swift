//
//  NavigatorUT.swift
//  DeeplinkNavigator
//
//  Created by song on 2017/7/24.
//  Copyright © 2017年 Hanguang. All rights reserved.
//

import Quick
import Nimble
@testable import example

//MARK: 测试Navigator的内部实现

//MARK: - 在方法名前加'x',可以屏蔽此方法的测试  在方法名前加'f',可以只测试这些加'f'的测试

class NavigatorViewControllerTests: QuickSpec {
        
    override func spec(){
        super.spec()
        
        NavigatorViewControllerObj.register()
        
        let nav = UINavigationController.init(rootViewController: UIViewController())
        
        var viewController:UIViewController!
        
        describe("通用跳转-初始化方式验证") {
            
            var urlType:UIViewController.Type!
            
            context("Init初始化验证", closure: {
                beforeEach {
                    let url = "InitViewController"
                    urlType = InitViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url, context: nil, from: nav, animated: false)
                }
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                
                it("遵从InitProtocol", closure: {
                    expect(viewController).to(beAKindOf(InitLifeCycleable.self))
                })
            })
            
            context("Xib初始化验证", closure: {
                beforeEach {
                    let url = "XibViewController"
                    urlType = XibViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url, context: nil, from: nav, animated: false)
                }
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                
                it("遵从XibProtocol", closure: {
                    expect(viewController).to(beAKindOf(XibLifeCycleable.self))
                })
            })
            
            context("Storyboard初始化验证", closure: {
                beforeEach {
                    let url = "StoryboardViewController"
                    urlType = StoryboardViewController.self
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url, context: nil, from: nav, animated: false)
                }
                it("初始化成功", closure: {
                    expect(viewController).to(beAKindOf(urlType))
                })
                it("遵从StoryboardProtocol", closure: {
                    expect(viewController).to(beAKindOf(StoryboardLifeCycleable.self))
                })
            })
            
        }
        
        
        describe("通用跳转—参数验证") {
            
            let url = "InitViewController"
            
            context("URL传参验证", closure: {
                
                let urlParamter:[String : Any] = ["code":"4","address":"上海"]
                
                beforeEach {
                    let urlParamterString = "?code=4&address=上海"
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url + urlParamterString, context: nil, from: nav, animated: false)
                }
                it("参数传递成功", closure: {
                    let lifeCycle = viewController as! LifeCycleable
                    guard let param = lifeCycle.navigation?.parameter else {
                        XCTFail("参数为空")
                        return
                    }
                    print("URL传参验证  paramter is \(param)")
                    let boo = urlParamter == param
                    expect(boo).to(equal(true))
                })
            })
            
            context("context传参验证", closure: {
                let contextParamter:[String : Any] = ["CityCode":3,"name":"凯迪克"]
                beforeEach {
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url , context: contextParamter, from: nav, animated: false)
                }
                
                it("参数传递成功", closure: {
                    let lifeCycle = viewController as! LifeCycleable
                    guard let param = lifeCycle.navigation?.parameter else {
                        XCTFail("参数为空")
                        return
                    }
                    print("context传参验证  paramter is \(param)")
                    let boo = contextParamter == param
                    expect(boo).to(equal(true))
                })
            })
            
            context("context + URL传参验证", closure: {
                
                let urlParamter:[String : Any] = ["code":"4","address":"上海"]
                let contextParamter:[String : Any] = ["CityCode":3,"name":"凯迪克"]
                var allParamter:[String : Any] = urlParamter
                
                for (key,value) in contextParamter{
                   allParamter[key] = value
                }
                
                beforeEach {
                    let urlParamterString = "?code=4&address=上海"
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url + urlParamterString, context: contextParamter, from: nav, animated: false)
                }

                it("参数传递成功", closure: {
                    let lifeCycle = viewController as! LifeCycleable
                    guard let param = lifeCycle.navigation?.parameter else {
                        XCTFail("参数为空")
                        return
                    }
                    print("context + URL传参验证  paramter is \(param)")
                    let boo = allParamter == param
                    expect(boo).to(equal(true))
                })
            })
            
        }
        
        
        describe("通用跳转-跳转验证") {
            
            context("跳转验证", closure: {
                
                beforeEach {
                    let url = "InitViewController"
                    nav.popToRootViewController(animated: false)
                    viewController = Navigator.push(url, context: nil, from: nav, animated: false)
                }
                
//                beforeEach({ () -> Void in
//                    // 方法2: 触发.viewDidLoad(), .viewWillAppear(), 和 .viewDidAppear() 事件
//                    viewController.beginAppearanceTransition(true, animated: false)
//                    viewController.endAppearanceTransition()
//                })
                
                it("跳转成功", closure: { () -> () in
                    let lastVC = nav.viewControllers.last
//                    expect(lastVC == viewController).toEventually(equal(true), timeout: 3)
                    expect(lastVC).toEventually(equal(viewController))
                })
            })
        }
        
    }
}
