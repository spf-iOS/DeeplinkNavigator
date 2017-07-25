//
//  XibViewController.swift
//  DeeplinkNavigator
//
//  Created by Hanguang on 2017/7/9.
//  Copyright © 2017年 Hanguang. All rights reserved.
//

import UIKit

final class XibViewController: UIViewController, Titlable {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = identifier
    }
}

extension XibViewController: XibLifeCycleable {
    func navigationLoad(parameter: [String : Any]?, needRequest: Bool) {
//        print("xxxxxxxxxx:\(parameter) xxxxxneedRequest:\(needRequest)")
    }
}
