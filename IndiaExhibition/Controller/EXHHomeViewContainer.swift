//
//  EXHHomeViewContainer.swift
//  IndiaExhibition
//
//  Created by gourav sharma on 4/4/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

class EXHHomeViewContainer: EXHSliderSuperViewController {
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    @IBOutlet weak var mapViewButton : UIButton!
    @IBOutlet weak var detailViewButton : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailView.isHidden = false
        self.mapView.isHidden = true
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.title = "IndiaExhibition"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mapButtonClicked(_ sender: UIButton) {
        
         mapViewButton.backgroundColor = UIColor.init(red: 255/255, green: 127/255, blue: 121/255, alpha: 1.0)
          detailViewButton.backgroundColor = UIColor.red
        mapViewButton.isSelected = true
        detailViewButton.isSelected = false
        self.detailView.isHidden = true
        self.mapView.isHidden = false
        
    }
    
    @IBAction func exhibitionListButtonClicked(_ sender: UIButton) {
        
        mapViewButton.backgroundColor = UIColor.red
        detailViewButton.backgroundColor = UIColor.init(red: 255/255, green: 127/255, blue: 121/255, alpha: 1.0)
        mapViewButton.isSelected = false
        self.detailView.isHidden = false
        self.mapView.isHidden = true
        detailViewButton.isSelected = true
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
