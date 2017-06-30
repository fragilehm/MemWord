//
//  ColorPickerVC.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/22/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import UIKit
//import SwiftHSVColorPicker
import ChromaColorPicker

class ColorPickerVC: UIViewController {
    
    var background: String!
    private var neatColorPicker: ChromaColorPicker!
    private var colorPickerManager = ColorManager.shared
    private var primaryColor: UIColor!
    private var secondaryColor: UIColor!
    private var fontColor: UIColor!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        primaryColor = colorPickerManager.get().primary
        secondaryColor = colorPickerManager.get().secondary
        fontColor = colorPickerManager.get().fontColor
        neatColorPicker = ChromaColorPicker(frame: CGRect(x: (screenWidth - 300) / 2, y: 60, width: 300, height: 300))
        view.addSubview(neatColorPicker)
        
        neatColorPicker.padding = 0
        neatColorPicker.hexLabel.isHidden = true
        neatColorPicker.addButton.isEnabled = false
        neatColorPicker.layout()
    }
    
    
    
    @IBAction func btnColor(_ sender: Any) {
        print(neatColorPicker.currentColor)
        
            switch self.background {
                case "main":
                    primaryColor = neatColorPicker.currentColor
                case "cell":
                    secondaryColor = neatColorPicker.currentColor
                default:
                    fontColor = neatColorPicker.currentColor
            
            }
        
            colorPickerManager.update(style: ColorStyle(primary: primaryColor, secondary: secondaryColor, fontColor: fontColor))
        
            self.navigationController?.popViewController(animated: true)
           // self.tabBarController.
        }
    
}
extension ChromaColorPickerDelegate {
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor){
        print(color)
        print("hello")
    }
}
