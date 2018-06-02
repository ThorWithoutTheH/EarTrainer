//
//  ViewController.swift
//  EarTrainer
//
//  Created by Vittorio Rosa on 2018-03-08.
//  Copyright © 2018 vr. All rights reserved.
//

import UIKit
import MessageUI
import GoogleMobileAds

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate,
    GADBannerViewDelegate{

    var scoreData:Int = 0       // Score Passed from GameController View
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var adBanner: GADBannerView!
    
    var recordData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
        adBanner.isHidden = true
        
        adBanner.delegate = self
        
        
        adBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBanner.adSize = kGADAdSizeSmartBannerPortrait
        adBanner.rootViewController = self
        let request: GADRequest = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBanner.load(request)
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
  
        if (recordData == nil) {
            
            let savedScoreString = scoreData
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(savedScoreString, forKey: "Record")
        }
        else {
            
            let record:Int? = Int(recordData)
            print(scoreData)
            
            print(recordData)
            
            if(scoreData > record!) {
                let savedScoreString = String(scoreData)
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(savedScoreString, forKey: "Record")
            }
        }
    
        // Handle view of score & high score
        if(value == nil)
        {
            highScoreLabel.text = "0"
        }
        else
        {
            highScoreLabel.text = value
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     
    
    }
    
    
    func assignbackground(){
        
        let background = UIImage(named: "endScreen")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        //Labels
        
        scoreLabel.text = String(scoreData)
        
        //Buttons
        
        backToMenuButton.layer.cornerRadius = 5.0
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBanner.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adBanner.isHidden = true
    }
    

    @IBAction func backToMenu(_ sender: Any) {
        
        performSegue(withIdentifier: "backToMenu", sender: self)
    }
    
    @IBAction func shareViaEmail(_ sender: Any) {
        
        // Email Handling
        if (MFMailComposeViewController.canSendMail()) {
            
            let mail:MFMailComposeViewController = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(nil)
            mail.setSubject("Ear Trainer iOS App! - Try and Beat My Score!")
            mail.setMessageBody("My final score was: \(highScoreLabel.text!)", isHTML: false)
            
            self.present(mail, animated:true, completion: nil)
            
            
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please log into your e-mail account, please", preferredStyle:
            UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // Share SMS
    @IBAction func shareSMS(_ sender: Any) {
        
        if(MFMessageComposeViewController.canSendText()) {
            
            let message:MFMessageComposeViewController = MFMessageComposeViewController()
            message.messageComposeDelegate = self
            message.recipients = nil
            message.body = "My final score was: \(highScoreLabel.text!)"
            
            self.present(message, animated: true, completion: nil)

        } else {
            
            let alert = UIAlertController(title: "Warning", message: "This device cannot send SMS messages.", preferredStyle:
                UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

