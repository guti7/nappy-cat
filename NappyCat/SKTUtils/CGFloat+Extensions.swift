//
//  CGFloat+Extensions.swift
//  NappyCat
//
//  Created by peche on 9/9/23.
//

import CoreGraphics

/// The value of π as a CGfloat
let π = CGFloat(Double.pi)

public extension CGFloat {
    
    /// Converts an angle in radians to degrees.
    func radiansToDegrees() -> CGFloat {
        return self * 180.0 / π
    }
    
    /// Converts an angle in degrees to radians.
    func degreesToRadians() -> CGFloat {
        return π * self / 180.0
    }
}
