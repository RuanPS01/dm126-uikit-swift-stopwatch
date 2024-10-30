//
//  ViewController.swift
//  DM126_Class
//
//  Created by user270231 on 10/26/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startTestButton: UIButton!
    @IBAction func onClickStart(_ sender: Any) {
        print("Button pressed!")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutConfigure()
        // Do any additional setup after loading the view.
    }
    
    func layoutConfigure() {
        startTestButton.layer.cornerRadius = 100.0
        print("Corner changed.")
    }
}
