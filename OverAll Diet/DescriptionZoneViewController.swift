//
//  DescriptionZoneViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 23/05/19.
//  Copyright © 2019 Deakin. All rights reserved.
//
/* This Class contains the details of the zone diet and the data is loaded from the HTML self made file using UI webview*/
import UIKit

class DescriptionZoneViewController: UIViewController {
    
    //webview to display the HTMl files
    @IBOutlet weak var descriptionWebView: UIWebView!
    var homeBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadZoneFile()
    }
    
    //function to load the html in the webview descriptionWebView
    func loadZoneFile(){
        let url = Bundle.main.url(forResource: "ZoneDiet",withExtension:"html")
        let request = NSURLRequest(url: url!)
        descriptionWebView.loadRequest(request as URLRequest)
    }
    
    //function to return to the home page when tapped on the home button
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
