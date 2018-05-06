//
//  PopViewControlereViewController.swift
//  Planets
//
//  Created by Kai on 5/5/18.
//  Copyright © 2018 Rayan Slim. All rights reserved.
//

import UIKit

protocol PopDelegate {
    func tabNumber(number : Int)
}

class PopViewControlereViewController: UIViewController {
    var delegateData : PopDelegate?

    @IBAction func no1Action(_ sender: UIButton) {
        delegateData?.tabNumber(number: sender.tag)
    }
    
}
