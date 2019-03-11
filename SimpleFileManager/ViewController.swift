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
//        self.fileManager.createDirectory(atPath: "Directory 2")
        elements = fileManager.listFiles()
        
        let createDirectoryButton = UIBarButtonItem(image: UIImage(named: "addDirectory"), style: .plain, target: self, action: #selector(barItemDirectoryPressed(_:)))
        let createFileButton = UIBarButtonItem(image: UIImage(named: "addFile"), style: .plain, target: self, action: #selector(barItemFilePressed(_:)))
        self.navigationItem.rightBarButtonItems = [createFileButton, createDirectoryButton]
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
    
    @objc func barItemFilePressed(_ sender: Any?) {
        let alert = UIAlertController(title: "File name", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        let createAction = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) {
            UIAlertAction in
            guard let name = alert.textFields?.first?.text else {
                print("text field was an empty")
                return
            }
            self.fileManager.createFile(withName: name)
            self.elements = self.fileManager.listFiles()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func barItemDirectoryPressed(_ sender: Any?) {
        let alert = UIAlertController(title: "Directory name", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        let createAction = UIAlertAction(title: "Create", style: UIAlertAction.Style.default) {
            UIAlertAction in
            guard let name = alert.textFields?.first?.text else {
                print("text field was an empty")
                return
            }
            print(name)
            self.fileManager.createDirectory(atPath: name)
            self.elements = self.fileManager.listFiles()
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        self.present(alert, animated: true, completion: nil)
    }

}

