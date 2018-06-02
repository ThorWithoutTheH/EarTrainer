//
//  GameController.swift
//  EarTrainer
//
//  Created by Vittorio Rosa on 2018-03-08.
//  Copyright © 2018 vr. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class GameController: UIViewController, GADBannerViewDelegate {
    
 
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rightOrWrong: UILabel!
    
    @IBOutlet weak var note1: UIButton!
    @IBOutlet weak var note2: UIButton!
    @IBOutlet weak var note3: UIButton!
    @IBOutlet weak var adBanner: GADBannerView!
    
    var seconds = 30
    
    var secondsToStart = 5
    
    var timer =  Timer ()
    
    var timerToStart = Timer ()
    
    var audioPlayer = AVAudioPlayer()
    
    var points = 0
    
    var comparIntervals = ""
    
    var currentIntervalString: String!
    
    var sound1 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "unision_mid_c_0", ofType: "mp3")!)
    var sound2 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "minor_second_c_1", ofType: "mp3")!)
    var sound3 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "major_second_c_2", ofType: "mp3")!)
    var sound4 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "minor_third_c_3", ofType: "mp3")!)
    var sound5 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "major_third_c_4", ofType: "mp3")!)
    var sound6 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "perfect_fourth_c_5", ofType: "mp3")!)
    var sound7 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "perfect_fifth_c_6", ofType: "mp3")!)
    var sound8 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "tritone_c_dimished_fifth_6", ofType: "mp3")!)
    var sound9 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "minor_sixth_c_7", ofType: "mp3")!)
    var sound10 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "major_sixth_c_8", ofType: "mp3")!)
    var sound11 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "minor_seventh_c_9", ofType: "mp3")!)
    var sound12 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "major_seventh_c", ofType: "mp3")!)
    var sound13 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "perfect_octave_11", ofType: "mp3")!)

    
    lazy var intervalsInKeyOfC : [NSURL] = [sound1,
                                       sound2,
                                       sound3,
                                       sound4,
                                       sound5,
                                       sound6,
                                       sound7,
                                       sound8,
                                       sound9,
                                       sound10,
                                       sound11,
                                       sound12,
                                       sound13]
    
    var question = ["What Is The Interval?"]
    
    let answers = [["Unison Mid","Minor Second","Major Seventh"],
                   ["Minor Second","Dimished Fifth Tritone","Minor Sixth"],
                   ["Major Second","Perfect Fourth","Major Seventh"],
                   ["Minor Third","Perfect Fifth","Major Seventh"],
                   ["Major Third","Perfect Fourth","Perfect Fifth"],
                   ["Perfect Fourth","Perfect Fifth","Perfect Octave"],
                   ["Perfect Fifth","Major Sixth","Minor Sixth"],
                   ["Diminished Fifth Tritone","Major Seventh","Perfect Octave"],
                   ["Minor Sixth","Major Sixth","Unison Mid"],
                   ["Major Sixth","Minor Seventh","Major Second"],
                   ["Minor Seventh","Perfect Fourth","Perfect Fifth"],
                   ["Major Seventh","Perfect Octave","Minor Second"],
                   ["Perfect Octave","Major Second","Minor Second"]]
    
    var intervalsPerfect = ""
    
    var intervalsMajorAndMinor = ""
    
    var intervalsAugmentedAndDiminished = ""
    
    var randomIndex = 0
    
    var currentInterval = ""
    
    var currentQuestion = 0
    
    var rightAnswerPlacement:UInt32 = 0
    
    var attempts = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // View loaded
       
        //Content
        rightOrWrong.text = ""
        countDownLabel.text = "" // update label
        
        adBanner.isHidden = true
        
        adBanner.delegate = self
        
        // test banner
        adBanner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adBanner.adSize = kGADAdSizeSmartBannerPortrait
        adBanner.rootViewController = self
        let request: GADRequest = GADRequest()
        request.testDevices = [kGADSimulatorID]
        adBanner.load(request)
        assignbackground()
        
    }
    
    func assignbackground(){
        let background = UIImage(named: "GameImage-4")
        //Background Image
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        //Make Labels Pretty
        questionLabel.layer.cornerRadius = 5.0
        countDownLabel.layer.cornerRadius = 5.0
        scoreLabel.layer.cornerRadius = 5.0
        rightOrWrong.layer.cornerRadius = 5.0
        // Make Buttons pretty
        note1.layer.cornerRadius = 5.0
        note2.layer.cornerRadius = 5.0
        note3.layer.cornerRadius = 5.0
        
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        adBanner.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        adBanner.isHidden = true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func playRandomSound() { // play random sound
        
        attempts = 4
        
        let randNo = Int(arc4random_uniform(UInt32(intervalsInKeyOfC.count)))
        
        print(intervalsInKeyOfC[randNo])
        
        currentQuestion = randNo
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: intervalsInKeyOfC[randNo] as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
        } catch {
            print(error)
        }
        
        // generate button and answer key
        rightAnswerPlacement = arc4random_uniform(3) + 1
        var button:UIButton = UIButton()

        var x = 1
        
        for i in 1...3
        {
            button = view.viewWithTag(i) as! UIButton
            
            if(i == Int(rightAnswerPlacement))
            {
                button.setTitle(answers[currentQuestion][0], for: .normal)
                scoreLabel.text =  String(points) + " points"
                currentIntervalString = answers[currentQuestion][0]
            }
            else
            {
                button.setTitle(answers[currentQuestion][x], for: .normal)
                x = 2
            }
        }
        

    }
    
    // Animate Text for Right or Wrong answers
    func animateText() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.rightOrWrong.alpha = 1.0
        }, completion: {
            (Completed : Bool) -> Void in
            UIView.animate(withDuration: 0.5, delay: 1.0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.rightOrWrong.alpha = 0
            }, completion: {
                (Completed : Bool) -> Void in
                
                self.animateText()
            })
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        startGame()
        countDownToStart()
        animateText()
    }
    
    func startCountDownTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameController.countDownTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func countDownTimer () {
        
        seconds -= 1
        countDownLabel.text = String(seconds) + " seconds"
        
        if(seconds == 29)
        {
            playRandomSound()
        }
        
        if(seconds == 0)
        {
            timer.invalidate()
            endGame()
        }

    }
    
    // This is called when user taps to begin from previous screen, first thing called after onload
    func startGame() {
        
        timerToStart = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameController.countDownToStart), userInfo: nil, repeats: true)

    }
    
    @objc func countDownToStart () {
        
        secondsToStart -= 1
        countDownLabel.text = String(secondsToStart) + " seconds to begin"
        
        if(secondsToStart == 1)
        {
           
            timerToStart.invalidate()
            
            startCountDownTimer()
        }
    }
    
    func endGame() {
        
        audioPlayer.stop()
        prepareNextScene()
        //  editButtonItem.isEnabled = false
    }
    
    
    func prepareNextScene() {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "endGame") as! ViewController
        vc.scoreData = points
        self.present(vc, animated: false, completion: nil)
        
    }
    
    // Button
    @IBAction func actionQ(_ sender: AnyObject) {
        
        if(sender.tag == Int(rightAnswerPlacement))
        {
            rightOrWrong.text = "Correct!" + " " + currentIntervalString
            points += attempts
            // Create delay
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.playRandomSound()
            })
        }
        else
        {
            attempts -= 1
            rightOrWrong.text = "Incorrect!"
        }
        
        if(attempts == 0)
        {
            playRandomSound()
        }
        
    }
}
