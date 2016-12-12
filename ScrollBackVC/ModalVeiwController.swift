//
//  ModalVeiwController.swift
//  ScrollBackVC
//
//  Created by Shinya Yamamoto on 2016/12/11.
//  Copyright © 2016年 plantio. All rights reserved.
//

import UIKit

protocol dissmissProtcol {
    func dismissDown()
    func dismissTop()
    func dismissCancel()
}

class ModalVeiwController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var bounceOffset:CGFloat = 0
    var willDismiss = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(tapCloseButton(_:)), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    
    @IBAction func tapCloseButton(_ sender:Any) {
        self.dismissDown()
    }
    
    
}

extension ModalVeiwController: dissmissProtcol {
    func dismissDown() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            var f = self.view.frame
            f.origin.y = self.view.frame.height
            self.view.frame = f
        }, completion: {_ in
            self.view.removeFromSuperview()
        })
    }
    func dismissTop() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            var f = self.view.frame
            f.origin.y = self.view.frame.height * -1
            self.view.frame = f
        }, completion: {_ in
            self.view.removeFromSuperview()
        })
    }
    func dismissCancel() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            var f = self.view.frame
            f.origin.y = 0
            self.view.frame = f
        }, completion: {_ in })
        
    }
}


//MARK:ScrollView
extension ModalVeiwController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > tableView.contentSize.height - tableView.frame.size.height {
            bounceOffset = scrollView.contentOffset.y - ( tableView.contentSize.height - tableView.frame.size.height )
        } else if scrollView.contentOffset.y < 0 {
            bounceOffset = scrollView.contentOffset.y
        }
        print("bounceOffset \(bounceOffset)")
        if(bounceOffset != 0 && !self.willDismiss) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                var f = self.view.frame
                f.origin.y = self.bounceOffset * -1
                self.view.frame = f
            }, completion: {_ in})
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let boundaryParcent:CGFloat = 0.25
        let offsetParcent = self.bounceOffset / self.view.frame.height
        if (offsetParcent < boundaryParcent * -1) {
            self.willDismiss = true
            self.dismissDown()
        } else if (offsetParcent > boundaryParcent) {
            self.willDismiss = true
            self.dismissTop()
        } else {
            self.willDismiss = false
            self.dismissCancel()
        }
    }
}

//MARK:TableView
extension ModalVeiwController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "1111"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
}
