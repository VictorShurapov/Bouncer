//
//  ViewController.swift
//  Bouncer
//
//  Created by Victor Shurapov on 3/5/18.
//  Copyright © 2018 Victor Shurapov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameView: UIView!
    
    let bouncer = BouncerBehavior()
    lazy var animator: UIDynamicAnimator = { UIDynamicAnimator(referenceView: self.view) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(bouncer)
    }
    
    struct Constants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    
    var redBlock: UIView?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if redBlock == nil {
            redBlock = addBlock()
            redBlock?.backgroundColor = .red
            bouncer.addBlock(Block: redBlock!)
        }
        let motionManager = AppDelegate.Motion.Manager
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                if let checkedData = data {
                    self.bouncer.gravity.gravityDirection = CGVector(dx: checkedData.acceleration.x, dy: -checkedData.acceleration.y)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.Motion.Manager.stopAccelerometerUpdates()
    }
    
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zero, size: Constants.BlockSize))
        block.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        self.gameView.addSubview(block)
        return block
    }
}

