//
//  ViewController.swift
//  Cardgames
//
//  Created by Bhavika Patel on 1/7/18.
//  Copyright © 2018 Bhavika Patel. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
//    var passInValue: String?
    
    @IBOutlet weak var abc: UILabel!
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var submit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        run(input: nil)
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        run(input: input.text)
//        print(passInValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
