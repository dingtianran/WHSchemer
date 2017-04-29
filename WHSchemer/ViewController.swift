//
//  ViewController.swift
//  WHSchemer
//
//  Created by Dingtr on 6/11/16.
//  Copyright © 2016 Dingtr. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSComboBoxDataSource, NSComboBoxDelegate, NSPopoverDelegate {
    
    @IBOutlet var userNameField: NSTextField!
    @IBOutlet var passWordField: NSTextField!
    @IBOutlet var loginStatus: NSTextField!
    @IBOutlet var countryFromBox: NSComboBox!
    @IBOutlet var genderBox: NSComboBox!
    @IBOutlet var countryBirthBox: NSComboBox!
    @IBOutlet var personalCountryBox: NSComboBox!
    //credit card info
    @IBOutlet var crd1Field: NSTextField!
    @IBOutlet var crd2Field: NSTextField!
    @IBOutlet var crd3Field: NSTextField!
    @IBOutlet var crd4Field: NSTextField!
    @IBOutlet var vd1Field: NSTextField!
    @IBOutlet var vd2Field: NSTextField!
    @IBOutlet var cvvField: NSTextField!
    
    var detachedWindow: NSWindow?
    var detachedHUDWindow: NSPanel?
    var creditPopover = NSPopover()
    var popOverVC: TipPopoverViewController!
    
    let countries: [Country] = {
        var all = Countries.allOf()
        all.sort(by: { (coun1: Country, coun2: Country) -> Bool in
            return coun1.id < coun2.id
        })
        return all
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let view = self.view as? NSVisualEffectView {
            // Make view translucent
            view.blendingMode = .behindWindow
        }
        
        WHVNetworking.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(statusChangeHandler), name: NSNotification.Name(rawValue: kStatusChangedNotification), object: nil)
        
        creditPopover.behavior = .transient
        creditPopover.animates = true
        popOverVC = self.storyboard?.instantiateController(withIdentifier: "PopoverViewController") as! TipPopoverViewController
        creditPopover.contentViewController = popOverVC
        creditPopover.delegate = self
        
        let frame = self.popOverVC.view.bounds
        var mask: NSWindowStyleMask = [.titled, .closable]
        let rect = NSWindow.contentRect(forFrameRect: frame, styleMask: mask)
        detachedWindow = NSWindow(contentRect: rect, styleMask: mask, backing: .buffered, defer: true)
        detachedWindow?.contentViewController = popOverVC
        detachedWindow?.isReleasedWhenClosed = false
        
        mask = [.titled, .closable, .hudWindow, .utilityWindow]
        detachedHUDWindow = NSPanel(contentRect: rect, styleMask: mask, backing: .buffered, defer: true)
        detachedHUDWindow?.contentViewController = popOverVC
        detachedHUDWindow?.isReleasedWhenClosed = false
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        countryBirthBox.reloadData()
        personalCountryBox.reloadData()
    }
    
    func statusChangeHandler(noti: NSNotification) {
        if WHVNetworking.status != .Outsider {
            loginStatus.stringValue = "😉"
        } else {
            loginStatus.stringValue = "😩"
        }
    }
    
    @IBAction func disclaimerBtnTouchUpInside(sender: AnyObject) {
        if detachedHUDWindow?.isVisible == true {
            detachedHUDWindow?.close()
        }
        
        if detachedWindow?.isVisible == true {
            // popover is already detached to a separate window, so select its window instead
            detachedWindow?.makeKeyAndOrderFront(self)
            return;
        }
        
        let targetButton = sender as! NSButton
        creditPopover.show(relativeTo: targetButton.bounds, of: targetButton, preferredEdge: .maxX)
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        userNameField.window?.makeFirstResponder(nil)
        passWordField.window?.makeFirstResponder(nil)
        WHVNetworking.loginAs(username: userNameField.stringValue, password: passWordField.stringValue)
    }
    
    //MARK: - NSComboBoxDataSource
    func numberOfItems(in comboBox: NSComboBox) -> Int {
        return countries.count
    }
    
    func comboBox(_ comboBox: NSComboBox, objectValueForItemAt index: Int) -> Any? {
        let country = countries[index]
        return country.idStr + " - " + country.name
    }
    
    //MARK: - NSComboBoxDelegate
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if let comboBox = notification.object as? NSComboBox {
            if comboBox == countryBirthBox {
                
            } else if comboBox == personalCountryBox {
                
            }
        }
    }
}

