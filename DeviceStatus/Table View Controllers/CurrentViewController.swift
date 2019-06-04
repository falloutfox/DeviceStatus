//
//  CurrentTableViewController.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 04/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {
	@IBOutlet var batteryLevelLabel : UILabel!
	@IBOutlet var batteryStateLabel : UILabel!
	
	
	
	@objc var deviceStatusManager = DeviceStatusManager()
	private var wifiObservation: NSKeyValueObservation?
	private var batteryLevelObservation: NSKeyValueObservation?
	private var batteryStateObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		wifiObservation = observe(\.deviceStatusManager.wifiSignalStrength, changeHandler: { [weak self] (_, _) in
			if let weakSelf = self {
				print(weakSelf.deviceStatusManager.wifiSignalStrength)
			}
		})
		batteryLevelObservation = observe(\.deviceStatusManager.batteryLevel, changeHandler: { [weak self] (_, _) in
			if let weakSelf = self {
				print(weakSelf.deviceStatusManager.batteryLevel)
				let level = weakSelf.deviceStatusManager.batteryLevel * 100
				print("level: \(level)")
				DispatchQueue.main.async {
					weakSelf.batteryLevelLabel.text = "\(level)%"
				}
			}
		})
		batteryLevelObservation = observe(\.deviceStatusManager.batteryState, changeHandler: { [weak self] (_, _) in
			if let weakSelf = self {
				print(weakSelf.deviceStatusManager.batteryLevel)
				var state : String
				switch(weakSelf.deviceStatusManager.batteryState) {
				case .charging:
					state = "charging"
				case .full:
					state = "full"
				case .unplugged:
					state = "unplugged"
				default:
					state = "unknown"
				}
				
				DispatchQueue.main.async {
					weakSelf.batteryStateLabel.text = state
				}
			}
		})

		deviceStatusManager.getStartValues()
    }
	
}
