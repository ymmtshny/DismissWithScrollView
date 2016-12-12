//
//  ViewController.swift
//  ScrollBackVC
//
//  Created by Shinya Yamamoto on 2016/12/11.
//  Copyright © 2016年 plantio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.button.addTarget(self, action:#selector(tapButton(_:)), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapButton(_ sener: Any) {
        let vc = ModalVeiwController()
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        vc.willMove(toParentViewController: self)
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
}
