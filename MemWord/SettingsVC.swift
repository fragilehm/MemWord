//
//  SettingsVC.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/17/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import UIKit
//import SwiftHSVColorPicker
class SettingsVC: UIViewController {

    @IBOutlet weak var SettingsTableVC: UITableView!
    
    var settings = ["main background color", "cell background color", "text color"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension SettingsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableVC.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        cell.lblSettings.text = settings[indexPath.row]
        return cell
    }
    
}
extension SettingsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ColorPickerVC") as! ColorPickerVC
        let rowName = settings[indexPath.row]
        vc.background = rowName == "main background color" ? "main" : rowName == "text color" ? "text" :  "cell"
        self.navigationController?.show(vc, sender: self)
    }
}
