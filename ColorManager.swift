//
//  File.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/24/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ColorStyle: NSObject{
    
    var primary: UIColor!
    var secondary: UIColor!
    var fontColor: UIColor!
    
    init(primary: UIColor, secondary: UIColor, fontColor: UIColor) {
        self.primary = primary
        self.secondary = secondary
        self.fontColor = fontColor
    }
   
}
class ColorManager {
    private var defaults    = UserDefaults.standard
    class var shared: ColorManager {
        
        struct Static {
            static let instance = ColorManager()
        }
        return Static.instance
    }
    
    func update(style: ColorStyle) {
        let primary = style.primary.encode()
        let secondary = style.secondary.encode()
        let fontColor = style.fontColor.encode()   // Encoding the color to data
        do {
            let results = try context.fetch(Colors.fetchRequest())
            if results.count > 0 {
                let result = results.first as! NSManagedObject
                result.setValue(primary, forKey: "primary")
                result.setValue(secondary, forKey: "secondary")
                result.setValue(fontColor, forKey: "fontColor")
            }
                
        } catch {
            print("Fetching Failed")
        }
        appDelegate.saveContext()
            }
    func get() -> ColorStyle {
        let color = ColorStyle(primary: UIColor.gray, secondary: UIColor.white, fontColor: UIColor.black)
        do {
            let results = try context.fetch(Colors.fetchRequest())
            if results.count > 0 {
                let result = results.first as! NSManagedObject
                let primary = result.value(forKey: "primary")
                let secondary = result.value(forKey: "secondary")
                let fontColor = result.value(forKey: "fontColor")
                let color = ColorStyle(primary: UIColor.color(withData: primary as! Data), secondary: UIColor.color(withData: secondary as! Data), fontColor: UIColor.color(withData: fontColor as! Data))
                return color

            }
            
        } catch {
            print("Fetching Failed")
        }

        return color
    }
    func initialize(style: ColorStyle){
        let primary = style.primary.encode()
        let secondary = style.secondary.encode()
        let fontColor = style.fontColor.encode()   // Encoding the color to data
        let colorsToSave = Colors(context: context)
        colorsToSave.primary = primary as NSObject
        colorsToSave.secondary = secondary as NSObject
        colorsToSave.fontColor = fontColor as NSObject
        appDelegate.saveContext()

    }
    
}
extension UIColor {
    class func color(withData data:Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}
