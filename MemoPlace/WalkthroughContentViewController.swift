//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by The Bao on 11/12/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    var index = 0
    var heading = ""
    var imgFile = ""
    var content = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = heading
        contentLabel.text = content
        imgView.image = UIImage(named: imgFile)
        pageControl.currentPage = index

        if index == 2 {
            nextButton.setTitle("DONE", for: .normal)
        }

    }

    @IBAction func nextPageButton() {
        switch index {
        case 0...1:
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index )
        case 2:
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)

        default: break
        }

    }




}
