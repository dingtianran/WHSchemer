//
//  ViewController.swift
//  WHSchemer
//
//  Created by Dingtr on 6/11/16.
//  Copyright © 2016 Dingtr. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var userNameField: NSTextField!
    @IBOutlet var passWordField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? NSVisualEffectView {
            // Make view translucent
            view.blendingMode = .behindWindow
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        userNameField.window?.makeFirstResponder(nil)
    }

}

