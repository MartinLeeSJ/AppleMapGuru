//
//  UndimmedPresentationDetent.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI

enum UndimmedPresentationDetent {

    case large
    case medium

    case fraction(_ value: CGFloat)
    case height(_ value: CGFloat)

    var swiftUIDetent: PresentationDetent {
        switch self {
        case .large: return .large
        case .medium: return .medium
        case .fraction(let value): return .fraction(value)
        case .height(let value): return .height(value)
        }
    }

    var uiKitIdentifier: UISheetPresentationController.Detent.Identifier {
        switch self {
        case .large: return .large
        case .medium: return .medium
        case .fraction(let value): return .fraction(value)
        case .height(let value): return .height(value)
        }
    }
}




