//
//  ExhibitionCell.swift
//  IndiaExhibition
//
//  Created by Kushank on 3/29/18.
//  Copyright © 2018 mobileprogramming. All rights reserved.
//

import UIKit

class ExhibitionCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet weak var lblExhibitionName: UILabel!
    
    @IBOutlet weak var lblExhibitionPlace: UILabel!
    
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    
    @IBOutlet weak var lblStartTime: UILabel!
    
    @IBOutlet weak var lblEndTime: UILabel!
    
    @IBOutlet weak var imgEvent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
