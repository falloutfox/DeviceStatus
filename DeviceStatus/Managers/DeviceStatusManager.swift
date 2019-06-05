//
//  DeviceStatusManager.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 04/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit

class DeviceStatusManager: NSObject {
	private var checkStatusTimer : Timer?
	@objc dynamic var cellularSignalStrength : Int = -1
	@objc dynamic var wifiSignalStrength : Double = 0.0
	@objc dynamic var batteryLevel : Float = 0.0
	@objc dynamic var batteryState : UIDevice.BatteryState = .unknown
	
	override init() {
		super.init()
		UIDevice.current.isBatteryMonitoringEnabled = true
		startCheckingValues()
	}
	
	private func startCheckingValues() {
		checkStatusTimer = Timer.scheduledTimer(withTimeInterval: 2.0,
												repeats: true,
												block: { [unowned self] (_) in
													if UIDevice.current.hasNotch,
														let wifiBars = self.getWiFiNumberOfActiveBars() {
														self.wifiSignalStrength = Double(wifiBars)
													} else {
														let wifiBars = self.wifiStrength() ?? -1
														self.wifiSignalStrength = Double(wifiBars)
														
														self.cellularSignalStrength = self.getSignalStrength()
													}
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
	
	private func wifiStrength() -> Int? {
		let app = UIApplication.shared
		var rssi: Int?
		guard let statusBar = app.value(forKey: "statusBar") as? UIView, let foregroundView = statusBar.value(forKey: "foregroundView") as? UIView else {
			return rssi
		}
		for view in foregroundView.subviews {
			if let statusBarDataNetworkItemView = NSClassFromString("UIStatusBarDataNetworkItemView"),
				view.isKind(of: statusBarDataNetworkItemView) {
				if let val = view.value(forKey: "wifiStrengthRaw") as? Int {
					rssi = val
					break
				}
			}
		}
		return rssi
	}
	
	private func getWiFiNumberOfActiveBars() -> Int? {
		let app = UIApplication.shared
		var numberOfActiveBars: Int?
//		let exception = tryBlock {
			guard let containerBar = app.value(forKey: "statusBar") as? UIView else { return nil}
			guard let statusBarMorden = NSClassFromString("UIStatusBar_Modern"), containerBar .isKind(of: statusBarMorden), let statusBar = containerBar.value(forKey: "statusBar") as? UIView else { return nil}
			
			guard let foregroundView = statusBar.value(forKey: "foregroundView") as? UIView else { return nil}
			
			for view in foregroundView.subviews {
				for v in view.subviews {
					if let statusBarWifiSignalView = NSClassFromString("_UIStatusBarWifiSignalView"),
						v.isKind(of: statusBarWifiSignalView) {
						if let val = v.value(forKey: "numberOfActiveBars") as? Int {
							numberOfActiveBars = val
							break
						}
					}
				}
				if let _ = numberOfActiveBars {
					break
				}
			}
//		}
//		if let exception = exception {
//			print("getWiFiNumberOfActiveBars exception: \(exception)")
//		}
		
		return numberOfActiveBars
	}
	
	private func getSignalStrength() -> Int {
		
		let application = UIApplication.shared
		let statusBarView = application.value(forKey: "statusBar") as! UIView
		let foregroundView = statusBarView.value(forKey: "foregroundView") as! UIView
		let foregroundViewSubviews = foregroundView.subviews
		
		var dataNetworkItemView:UIView!
		
		for subview in foregroundViewSubviews {
			if subview.isKind(of: NSClassFromString("UIStatusBarSignalStrengthItemView")!) {
				dataNetworkItemView = subview
				break
			} else {
				return 0 //NO SERVICE
			}
		}
		
		return dataNetworkItemView.value(forKey: "signalStrengthBars") as! Int
		
	}
	
	
	public func getStartValues() {
		if UIDevice.current.hasNotch,
			let bars = getWiFiNumberOfActiveBars() {
			wifiSignalStrength = Double(bars)
		} else {
			let wifiBars = self.wifiStrength() ?? -1
			self.wifiSignalStrength = Double(wifiBars)
			
			self.cellularSignalStrength = self.getSignalStrength()
		}
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
