//
//  ViewController.swift
//  LocalUserNotificationExample
//
//  Created by Türker Alan on 26.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func didTapNotif(_ sender: UIButton) {
        LocalNotification.shared.checkForAuthorization()
    }
    
    
    
}

