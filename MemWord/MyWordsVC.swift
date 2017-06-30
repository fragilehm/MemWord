//
//  MyWordsVC.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/17/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import UIKit

class MyWordsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnGridView: UIButton!
    @IBOutlet weak var btnListView: UIButton!
    
    var isGrid              = false
   // var mainBackgroundColor = UIColor.gray
   // var cellBackgroundColor = UIColor.white
    var cellId              = "CardCell"
    var colorManager: ColorStyle!
    var words = [Word]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        words = WordManager.shared.getWords()
        let color = ColorStyle(primary: UIColor.gray, secondary: UIColor.white, fontColor: UIColor.black)
        ColorManager.shared.initialize(style: color)
        colorManager = ColorManager.shared.get()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        words = WordManager.shared.getWords()
        colorManager = ColorManager.shared.get()
        collectionView.backgroundColor = colorManager.primary
        print(colorManager.primary)
        print("hello")
        collectionView.reloadData()
    }
    
    @IBAction func btnGrid(_ sender: Any) {
        isGrid = true
        collectionView.reloadData()
    }
    
    @IBAction func btnList(_ sender: Any) {
        isGrid = false
        collectionView.reloadData()
    }
}

extension MyWordsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardCell
        let word = words[indexPath.row]
        print(word)
        
        
        cell.backgroundColor = colorManager.secondary
        cell.lblOriginal.text = word.original
        cell.lblOriginal.textColor = colorManager.fontColor
        cell.lblTranslated.text = word.translate
        cell.lblTranslated.textColor = colorManager.fontColor

        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth: CGFloat = collectionView.frame.width - 40
        var w: CGFloat
        var h: CGFloat
        
        if  (!isGrid) {
            w = screenWidth
            h = w * 3 / 8
            
        } else {
            w = screenWidth / 2
            h = w
        }
        return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
}

extension MyWordsVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CheckVC") as! CheckVC
        let word = words[indexPath.row]
        vc.originalWord = word.original
        vc.translatedWord = word.translate
        self.navigationController?.show(vc, sender: self)
    }
}
