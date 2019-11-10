//
//  GameViewController.swift
//  Free Fall
//
//  Created by Jason Cardinale on 11/4/18.
//  Copyright © 2018 Jason Cardinale. All rights reserved.
//
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import GoogleMobileAds

var gameView = GameViewController()
var rewardLoaded = true

class GameViewController: UIViewController, GADInterstitialDelegate, GADRewardBasedVideoAdDelegate {
    
    
    fileprivate var interstitial: GADInterstitial!
    fileprivate var rewardBasedVideo: GADRewardBasedVideoAd?
    var rewardBasedVideoAdRequestInProgress = false
    
    func presentInterstitialAd() {
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Interstitial ad wasn't ready")
        }
        createAndLoadInterstitial()
        
    }
    
    func presentRewardBasedAd() {
        
        if rewardBasedVideo?.isReady == true {
            rewardBasedVideo?.present(fromRootViewController: self)
        } else {
            print("Reward Based Video Ad wasn't ready")
        }
        createAndLoadRewardBasedVideo()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView = self
        
        createAndLoadInterstitial()
        createAndLoadRewardBasedVideo()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene = MainMenuScene(size: CGSize(width: 1536, height: 2048))
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            /*
            view.showsFPS = true
            view.showsNodeCount = false*/
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func createAndLoadInterstitial() {
        
        interstitial = GADInterstitial(adUnitID: adMobInterstitialAdUnitId)
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        request.testDevices = [ kGADSimulatorID, adMobMyDeviceUUID ]
        interstitial.load(request)
        
    }
    
    func createAndLoadRewardBasedVideo() {
        
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()
        rewardBasedVideo?.delegate = self
        if !rewardBasedVideoAdRequestInProgress && rewardBasedVideo?.isReady == false {
            rewardBasedVideo?.load(GADRequest(),
                                   withAdUnitID: adMobRewardBasedVideoAdUnitId)
            rewardBasedVideoAdRequestInProgress = true
        }
        
    }
        
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        rewardBasedVideoAdRequestInProgress = false
        rewardLoaded = false
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        rewardBasedVideoAdRequestInProgress = false
        rewardLoaded = true
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        //createAndLoadRewardBasedVideo()
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        coinNumber += 5
        defaults.set(coinNumber, forKey: "coinNumberSaved")
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
}
