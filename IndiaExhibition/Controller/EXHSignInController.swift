//
//  EXHSignInController.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/20/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

import FacebookLogin
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class EXHSignInController: UIViewController {
    
    //Mark: Outlets
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    let viewModel = EXHLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    //MARK: Login Service Call/Registration Service Call..
    func callLoginService(emailAddress : String, password : String, signType : String = Constants.LoginTypes.Custom, uniqueId: String = "") {
        
        let loginServicePath = EXHPostServicePath.login(username: emailAddress, password: password, signType: signType, uniqueId: uniqueId)
        viewModel.apiCallWithType(type: loginServicePath) { (result, error) in
            
            if result {
         
                //call segue
                
            } else {
                
                DispatchQueue.main.async { () -> Void in
                    self.dismissKeyboard()
                    self.popupAlert(title:Bundle.main.displayName, message: error.localizedDescription, actionTitles: ["Ok"], actions:[{action1 in
                        }, nil])
                }
            }
        }
    }
    
    //MARK: IBAction corresponding to Button
    // Sign in button clicked
    @IBAction func signInButtonClicked(_ sender: UIButton) {

        do {
            try viewModel.login()
            //call web services
            self.callLoginService(emailAddress: txtEmail.text!, password: txtPassword.text!)
            
        } catch LoginError.inCompleteForm  {
            
            self.popupAlert(title: Bundle.main.displayName, message:Constants.ConditionAlerts.InCompleteForm, actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
    
        } catch LoginError.invalidEmail  {
            
            self.popupAlert(title: Bundle.main.displayName, message: Constants.ConditionAlerts.InvalidEmail, actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
        } catch {
            
            print("some error")
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
                print("\(grantedPermissions)\(declinedPermissions)\(accessToken)")
                self.callLoginService(emailAddress: "", password: "", signType: Constants.LoginTypes.Facebook, uniqueId: FBSDKAccessToken.current().userID)
            }
        }
    }

    //Google sign in button clicked
    @IBAction func googleSignInButtonClicked(_ sender: UIButton) {
        //perform sign in
        GIDSignIn.sharedInstance().signIn()
    }
}

//Mark: Text field delegate methods
extension EXHSignInController : UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtEmail{
            txtPassword.becomeFirstResponder()
        }
        
        if (textField.returnKeyType == UIReturnKeyType.done) {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == txtEmail {
            viewModel.updateUsername(username: newString)
        } else if textField == txtPassword {
            viewModel.updatePassword(password: newString)
        }
        return true
    }
}

//MARK: Google Sign in

extension EXHSignInController : GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
    withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            
            self.callLoginService(emailAddress: user.profile.email, password: "", signType: Constants.LoginTypes.Google, uniqueId: user.userID)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        self.dismiss(animated: true, completion: nil)
    }
}



