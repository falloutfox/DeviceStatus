//
//  WiFiData.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 05/06/2019.
//Copyright © 2019 Oliver Stowell. All rights reserved.
//

import Foundation
import RealmSwift

class WiFiData: Object {
	@objc dynamic var signalStrength : Double = 0.0
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
