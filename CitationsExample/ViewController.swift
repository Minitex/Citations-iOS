//
//  ViewController.swift
//  CitationsExample
//
//  Created by Vui Nguyen on 5/31/17.
//  Copyright © 2017 Minitex. All rights reserved.
//

import UIKit
import Citations

class ViewController: UIViewController {
  @IBAction func didTapCitationButton(_ sender: Any) {
    print("tapped Citation Button")

    let bundle = Bundle(identifier: "edu.umn.minitex.simplye.Citations")
    let sb = UIStoryboard(name: "Citations", bundle: bundle)

    let citationsViewController = sb.instantiateViewController(withIdentifier: "Citations") as! CitationsViewController

    // The Close button is displayed by default on the CitationsViewController
    // Uncomment this line of code if you want to hide the Close button
    // (ie, if there is already a back button in the navigation controller to go back)
    //citationsViewController.hideClose = true

    citationsViewController.metadata = BookMetadata.dictionary()

    self.present(citationsViewController, animated: true, completion: nil)
  }
}

