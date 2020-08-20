//
//  CellTableViewCell.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/1/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
