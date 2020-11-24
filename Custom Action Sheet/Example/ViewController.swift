//
//  ViewController.swift
//  Custom Action Sheet
//
//  Created by Avinash Dongarwar on 11/19/20.
//  Copyright © 2020 Avinash Dongarwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func presentBottomSheet(_ sender: UIButton!) {

        let exampleViewController = ExampleViewController()

        let sheetViewModel = CustomActionSheetViewModel(
            cornerRadius: 20,
            animationTransitionDuration: 0.3,
            backgroundColor: UIColor.black.withAlphaComponent(0.4)
        )

        let sheetViewController = CustomActionSheetViewController(
            viewModel: sheetViewModel,
            childViewController: exampleViewController
        )

        presentCustomActionSheet(sheetViewController, completion: nil)
    }
}


class RoundedCornersButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }

    @IBInspectable
    var borderWidth: CGFloat = 1.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable
    var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
}

