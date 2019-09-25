//
//  ViewController.swift
//  CountLabelSample
//
//  Created by 엄기철 on 2019/09/25.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var counterLabel: LabelCounting!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    counterLabel.count(fromValue: 0, toValue: 9999, duration: 5, animationType: .EaseOut, counterType: .Int)
  }


}

