//
//  GameViewController.swift
//  PhysicsObserver
//
//  Created by Robert Anderson on 16/01/2015.
//  Copyright (c) 2015 Rob Anderson. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: self.view.frame.size)
		
		// Configure the view.
		let skView = self.view as! SKView
		skView.ignoresSiblingOrder = true
		scene.scaleMode = .AspectFill
		
		skView.presentScene(scene)
        
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
	
	
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
	
	override func shouldAutorotate() -> Bool {
		return true
	}
}
