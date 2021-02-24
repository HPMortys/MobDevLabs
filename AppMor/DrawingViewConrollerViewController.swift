//
//  DrawingViewConrollerViewController.swift
//  AppMor
//
//  Created by Den Mor on 18.02.2021.
//

import UIKit

class DrawingViewConrollerViewController: UIViewController {

    
    @IBOutlet weak var viewDraw: DemoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func segmentChange(_ segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            viewDraw.drawShape(selectedShape: .graph)
        case 1:
            viewDraw.drawShape(selectedShape: .chart)
        default:
            viewDraw.drawShape(selectedShape: .chart)
    }
    }
}
