//
//  ViewController.swift
//  WHSchemer
//
//  Created by Dingtr on 6/11/16.
//  Copyright © 2016 Dingtr. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSComboBoxDataSource, NSComboBoxDelegate {
    
    @IBOutlet var userNameField: NSTextField!
    @IBOutlet var passWordField: NSTextField!
    @IBOutlet var loginStatus: NSTextField!
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
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        countryBirthBox.reloadData()
        personalCountryBox.reloadData()
    }
    
    func statusChangeHandler(noti: NSNotification) {
        if Thread.isMainThread == true {
            print("a")
        }
        if WHVNetworking.status != .Outsider {
            loginStatus.stringValue = "😉"
        } else {
            loginStatus.stringValue = "😩"
        }
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

