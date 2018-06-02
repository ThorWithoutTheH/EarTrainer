//
//  Store.swift
//  EarTrainer
//
//  Created by Vittorio Rosa on 2018-04-08.
//  Copyright © 2018 vr. All rights reserved.
//

import UIKit

class Store: UIViewController {
    
    @IBOutlet var topStoreLabel: UILabel!
    
    @IBOutlet var titleText: UITextField!
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var purchaseButton: UIButton!
    @IBOutlet var returnButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignbackground()

        // Do any additional setup after loading the view.
    }
    
    func assignbackground(){
        let background = UIImage(named: "EarTrainerBackgroundFinished-2")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        //Round Edges
        titleText.layer.cornerRadius = 5.0
        purchaseButton.layer.cornerRadius = 5.0
        returnButton.layer.cornerRadius = 5.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func purchaseAction(_ sender: Any) {
        
    }
    
    @IBAction func returnHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
