//
//  ZoneViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 23/05/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import WebKit

class ZoneViewController: UIViewController {
    
    var homeBarButton = UIBarButtonItem()
    let pdfTitle = "Zone Diet"
    let pdfVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on diet recepie button*/
    @IBAction func zoneDietRecepies(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            self.pdfVC.view.addSubview(webView)
            self.pdfVC.title = "Recipes"
            self.navigationController?.pushViewController(self.pdfVC, animated: true)
        }
    }
    
    //function to return to the home page when tapped on the home button
    override func viewWillAppear(_ animated: Bool) {
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    //if clicked on the back button the current view gets dismissed to the superview i.e. the home page.
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.pdfVC.view.removeFromSuperview()
            self.view.removeFromSuperview()
        })
    }
    
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

