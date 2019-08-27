
//
//  PaleoViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 24/03/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import WebKit

/*The Paleo View Controller would have any actions implemented on the Paleo Diet page that would consist of the detail
 recepie of the diet and the notes page*/

class PaleoViewController: UIViewController {
    
    let pdfTitle = "Paleo Diet"
    
    var homeBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on diet recepie button*/
    @IBAction func paleoDiet(_ sender: Any) {
        if let url = Bundle.main.url(forResource: pdfTitle, withExtension: "pdf"){
            let webView = WKWebView(frame: self.view.frame)
            let urlRequest =  URLRequest(url: url)
            webView.load(urlRequest as URLRequest)
            //pushing the pdf on a new UI Controller
            let pdfVC = UIViewController()
            pdfVC.view.addSubview(webView)
            pdfVC.title = "Recipes"
            self.navigationController?.pushViewController(pdfVC, animated: true)
        }
    }
    //function to set the navigation item on click of the button home
    override func viewWillAppear(_ animated: Bool) {
        
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    //function to dissmiss the current view to the home view on click of home button
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
}
