//
//  UIDevice+hasNotch.swift
//  DeviceStatus
//
//  Created by Ollie Stowell on 05/06/2019.
//  Copyright © 2019 Oliver Stowell. All rights reserved.
//

import UIKit

extension UIDevice {
	var hasNotch: Bool {
		let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
		return bottom > 0
	}
}
