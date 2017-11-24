//
//  HomeViewController.swift
//  Shots-Implementing
//
//  Created by Jorge Luiz on 20/11/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backgroundMaskView: UIView!
    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var userOptionView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        headerView.backgroundColor = UIColor.clear
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = headerView.bounds
//        headerView.insertSubview(blurEffectView, at: 0)
        backgroundBlur(view: self.headerView, style: UIBlurEffectStyle.dark)
        backgroundBlur(view: self.backgroundMaskView, style: UIBlurEffectStyle.dark)
        
    }
    
    private func backgroundBlur(view: UIView, style:  UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func userButtonDidTouch(_ sender: UIButton) {
        self.userOptionView.isHidden = !self.userOptionView.isHidden
        
        let scale = CGAffineTransform(scaleX: 0.3, y: 0.3)
        let translate = CGAffineTransform(translationX: 50, y: -50)
        let transform = scale.concatenating(translate)
        self.userOptionView.transform = transform
        
        
        self.userOptionView.alpha = 0
        UIView.animate(withDuration: 0.4, animations: {
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            let transform = scale.concatenating(translate)
            self.userOptionView.transform = transform

            self.userOptionView.alpha = 1
        })
    }
    
    @IBAction func likeButtonDidTouch(_ sender: UIButton) {
        print("like button pressed")
    }
    
    @IBAction func shareButtonDidTouch(_ sender: UIButton) {
        print("share button pressed")
        let scale = CGAffineTransform(translationX: 0, y: 200)
        self.shareView.transform = scale
        
        UIView.animate(withDuration: 0.5) {
            self.shareView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.shareView.isHidden = false
        }
    }
    
    @IBAction func imageButtonDidPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.7, animations: {
            self.popoverView.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
            self.popoverView.layer.cornerRadius = 0
            self.imageButton.frame = CGRect(x: 0, y: 0, width: 320, height: 240)
            
            self.likeButton.alpha = 0
            self.shareButton.alpha = 0
            self.userButton.alpha = 0
            self.headerView.alpha = 0
        }, completion: { finished in
            self.performSegue(withIdentifier: "homeToDetail", sender: self)
        })
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
