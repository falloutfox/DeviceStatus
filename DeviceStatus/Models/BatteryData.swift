//
//  BatteryData.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 05/06/2019.
//Copyright © 2019 Oliver Stowell. All rights reserved.
//

import Foundation
import RealmSwift

class BatteryData: Object {
	@objc dynamic var level : Float = 0.0
	@objc dynamic var state : UIDevice.BatteryState = .unknown
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
