//
//  EXHSignInController.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/20/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

import GoogleSignIn

class EXHSignInController: UIViewController, Notifiable {
    
    //Mark: Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    let viewModel = EXHLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        self.callLoginService()
        // Do any additional setup after loading the view.
        
    }
    
    //MARK: Login Service Call/Registration Service Call..
    func callLoginService() {
        
        let login = EXHPostServicePath.login(username: "himmit90@gmail.com", password: "welcome123", signType: "E", uniqueId: "")
        viewModel.apiCallWithType(type: login)
    }
    
    func didLoadData(model:Any?, info:Any?, error:Error?) {
        
        // print("service called successfully")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button outlets
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
        
    }
    //MARK: IBAction corresponding to Button
    
   
    
    // Sign in button clicked
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        
        if (txtEmail.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Alert", message: "Please enter vaild Email", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else if !isValidEmail(testStr: txtEmail.text!) {
            
            let alertController = UIAlertController(title: "Alert", message: "Please enter valid email address.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else if (txtPassword.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Alert", message: "Password field should not be empty", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            // web services remaining
            
        }
        
    }
    
    // Facebook ign in button clicked
    @IBAction func facebookSignInButtonClicked(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn(publishPermissions: [.publishActions], viewController: self) { (loginResult) in
            
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in")
               // print(accessToken)
              //facebook current logged in user ID
                //  print(FBSDKAccessToken.current().userID)
                //call web services
            }
        }
    }

    //Google sign in button clicked
    
    
    @IBAction func googleSignInButtonClicked(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().signIn()
        //google currently logged in user ID
        //print(GIDSignIn.sharedInstance().currentUser)
        
        
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

//Mark: Text field delegate methods
extension EXHSignInController : UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }
        
        if (textField.returnKeyType == UIReturnKeyType.done) {
            textField.resignFirstResponder()
        }
        
        print("textFieldShouldReturn")
        return true
    }
    
    
}

//MARK: Google Sign in

extension EXHSignInController : GIDSignInUIDelegate {
    
//    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
//        myActivityIndicator.stopAnimating()
//    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

