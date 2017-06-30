//
//  WordsManager.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/20/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class Word: NSObject {
    var original: String = ""
    var translate: String = ""
    init(original: String, translate: String) {
        self.original = original
        self.translate = translate
    }
}

class WordManager {
    
    class var shared: WordManager {
        struct Static {
            static let instance = WordManager()
        }
        return Static.instance
    }
    
    private var defaults    = UserDefaults.standard
    private var words       =  [Word]()
    
    func addWord(word: Word) {
        print("adding")
        self.words.append(word)
        let wordToSave = Words(context: context)
        wordToSave.originalWord = word.original
        wordToSave.translatedWord = word.translate
        wordToSave.createdAt = Date() as NSDate?
        appDelegate.saveContext()
    }

    func getWords() -> [Word] {
        print("getting")

        var words = [Word]()
   
        do {
            let results = try context.fetch(Words.fetchRequest())
            if results.count > 0 {
                for result in results as! [NSManagedObject]{
                    let original = result.value(forKey: "originalWord") as? String
                    let translated = result.value(forKey: "translatedWord") as? String
                    let word = Word(original: original != nil ? original! : "", translate: translated != nil ? translated! : "")
                    words.append(word)
                    
                }
                return words
            }

        } catch {
            print("Fetching Failed")
        }
        return [Word]()
    }
   
}
