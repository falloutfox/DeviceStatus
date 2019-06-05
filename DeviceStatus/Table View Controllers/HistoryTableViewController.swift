//
//  HistoryTableViewController.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 04/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
	private var tableData : [SnapshotData] = []
	private var dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
		dateFormatter.calendar = Calendar.current
		dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"

        tableData = DatabaseManager.shared.retrieveAllSnapshots()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
		
		if let historyCell = cell as? HistoryTableViewCell {
			let snapshot = tableData[indexPath.row]
			
			historyCell.dateLabel.text = dateFormatter.string(from: snapshot.date)
			historyCell.batteryLevel.text = "\(Int(snapshot.battery.level*100))%"
			historyCell.cellularSignal.text = "\(snapshot.cellular.strength)"
			
			var wifiStrength = "\(Int(snapshot.wifi.signalStrength))"
			if !UIDevice.current.hasNotch {
				wifiStrength.append("dB")
			}
			
			historyCell.wifiStrength.text = wifiStrength
			
			switch (snapshot.battery.state) {
			case .charging:
				historyCell.batteryState.text = "charging"
			case .full:
				historyCell.batteryState.text = "full"
			case .unplugged:
				historyCell.batteryState.text = "unplugged"
			default:
				historyCell.batteryState.text = "unknown"
			}
		}
		
        return cell
    }
}
