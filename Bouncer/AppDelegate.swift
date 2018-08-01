//
//  AppDelegate.swift
//  Bouncer
//
//  Created by Victor Shurapov on 3/5/18.
//  Copyright © 2018 Victor Shurapov. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    struct Motion {
        static let Manager = CMMotionManager()
    }

}

