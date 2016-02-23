//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by WangXin on 2/23/16.
//  Copyright © 2016 WangXin. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate {
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory: [Int] {
        get {
            return defaults.objectForKey(History.defaultsKey) as? [Int] ?? []
        }
        set {
            defaults.setObject(newValue, forKey: History.defaultsKey)
        }
    }
    
    private struct History {
        static let segueIdentifier = "Show Diagnostic History"
        static let defaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case History.segueIdentifier:
                    if let tvc = segue.destinationViewController as? TextViewController {
                        if let ppc = tvc.popoverPresentationController {
                            ppc.delegate = self
                        }
                        tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
