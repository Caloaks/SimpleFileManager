//
//  FileViewController.swift
//  SimpleFileManager
//
//  Created by Vladislav on 12/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class FileViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var name: String?
    var text: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = name {
            self.title = name
        }
        
        self.textView.frame = self.view.frame
        
        if let text = self.text {
            self.textView.text = text
        } else {
            self.textView.text = ""
        }
    }
}
