//
//  CurrentTableViewController.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 04/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit

class CurrentViewController: UIViewController {
	@IBOutlet var batteryContainerView : UIView!
	@IBOutlet var batteryTitle : UILabel!
	@IBOutlet var batteryLevelLabel : UILabel!
	@IBOutlet var batteryStateLabel : UILabel!
	
	@IBOutlet var wifiContainerView : UIView!
	@IBOutlet var wifiTitle : UILabel!
	@IBOutlet var wifiLevelLabel : UILabel!
	@IBOutlet var wifiSignalStrengthLabel : UILabel!
	
	@IBOutlet var signalContainerView : UIView!
	@IBOutlet var signalTitle : UILabel!
	@IBOutlet var signalLevelLabel : UILabel!
	
	@IBOutlet var snapshotButton : UIButton!
	
	@objc var deviceStatusManager = DeviceStatusManager()
	private var signalObservation: NSKeyValueObservation?
	private var wifiObservation: NSKeyValueObservation?
	private var batteryLevelObservation: NSKeyValueObservation?
	private var batteryStateObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
		updateUI()
		
		signalObservation = observe(\.deviceStatusManager.cellularSignalStrength, changeHandler: { [weak self] (_, _) in
			if let weakSelf = self {
				DispatchQueue.main.async {
					weakSelf.signalLevelLabel.text = "\(weakSelf.deviceStatusManager.cellularSignalStrength)"
				}
			}
		})
		wifiObservation = observe(\.deviceStatusManager.wifiSignalStrength, changeHandler: { [weak self] (_, _) in
			if let weakSelf = self {
				if UIDevice.current.hasNotch {
					weakSelf.wifiLevelLabel.text = "\(weakSelf.deviceStatusManager.wifiSignalStrength)"
					weakSelf.wifiSignalStrengthLabel.isHidden = true
				} else {
					weakSelf.wifiLevelLabel.isHidden = true
					weakSelf.wifiSignalStrengthLabel.text = "\(weakSelf.deviceStatusManager.wifiSignalStrength)dB"
				}
			}
		})
		batteryLevelObservation = observe(\.deviceStatusManager.batteryLevel, changeHandler: { [weak self] (_, _) in
			if let weakSelf = self {
				print(weakSelf.deviceStatusManager.batteryLevel)
				let level = weakSelf.deviceStatusManager.batteryLevel * 100
				DispatchQueue.main.async {
					weakSelf.batteryLevelLabel.text = "\(Int(level))%"
				}
			}
		})
		batteryStateObservation = observe(\.deviceStatusManager.batteryState, changeHandler: { [weak self] (_, _) in
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
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		deviceStatusManager.getStartValues()
	}
	
	private func updateUI() {
		let cornerRadius : CGFloat = 5.0
		let borderWidth : CGFloat = 1.0
		let borderColor : CGColor = UIColor.darkGray.cgColor
		
		batteryContainerView.layer.cornerRadius = cornerRadius
		batteryContainerView.layer.borderColor = borderColor
		batteryContainerView.layer.borderWidth = borderWidth
		batteryContainerView.layer.masksToBounds = true
		batteryTitle.layer.borderColor = borderColor
		batteryTitle.layer.borderWidth = borderWidth
		
		wifiContainerView.layer.cornerRadius = cornerRadius
		wifiContainerView.layer.borderColor = borderColor
		wifiContainerView.layer.borderWidth = borderWidth
		wifiContainerView.layer.masksToBounds = true
		wifiTitle.layer.borderColor = borderColor
		wifiTitle.layer.borderWidth = borderWidth
		
		signalContainerView.layer.cornerRadius = cornerRadius
		signalContainerView.layer.borderColor = borderColor
		signalContainerView.layer.borderWidth = borderWidth
		signalContainerView.layer.masksToBounds = true
		signalTitle.layer.borderColor = borderColor
		signalTitle.layer.borderWidth = borderWidth
		
		snapshotButton.layer.cornerRadius = cornerRadius
		snapshotButton.layer.borderColor = borderColor
		snapshotButton.layer.borderWidth = borderWidth
	}
	
	@IBAction func tapSnapshot() {
		
	}
}
