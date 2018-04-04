//
//  DJOLeftSliderViewController.swift
//  DJOGlobal
//
//  Created by Neeraj Mishra on 6/3/16.
//  Copyright © 2016 Mobileprogrammingllc. All rights reserved.
//

import UIKit

protocol SidePanelViewControllerDelegate {
    func indexSelected(_ index:Int)
}

class EXHLeftSliderViewController: UIViewController {
    @IBOutlet  var tableView_leftSlider: UITableView!
    @IBOutlet weak var imgView_topView: UIImageView!
    
    var delegate: SidePanelViewControllerDelegate?
    var list:Array = ["HOME","FAVOURITES","ADD EXHIBITIONS","LOG OUT"]
    var img_Slider:Array = ["home-icon-selected","fav-icon-selected","add-icon-selected","logout-icon-selected"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView_leftSlider.estimatedRowHeight = 70

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView_leftSlider.reloadData()
        
    }
}

extension EXHLeftSliderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let label = cell?.viewWithTag(100)as! UILabel
        label.text = list[(indexPath as NSIndexPath).row]
        
        
        let imgView_left = cell?.viewWithTag(101)as! UIImageView
        imgView_left.image = UIImage(named: img_Slider[(indexPath as NSIndexPath).row])
        
        return cell!
    }
    
}

extension EXHLeftSliderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index Pressed:\((indexPath as NSIndexPath).row)")
        
        
        delegate?.indexSelected((indexPath as NSIndexPath).row)
    }
}
