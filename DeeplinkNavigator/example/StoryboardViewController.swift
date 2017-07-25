//
//  ViewController.swift
//  DeeplinkNavigator
//
//  Created by Hanguang on 13/03/2017.
//  Copyright © 2017 Hanguang. All rights reserved.
//

import UIKit

final class StoryboardViewController: UIViewController, Titlable {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = identifier
    }
}

extension StoryboardViewController: StoryboardLifeCycleable {
    public static func viewControllerFromStoryBoard(navigation: DeeplinkNavigation) -> UIViewController?{
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: String(describing: self)) as? StoryboardViewController{
            vc.navigation = navigation
            return  vc
        }
        
        return nil
    }
    
    func navigationLoad(parameter: [String : Any]?, needRequest: Bool) {
//        print("xxxxxxxxxx:\(parameter) xxxxxneedRequest:\(needRequest)")
    }
}
