//
//  StartMenu.swift
//  EarTrainer
//
//  Created by Vittorio Rosa on 2018-03-12.
//  Copyright © 2018 vr. All rights reserved.
//

import UIKit
import GoogleMobileAds

class StartMenu: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var intervalsInC: UIButton!
    
    @IBOutlet var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.isHidden = true
        
        bannerView.delegate = self
        
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.rootViewController = self
        let request: GADRequest = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.load(request)
        assignbackground()
    
        
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
        //Buttons Formatting
        intervalsInC.layer.cornerRadius = 5.0
        bannerView.load(GADRequest())

    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    @IBAction func startGame(_ sender: Any) {
        
        performSegue(withIdentifier: "gameStart", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
