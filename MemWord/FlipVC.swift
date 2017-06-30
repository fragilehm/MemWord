//
//  FlipVC.swift
//  MemWord
//
//  Created by ITLabAdmin on 6/22/17.
//  Copyright © 2017 ICoder. All rights reserved.
//

import UIKit

class FlipVC: UIViewController {

    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    private var showingFront = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView.isHidden = true
        lblSecond.isHidden = true
        view.addSubview(firstView)
        view.addSubview(secondView)
        view.addSubview(lblFirst)
        view.addSubview(lblSecond)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(flip))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        //perform(#selector(flip), with: nil, afterDelay: 2)
        
    }
    func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: firstView, duration: 1.0, options: transitionOptions, animations: {
            self.firstView.isHidden = self.showingFront
        })
        UIView.transition(with: lblFirst, duration: 1.0, options: transitionOptions, animations: {
            self.lblFirst.isHidden = self.showingFront
        })
        
        UIView.transition(with: secondView, duration: 1.0, options: transitionOptions, animations: {
            self.secondView.isHidden = !self.showingFront
        })
        UIView.transition(with: lblSecond, duration: 1.0, options: transitionOptions, animations: {
            self.lblSecond.isHidden = !self.showingFront
        })
        showingFront = !showingFront
    }
}
