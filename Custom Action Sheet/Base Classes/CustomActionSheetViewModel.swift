//
//  CustomActionSheetViewModel.swift
//  Custom Action Sheet
//
//  Created by Avinash Dongarwar on 11/19/20.
//  Copyright © 2020 Avinash Dongarwar. All rights reserved.
//

import Foundation
import UIKit

public struct CustomActionSheetViewModel: CustomActionSheetPresentable {

    public var cornerRadius: CGFloat
    public var animationTransitionDuration: TimeInterval
    public var backgroundColor: UIColor

    public init() {
        cornerRadius = 20
        animationTransitionDuration = 0.3
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    public init(cornerRadius: CGFloat,
                animationTransitionDuration: TimeInterval,
                backgroundColor: UIColor ) {

        self.cornerRadius = cornerRadius
        self.animationTransitionDuration = animationTransitionDuration
        self.backgroundColor = backgroundColor
    }
}
