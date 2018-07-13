//
//  CitationsViewController.swift
//  Citations
//
//  Created by Vui Nguyen on 6/2/17.
//  Copyright © 2017 Minitex. All rights reserved.
//

import Foundation
import UIKit

public class CitationsViewController: UIViewController {

  @IBOutlet weak var segmentControl: UISegmentedControl!
  @IBOutlet weak var citationLabel: UILabel!
  @IBOutlet weak var closeButton: UIButton!
  
  @IBAction func didSelectSegment(_ sender: Any) {
    segmentControlAction()
  }

  @IBAction func didTapClose(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapShare(_ sender: Any) {
    var activityItems: [Any] = []
    if let shareText = citationLabel.text {
      activityItems.append(shareText)
    }
    
    let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

    self.present(activityViewController, animated: true, completion: nil)
  }

  fileprivate var citation: Citation?
  public var metadata: [String: AnyObject]?
  public var hideClose = false

  public override func viewDidLoad() {
    super.viewDidLoad()

    if self.hideClose == true {
      closeButton.isHidden = true
      closeButton.isEnabled = false
    }

    if (self.metadata != nil) {
      citation = Citation(metadata: metadata!)
    }
  
    segmentControlAction()
  }

  fileprivate func italicizeText(textToItalicize: String, positionToStartItalics: Int) {
    let customString = NSMutableAttributedString(string: citationLabel.text!)
    customString.addAttribute(NSAttributedStringKey.font, value: UIFont.italicSystemFont(ofSize: 17.0), range: NSRange(location: positionToStartItalics, length: textToItalicize.count))
    
    citationLabel.attributedText = customString
  }
  
  fileprivate func segmentControlAction() {
    switch (self.segmentControl.selectedSegmentIndex) {
    case 0:
      let textValues = citation?.ChicagoFormat()
      citationLabel.text = textValues?.fullCitation
      if citationLabel.text?.isEmpty == false {
        italicizeText(textToItalicize: (textValues?.textToItalicize)!, positionToStartItalics: (textValues?.positionToStartItalics)!)
      }
      break;
    case 1:
      let textValues = citation?.MLAFormat()
      citationLabel.text = textValues?.fullCitation
      if citationLabel.text?.isEmpty == false {
        italicizeText(textToItalicize: (textValues?.textToItalicize)!, positionToStartItalics: (textValues?.positionToStartItalics)!)
      }
      break;
    case 2:
      citationLabel.text = citation?.APAFormat()
    default:
      break;
    }
  }

}
