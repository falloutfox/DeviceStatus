//
//  DeviceStatusManager.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 04/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit
import NetworkExtension

class DeviceStatusManager: NSObject {
	private var checkStatusTimer : Timer?
	@objc dynamic var wifiSignalStrength : Double = 0.0
	@objc dynamic var batteryLevel : Float = 0.0
	@objc dynamic var batteryState : UIDevice.BatteryState = .unknown
	
	override init() {
		super.init()
		UIDevice.current.isBatteryMonitoringEnabled = true
		
		startCheckingValues()
	}
	
	private func startCheckingValues() {
		checkStatusTimer = Timer.scheduledTimer(withTimeInterval: 1.0,
												repeats: true,
												block: { [unowned self] (_) in
//													print("updating")
//													self?.wifiSignalStrength = NEHotspotNetwork().signalStrength
		})
		NotificationCenter.default.addObserver(self,
											   selector: #selector(batteryLevelDidChange(_:)),
											   name: UIDevice.batteryLevelDidChangeNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(batteryStateDidChange(_:)),
											   name: UIDevice.batteryLevelDidChangeNotification,
											   object: nil)
	}
	
	@objc private func batteryLevelDidChange(_ notification: Notification) {
		batteryLevel = UIDevice.current.batteryLevel
	}
	
	@objc private func batteryStateDidChange(_ notification: Notification) {
		batteryState = UIDevice.current.batteryState
	}
	
	public func getStartValues() {
		
		
		batteryLevel = UIDevice.current.batteryLevel
		batteryState = UIDevice.current.batteryState
	}
	
	public func stopCheckingValues() {
		if let timerToInvalidate = checkStatusTimer {
			timerToInvalidate.invalidate()
			checkStatusTimer = nil
		}
		NotificationCenter.default.removeObserver(self,
												  name: UIDevice.batteryLevelDidChangeNotification,
												  object: nil)
		NotificationCenter.default.removeObserver(self,
												  name: UIDevice.batteryStateDidChangeNotification,
												  object: nil)
	}
}
