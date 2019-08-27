//
//  OpenExerciseViewController.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/13/19.
//  Copyright © 2019 Deakin. All rights reserved.
//
/* A main subclass/base class which defines the differnt types of exercises available and are in the
 form of the button that when tapped lead to the demostration page on youtube for a better visual lerning*/
import WebKit

import UIKit

class OpenExerciseViewController: UIViewController{
    
    //declaring the variables for pdf
    let pdfTitle = "Bisceps.pdf"
    
    var homeBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set backgriund color to black
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Defining the left navigation bar item
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    // MARK: - Target Exercises Method
    // Biceps method call
    
    @IBAction func exerciseTricepsTap(){
        
        let youtubeId = "SuajkDYlIRw"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        }
    }
    // Leg method call
    @IBAction func exerciseLegTap(){
        
        let youtubeId = "-AWLDxutS08"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        }
    }
    // Calf method call
    @IBAction func exerciseCalfTap(){
        
        let youtubeId = "KcjAzSf9QEw"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
    }
    // Back method call
    @IBAction func exerciseBackTap(){
        
        let youtubeId = "eE7dzM0iexc"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
    }
    
    // Shoulder method call
    @IBAction func exerciseShoulderTap(){
        
        let youtubeId = "jv31A4Ab4nA"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
        }
    }
    
    // Chest method call
    @IBAction func exerciseChestTap(){
        
        let youtubeId = "89e518dl4I8"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        }
    }
    // Abs method call
    @IBAction func exerciseAbsTap(){
        
        let youtubeId = "DHD1-2P94DI"
        
        var youtubeUrl = NSURL(string:"youtube://\(youtubeId)")!
        
        if UIApplication.shared.canOpenURL(youtubeUrl as URL){
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        } else{
            
            youtubeUrl = NSURL(string:"https://www.youtube.com/watch?v=\(youtubeId)")!
            
            UIApplication.shared.openURL(youtubeUrl as URL)
            
        }
    }
    
    // MARK: - Target Button Tap
    // Tap on home button action
    
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
}

