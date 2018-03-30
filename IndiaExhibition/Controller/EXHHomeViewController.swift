//
//  EXHHomeViewController.swift
//  IndiaExhibition
//
//  Created by Kushank on 3/25/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

class EXHHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var exhibitionTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    exhibitionTableView.rowHeight = 350

        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exhibitionCell") as! ExhibitionCell
        
        return cell
    }
    
    
    
    

}
