//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView:UIImageView!
    @IBOutlet var ratingStackView:UIStackView!

    var rating: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // Configure UI 
    func configureUI() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        ratingStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)

    }

    override func viewDidAppear(_ animated: Bool) {

        //SPRING Animation
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3,
        initialSpringVelocity: 0.5, options: [], animations: {
            self.ratingStackView.transform = CGAffineTransform.identity
        }, completion: nil)

    }
    
    @IBAction func ratingSelected(sender: UIButton) {
        switch sender.tag {
        case 1: rating = "dislike"
        case 2: rating = "good"
        case 3: rating = "great"
        default: break
        }
        print(sender.tag)
        performSegue(withIdentifier: "unwindToDetailView", sender: sender)
    }

   }
