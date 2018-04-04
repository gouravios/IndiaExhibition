//
//  EXHRegistrationController.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/20/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

class EXHRegistrationController: UIViewController, Notifiable {

    @IBOutlet weak var txtField_RetypePassword: UITextField!
    @IBOutlet weak var txtField_Password: UITextField!
    @IBOutlet weak var txtField_UserName: UITextField!
    @IBOutlet weak var txtField_Email: UITextField!
    
    var activeTextField : UITextField?
    
    @IBOutlet weak var scrollView: UIScrollView!
    let viewModel = EXHRegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startObservingKeyboardEvents()
        viewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        self.stopObservingKeyboardEvents()
    }
    
    private func startObservingKeyboardEvents() {
        
          NotificationCenter.default.addObserver(self, selector: #selector(EXHRegistrationController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(EXHRegistrationController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func stopObservingKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
      //  keyboardSizeValue = keyboardSize!
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeTextField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLoadData(model:Any?, info:Any?, error:Error?) {
        
        print("service called successfully")
    }
    
    @IBAction func registrationButtonClicked(_ sender: UIButton) {
        
        if (txtField_Email.text?.isEmpty)! {
            
            self.popupAlert(title: "Exhibition", message: "Please enter email address.", actionTitles: ["Ok"], actions:[{action1 in
                }, nil])
            
        }else if (txtField_UserName.text?.isEmpty)! {
            
            self.popupAlert(title: "Exhibition", message: "Please enter user name.", actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
        } else if (txtField_Password.text?.isEmpty)! {
            
            self.popupAlert(title: "Exhibition", message: "Please enter password.", actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
        }
        else if (txtField_Email.text?.isEmpty)! && (txtField_Password.text?.isEmpty)!{
            
            self.popupAlert(title: "Exhibition", message: "Please enter valid email address and password.", actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
        }
        else if txtField_Password.text != txtField_RetypePassword.text {
            
            self.popupAlert(title: "Exhibition", message: "Retype password should match.", actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
        }
        else {
            
//            let registrationServicePath = EXHPostServicePath.registration(first_name: tx, last_name: <#T##String#>, email: <#T##String#>, pass: <#T##String#>, deviceid: <#T##String#>, phone: <#T##String#>)
//            viewModel.apiCallWithType(type: <#T##EXHPostServicePath#>)
        }

    }
    
    @IBAction func existingUserButtonClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func selectYourRoleButtonClicked(_ sender: UIButton) {
        
        
    }

}

extension EXHRegistrationController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField.returnKeyType == UIReturnKeyType.done)
        {
            textField .resignFirstResponder()
            
        } else {
            let txtFld : UITextField? = self.view.viewWithTag(textField.tag + 1) as? UITextField;
            txtFld?.becomeFirstResponder()
        }
        return true
    }
}
