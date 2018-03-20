//
//  EXHSignInController.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 3/20/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

class EXHSignInController: UIViewController, Notifiable {
    
    let viewModel = EXHLoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
