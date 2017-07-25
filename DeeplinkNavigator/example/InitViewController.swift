//
//  TestViewController.swift
//  DeeplinkNavigator
//
//  Created by Hanguang on 14/03/2017.
//  Copyright © 2017 Hanguang. All rights reserved.
//

import UIKit

final class InitViewController: UIViewController, Titlable {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = identifier
        view.backgroundColor = UIColor.blue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}

extension InitViewController: InitLifeCycleable {
    func navigationLoad(parameter: [String : Any]?, needRequest: Bool) {
//        print("xxxxxxxxxx:\(parameter) xxxxxneedRequest:\(needRequest)")
    }
}
