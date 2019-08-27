//
//  ExerciseViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 17/05/19.
//  Copyright © 2019 Deakin. All rights reserved.
//
/* This class loads in the exercises of differnt bidy parts embedded in buttons
 variables used: pdfTitle till pdfTitle5 for storing the pdf name to be loaded. */
import UIKit
import WebKit

class ExerciseViewController: UIViewController {
    //variables storing the pdf names
    let pdfTitle = "Finalbiceps"
    let pdfTitle1 = "Finalchest"
    let pdfTitle2 = "FinalLegs"
    let pdfTitle3 = "finalback"
    let pdfTitle4 = "FinalShoulder"
    let pdfTitle5 = "abs final"
    
    //variable of the type UIBarbutton(navigation item)
    var homeBarButton = UIBarButtonItem()
    
    let pdfVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on tab of the bisceps button*/
    @IBAction func bicepsbutton(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Biscep WorkOut"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on tab of chest workout button*/
    @IBAction func chestButton(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle1, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Chest WorkOut"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on tab of leg workout button*/
    @IBAction func legButton(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle2, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Leg WorkOut"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on tab of Back Workout button*/
    @IBAction func backButton(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle3, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Back WorkOut"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on tab of shoulder workout button*/
    @IBAction func shoulderButton(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle4, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Shoulder WorkOut"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on tab of abss workout button*/
    @IBAction func absButton(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle5, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Abs WorkOut"
            self.navigationController?.pushViewController(pdfVC, animated: true)
            
        }
    }
    //function to set the navigation item on click of the button home
    override func viewWillAppear(_ animated: Bool) {
        
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
            self.pdfVC.view.removeFromSuperview()
        })
    }
    
    
}
