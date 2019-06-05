//
//  SnapshotData.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 05/06/2019.
//Copyright © 2019 Oliver Stowell. All rights reserved.
//

import Foundation
import RealmSwift

class SnapshotData: Object {
	@objc dynamic var id = UUID.init().uuidString
	@objc dynamic var battery: BatteryData!
	@objc dynamic var wifi: WiFiData!
	@objc dynamic var cellular: CellularData!
	@objc dynamic var date: Date = Date()
	
	override static func primaryKey() -> String? {
		return "id"
	}
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
