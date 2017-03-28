//
//  ViewController.swift
//  ProgressCirleDemo
//
//  Created by SongLan on 2017/3/8.
//  Copyright © 2017年 Asong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let myView = CirleProgressWaveView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        myView.center = self.view.center
        myView.layer.masksToBounds = true
        myView.layer.cornerRadius = 75
        self.view.addSubview(myView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

