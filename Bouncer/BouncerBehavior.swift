//
//  Bouncer.swift
//  Bouncer
//
//  Created by Victor Shurapov on 3/5/18.
//  Copyright © 2018 Victor Shurapov. All rights reserved.
//

import UIKit

class BouncerBehavior: UIDynamicBehavior {
    
    
    let gravity = UIGravityBehavior()
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    }()
    
    lazy var BlockBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedBlockBehavior = UIDynamicItemBehavior()
        lazilyCreatedBlockBehavior.allowsRotation = false
        lazilyCreatedBlockBehavior.elasticity = CGFloat(UserDefaults.standard.double(forKey: "BouncerBehavior.Elasticity"))
        lazilyCreatedBlockBehavior.friction = 0
        lazilyCreatedBlockBehavior.resistance = 0
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: nil) { (notification) in
            lazilyCreatedBlockBehavior.elasticity = CGFloat(UserDefaults.standard.double(forKey: "BouncerBehavior.Elasticity"))
        }
        return lazilyCreatedBlockBehavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(BlockBehavior)
    }
    
    func addBarrier(path: UIBezierPath, named name: String) {
        collider.removeBoundary(withIdentifier: name as NSCopying)
        collider.addBoundary(withIdentifier: name as NSCopying, for: path)
    }
    
    func addBlock(Block: UIView) {
        dynamicAnimator?.referenceView?.addSubview(Block)
        gravity.addItem(Block)
        collider.addItem(Block)
        BlockBehavior.addItem(Block)
    }
    
    func removeBlock(Block: UIView) {
        gravity.removeItem(Block)
        collider.removeItem(Block)
        BlockBehavior.removeItem(Block)
        Block.removeFromSuperview()
    }
}

