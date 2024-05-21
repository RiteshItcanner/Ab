//
//  ViewController.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 17/05/24.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Constants.API.baseURL)
        
    }

    @IBAction func onClickButton(_ sender: Any) {
//        let vc = VC2()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VC2") as! VC2
        self.navigateToViewController(vc)
    }
    

}

