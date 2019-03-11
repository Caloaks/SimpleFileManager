//
//  ViewController.swift
//  SimpleFileManager
//
//  Created by Vladislav on 11/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let fileManager = FileManagerService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileManager.createFile(withName: "File 1")
        fileManager.listFiles()
    }


}

