//
//  WalkthroughPageViewController.swift
//  MemoPlace
//
//  Created by The Bao on 11/12/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController{

    
    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent = ["Pin your favorite restaurants and create your own food guide",
    "Search and locate your favourite restaurant on Maps", "Find restaurants pinned by your friends and other foodies around the world"]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        // Create the first walkthrough screen
        if let startingViewController = viewControllerAtIndex(index: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }


    func viewControllerAtIndex(index: Int) -> WalkthroughContentViewController? {

        // Check condition for numbers of page 
        if index == NSNotFound || index < 0 || index >= pageHeadings.count {
            return nil
        }

        // Create controller and pass suitable data 
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.imgFile = pageImages[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index 
            return pageContentViewController
        }
        return nil
    }
    func forward(index: Int){
        if let nextViewController = viewControllerAtIndex(index: index + 1){
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

}
//MARK: UIPageViewController DATASOURCE
extension WalkthroughPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return viewControllerAtIndex(index: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return viewControllerAtIndex(index: index)
    }

    
}

