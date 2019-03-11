//
//  ViewController.swift
//  SimpleFileManager
//
//  Created by Vladislav on 11/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let fileManager = FileManagerService()
    private let reuseIdentifier = "TableCell"
    private var elements: [(Types, String)]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        elements = fileManager.listFiles()
        
        let createButton = UIBarButtonItem(image: UIImage(named: "addFile"), style: .plain, target: self, action: #selector(barItemCreatePressed(_:)))
        self.navigationItem.rightBarButtonItem = createButton
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let elements = elements else {
            return 0
        }
        
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        
        let (type, name) = elements![indexPath.item]
        cell.textLabel?.text = name
        if type == .file {
            cell.imageView?.image = UIImage(named: "file")
        } else {
            cell.imageView?.image = UIImage(named: "directory")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fileManager.deleteFile(withName: elements![indexPath.item].1)
            elements = fileManager.listFiles()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func barItemCreatePressed(_ sender: Any?) {
        print("pressed")
    }

}

