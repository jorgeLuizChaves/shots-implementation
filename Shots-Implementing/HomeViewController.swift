//
//  HomeViewController.swift
//  Shots-Implementing
//
//  Created by Jorge Luiz on 20/11/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit
import Spring

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
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var buttonMask: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet var panRecognizer: UIPanGestureRecognizer!
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var snapBehavior: UISnapBehavior!
    var position: Int = 0
    var data = getData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundBlur(view: self.headerView, style: UIBlurEffectStyle.dark)
        backgroundBlur(view: self.backgroundMaskView, style: UIBlurEffectStyle.dark)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        self.popoverView.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(Bool())
        
        self.popoverView.alpha = 0
        let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        let translation = CGAffineTransform(translationX: 0, y: -300)
        popoverView.transform = translation.concatenating(scale)
        
        SpringAnimation.spring(duration: 0.7, animations: {
            self.popoverView.alpha = 1
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translation = CGAffineTransform(translationX: 0, y: 0)
            self.popoverView.transform = translation.concatenating(scale)
        })
        
        self.authorLabel.text = data[position]["author"]
        self.titleLabel.text = data[position]["title"]
        self.imageButton.setImage( UIImage(named: data[position]["image"]!), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            detailVC.position = self.position
        }
    }
    
    
    @IBAction func userButtonDidTouch(_ sender: UIButton) {
        self.userOptionView.isHidden = !self.userOptionView.isHidden
        
        let scale = CGAffineTransform(scaleX: 0.3, y: 0.3)
        let translate = CGAffineTransform(translationX: 50, y: -50)
        let transform = scale.concatenating(translate)
        self.userOptionView.transform = transform
        self.userOptionView.alpha = 0
        self.buttonMask.alpha = 0
        self.buttonMask.isHidden = false
        self.userButton.isEnabled = false
        
        SpringAnimation.spring(duration: 0.4, animations: {
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            let transform = scale.concatenating(translate)
            self.userOptionView.transform = transform
            self.userOptionView.alpha = 1
            self.userButton.isEnabled = true

            
            self.buttonMask.alpha = 1
            
        })
    }
    
    @IBAction func likeButtonDidTouch(_ sender: UIButton) {
        print("like button pressed")
    }
    
    @IBAction func shareButtonDidTouch(_ sender: UIButton) {
        print("share button pressed")
        self.shareView.transform = CGAffineTransform(translationX: 0, y: 200)
        self.emailButton.transform = CGAffineTransform(translationX: 0, y: 200)
        self.twitterButton.transform = CGAffineTransform(translationX: 0, y: 200)
        self.facebookButton.transform = CGAffineTransform(translationX: 0, y: 200)
        
        
        SpringAnimation.spring(duration: 0.5) {
            self.shareView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.popoverView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        SpringAnimation.springWithDelay(duration: 0.5, delay: 0.05, animations: {
            self.emailButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
        SpringAnimation.springWithDelay(duration: 0.5, delay: 0.10, animations: {
            self.twitterButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
        SpringAnimation.springWithDelay(duration: 0.5, delay: 0.15, animations: {
            self.facebookButton.transform = CGAffineTransform(translationX: 0, y: 0)
        })
        
        SpringAnimation.spring(duration: 0.5, animations: {
            self.shareView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.shareView.isHidden = false
            self.buttonMask.isHidden = false
        })
    }
    
    @IBAction func imageButtonDidPressed(_ sender: UIButton) {
        
        SpringAnimation.springWithCompletion(duration: 0.7,
           animations: {
            let screenSize = UIScreen.main.bounds
            self.popoverView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            self.popoverView.layer.cornerRadius = 0
            self.imageButton.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 240)
                            
            self.likeButton.alpha = 0
            self.shareButton.alpha = 0
            self.userButton.alpha = 0
            self.headerView.alpha = 0
        }, completion: { finished in
             self.performSegue(withIdentifier: "homeToDetail", sender: self)
        })
    }
    
    
    @IBAction func buttonMaskDidTouched(_ sender: UIButton) {
        SpringAnimation.springWithCompletion(duration: 0.5,
          animations: {
            self.shareView.transform = CGAffineTransform(translationX: 0, y: 200)
            self.popoverView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.buttonMask.isHidden = true
            
            let scale = CGAffineTransform(scaleX: 0.001, y: 0.001)
            let translate = CGAffineTransform(translationX: 50, y: -50)
            let transform = scale.concatenating(translate)
            self.userOptionView.transform = transform

            
        },completion: { finished in
            self.shareView.isHidden = true
            self.userOptionView.isHidden = true
        })
    }
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        print(sender)
        let location = sender.location(in: view)
        let myView = self.popoverView
        let boxLocation = sender.location(in: self.popoverView)
        
        if(sender.state == UIGestureRecognizerState.began) {
            if let _ = snapBehavior {
                animator.removeBehavior(snapBehavior)
            }
            
            let xPosition = boxLocation.x - (myView?.bounds.midX)!
            let yPosition = boxLocation.y - (myView?.bounds.midY)!
            
            let centerOffset = UIOffsetMake(xPosition, yPosition)
            attachmentBehavior = UIAttachmentBehavior(item: myView!, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            
            animator.addBehavior(attachmentBehavior)
            popoverView.center = location
        }
        else if(sender.state == UIGestureRecognizerState.changed) {
            attachmentBehavior.anchorPoint = location
        }
        else if(sender.state == UIGestureRecognizerState.ended) {
            animator.removeBehavior(attachmentBehavior)
            snapBehavior = UISnapBehavior(item: myView!, snapTo: view.center)
            animator.addBehavior(snapBehavior)
            
            let translation = sender.translation(in: view)
            if(translation.y > 100){
                animator.removeAllBehaviors()
                let gravity = UIGravityBehavior(items: [popoverView])
                gravity.gravityDirection = CGVector(dx: 0, dy: 10)
                animator.addBehavior(gravity)
                
                delay(delay: 0.3, closure: refreshView)
            }
        }
        
        
        
        
    }
    
    func refreshView() {
        position += 1
        if position > 3 {
            position = 0
        }
        
        animator.removeAllBehaviors()
        
        snapBehavior = UISnapBehavior(item: popoverView, snapTo: view.center)
        attachmentBehavior.anchorPoint = view.center
        
        popoverView.center = view.center
        viewDidAppear(true)
    }
    
    
    private func backgroundBlur(view: UIView, style:  UIBlurEffectStyle) {
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
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
