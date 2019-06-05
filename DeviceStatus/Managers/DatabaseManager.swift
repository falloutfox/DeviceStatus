//
//  DatabaseManager.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 05/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager: NSObject {
	static let shared = DatabaseManager()
	
	private override init() {
		super.init()
	}
	
	public func takeSnapshot(battery: BatteryData, wifi: WiFiData, cell: CellularData) {
		let snapshot = SnapshotData()
		snapshot.battery = battery
		snapshot.wifi = wifi
		snapshot.cellular = cell
		
		do {
			let realm = try Realm()
			try realm.write {
				realm.add(snapshot)
			}
		} catch {
			print("error")
		}
	}
	
	public func retrieveAllSnapshots() -> [SnapshotData] {
		var realm : Realm!
		do {
			realm = try Realm()
		} catch {
			print("error")
		}
		let snapshots = realm.objects(SnapshotData.self)
		let snapshotsByDate = Array(snapshots.sorted(byKeyPath: "date", ascending: true))
		
		return snapshotsByDate
	}
}
