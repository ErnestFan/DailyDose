//
//  ViewController.swift
//  daily-dose
//
//  Created by Ernest Fan on 2018-04-11.
//  Copyright © 2018 ERF. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var removeAdsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupAds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupAds() {
        if UserDefaults.standard.bool(forKey: PurchaseManager.instance.IAP_REMOVE_ADS) {
            if removeAdsBtn != nil {
                removeAdsBtn.removeFromSuperview()
            }
            if bannerView != nil {
                bannerView.removeFromSuperview()
            }
        } else {
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
    }
    
    @IBAction func restoreBtnPressed(_ sender: Any) {
        PurchaseManager.instance.restorePurchases { (success) in
            if success {
                self.setupAds()
            }
        }
    }
    
    @IBAction func removeAdsPressed(_ sender: Any) {
        // show activity indicator
        PurchaseManager.instance.purchaseRemoveAds { (success) in
            // dismiss spinner
            if success {
                self.bannerView.removeFromSuperview()
                self.removeAdsBtn.removeFromSuperview()
            } else {
                // show error message to user
            }
            
            
        }
    }
    
}

