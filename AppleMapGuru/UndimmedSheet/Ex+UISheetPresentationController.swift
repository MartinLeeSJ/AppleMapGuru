//
//  Ex+UISheetPresentationController.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//
import SwiftUI

extension UISheetPresentationController.Detent.Identifier {

    static func fraction(_ value: CGFloat) -> Self {
        .init("Fraction:\(String(format: "%.1f", value))")
    }

    static func height(_ value: CGFloat) -> Self {
        .init("Height:\(value)")
    }
}
