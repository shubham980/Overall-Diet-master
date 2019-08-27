//
//  AktinViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 07/04/19.
//  Copyright © 2019 Deakin. All rights reserved.
//
/*The Atkins View Controller would have any actions implemented on the Atkins Diet page that would consist of the detail
 recepie of the diet and the notes page */
import UIKit
import WebKit

class AktinViewController: UIViewController {
    
    var homeBarButton = UIBarButtonItem()
    let pdfTitle = "Atkin Diet"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /*function to load the pdf by pushing it on a new UIViewController embedded in a navigation controller on diet recepie button*/
    @IBAction func atkinDiet(_ sender: Any) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
}
