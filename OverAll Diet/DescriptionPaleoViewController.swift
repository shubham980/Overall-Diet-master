//
//  DescriptionPaleoViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 07/04/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

/*This Class contains the information for the detail of the Paleo diet by using label and the text field.
 The data is stored in strings.
 varibles used : homeBarButton(UIBarButtonItem), paleloDescriptionView(UIwebView)*/

import UIKit


class DescriptionPaleoViewController: UIViewController {
    
    //variable of the type UIBarbutton(navigation item)
    var homeBarButton = UIBarButtonItem()
    
    @IBOutlet weak var paleloDescriptionView: UIWebView!
    //function to set the navigation item on click of the button home
    override func viewWillAppear(_ animated: Bool) {
        // Defining the left navigation bar item
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    //loads the current view and returns the screen with the loaded items in the text field.
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPaleloFile()
    }
    
    //function to load the html in the webview descriptionWebView
    func loadPaleloFile(){
        let url = Bundle.main.url(forResource: "PaleloDiet",withExtension:"html")
        let request = NSURLRequest(url: url!)
        paleloDescriptionView.loadRequest(request as URLRequest)
    }
    
    //function to dissmiss the current view to the home view on click of home button
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
    
}
