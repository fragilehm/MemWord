//
//  AddWordVC.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/17/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddWordVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var lblOriginal: UITextField!

    @IBOutlet weak var lblTranslated: UITextField!
    
    @IBAction func btnTranslate(_ sender: Any) {
        let source = "en"
        let target = "ru"
        let text = lblOriginal.text
        let url = "https://translate.yandex.net/api/v1.5/tr.json/translate?" + "lang=" + source + "-" + target
        let key = "trnsl.1.1.20170628T090157Z.9dcf00fb956522ab.452f2e36484df1a96a6fbd3f69e305b46d9572b8"
        
        let translateText: String = "\(url)&key=\(key)&text=\(text!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Alamofire.request(translateText).responseJSON { (response) in
            
            let jsonArray = JSON(response.data!)["text"].arrayValue
            print(JSON(response.data!))
            print(JSON(response.data!)["text"])
            
            self.lblTranslated.text = jsonArray[0].stringValue
            print(jsonArray[0])
        }

    }
    // MARK: - Navigation

    @IBAction func btnAddWord(_ sender: Any) {
//        UserDefaults.standard.setValue(lblTranslated.text, forKey: "\
        //(lblOriginal.text)")
        if lblOriginal.text != "" {
            let word = Word(original: lblOriginal.text!, translate: lblTranslated.text!)
            WordManager.shared.addWord(word: word)
           // dictWords[lblOriginal.text!] = lblTranslated.text
          //  defaults.removeObject(forKey: "myWords")
           // defaults.set(dictWords, forKey: "myWords")
        }
        self.navigationController?.popViewController(animated: true)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "MyWordsVC") as! MyWordsVC
//        self.present(viewController, animated: true, completion: nil)
        //        print("\(UserDefaults.standard.value(forKey: "\(lblOriginal.text)")!)")
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
