//
//  ViewController.swift
//  Crypt
//
//  Created by Daniel Morán on 20/4/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let file = "Secrets/archivo.txt"
        let j = ProcessInfo.processInfo.environment["SRCROOT"]
        if let fileURL = URL(string: "file:///Users/dmoranm/Documents/ProyectosXcode/Crypt/Script/archivo.txt") {
            
            do {
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                print(content)
            }
            
            catch (let error) {
                print(error)
            }
        }
    }
}

