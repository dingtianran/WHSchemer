//
//  ViewController.swift
//  WHSchemer
//
//  Created by Dingtr on 6/11/16.
//  Copyright © 2016 Dingtr. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSComboBoxDataSource {
    
    @IBOutlet var userNameField: NSTextField!
    @IBOutlet var passWordField: NSTextField!
    @IBOutlet var genderBox: NSComboBox!
    @IBOutlet var countryBirthBox: NSComboBox!
    @IBOutlet var personalCountryBox: NSComboBox!
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
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        countryBirthBox.reloadData()
        personalCountryBox.reloadData()
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        userNameField.window?.makeFirstResponder(nil)
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
}

