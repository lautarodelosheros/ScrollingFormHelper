//
//  UIApplication+Extensions.swift
//  ScrollingFormHelper
//
//  Created by Lautaro de los Heros on 25/10/2021.
//

import Foundation

extension UIApplication {
    
    /// Source: https://stackoverflow.com/a/68989580
    var keyWindow: UIWindow? {
        guard #available(iOS 13.0, *) else {
            return UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        }
        // Get connected scenes
        return UIApplication.shared.connectedScenes
        // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
        // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
        // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
        // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
}
