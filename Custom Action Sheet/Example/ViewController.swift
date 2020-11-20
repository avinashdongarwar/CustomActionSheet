//
//  ViewController.swift
//  Custom Action Sheet
//
//  Created by Avinash Dongarwar on 11/19/20.
//  Copyright © 2020 Avinash Dongarwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func presentBottomSheet(_ sender: Any) {

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
