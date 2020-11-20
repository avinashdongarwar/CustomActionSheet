//
//  UIViewController+Extensions.swift
//  Custom Action Sheet
//
//  Created by Avinash Dongarwar on 11/19/20.
//  Copyright © 2020 Avinash Dongarwar. All rights reserved.
//

import UIKit

public extension UIViewController {
    func presentCustomActionSheet(_ customActionSheet: CustomActionSheetViewController, completion: (() -> Void)?) {
        self.present(customActionSheet, animated: false, completion: completion)
    }
}
