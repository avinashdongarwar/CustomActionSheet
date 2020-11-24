//
//  ExampleViewController.swift
//  Custom Action Sheet
//
//  Created by Avinash Dongarwar on 11/19/20.
//  Copyright © 2020 Avinash Dongarwar. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {

    @IBOutlet weak var endChatView: UIView!
    @IBOutlet weak var surveyView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func transitionToSurveyView(_ sender: UIButton!) {
        UIView.transition(from: endChatView!,
                          to: surveyView!,
                          duration: 2.0,
                          options: [.transitionCrossDissolve, .showHideTransitionViews],
                          completion: nil)
    }

}
