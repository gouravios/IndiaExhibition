//
//  EXHForgotPasswordController.swift
//  IndiaExhibition
//
//  Created by Kushank on 3/25/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

class EXHForgotPasswordController: UIViewController {
    
    // IB Outlet for email textfield
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: IB Actions for buttons
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        // web services implementation
    }
    
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
