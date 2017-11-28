//
//  DetailViewController.swift
//  Shots-Implementing
//
//  Created by Jorge Luiz on 23/11/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var artImageView: UIImageView!
    
    var position:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let data = getData()
        
        self.authorLabel.text = data[position]["author"]
        self.descTextView.text = data[position]["desc"]
        self.avatarImageView.image = UIImage(named: data[position]["avatar"]!)
        self.artImageView.image = UIImage(named: data[position]["image"]!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonDidPressed(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeVC = segue.destination as? HomeViewController {
            homeVC.position = self.position
        }
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
