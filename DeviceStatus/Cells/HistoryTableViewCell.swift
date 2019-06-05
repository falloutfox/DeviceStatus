//
//  HistoryTableViewCell.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 05/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
	@IBOutlet var dateLabel : UILabel!
	@IBOutlet var batteryLevel : UILabel!
	@IBOutlet var batteryState : UILabel!
	@IBOutlet var wifiStrength : UILabel!
	@IBOutlet var cellularSignal : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
