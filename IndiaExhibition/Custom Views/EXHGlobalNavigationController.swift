//
//  DJOGlobalNavigationController.swift
//  DJOGlobal
//
//  Created by Gourav Sharma on 5/12/16.
//  Copyright © 2016 Mobileprogrammingllc. All rights reserved.
//

import UIKit

class EXHGlobalNavigationController: UINavigationController  {

    var backgroundView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
     
    }
    
    func hideNavigationBackgroundView(_ hidden: Bool) {
        self.backgroundView.isHidden = hidden
    }
    
    func checkHideNavigationBar() {
       
    }
    
    func setNavigationTitle(_ title : String) {
        
       
        
    }

}
