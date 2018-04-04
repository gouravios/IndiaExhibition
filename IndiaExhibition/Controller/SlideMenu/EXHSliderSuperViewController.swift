//
//  DJOSliderSuperViewController.swift
//  DJOGlobal
//
//  Created by Neeraj Mishra on 6/3/16.
//  Copyright © 2016 Mobileprogrammingllc. All rights reserved.
//

import UIKit

@objc
protocol SuperViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}

class EXHSliderSuperViewController: UIViewController {
    var delegate: SuperViewControllerDelegate?
    var bool_UserInteractionCheck: Bool?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bool_UserInteractionCheck = true
        
        let btnName = UIButton()
        btnName.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnName.addTarget(self, action: #selector(EXHSliderSuperViewController.Menutapped), for: .touchUpInside)
        btnName.setImage(UIImage(named:"menu-icon"), for: UIControlState())
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnName
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func Menutapped()
    {
        if (bool_UserInteractionCheck == false) {
            self.view.isUserInteractionEnabled = true
            bool_UserInteractionCheck = true
        }
        else {
            bool_UserInteractionCheck = false
            self.view.isUserInteractionEnabled = false
        }
        delegate?.toggleLeftPanel!()
    }

}
