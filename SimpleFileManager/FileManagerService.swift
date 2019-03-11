//
//  FileManagerService.swift
//  SimpleFileManager
//
//  Created by Vladislav on 11/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

class FileManagerService {
    
    private let text = "Hello world!"
    
    func listFiles(in directory: String = "") -> [(Types, String)] {
        let docsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = docsPath[0]
        let docs = try? FileManager.default.contentsOfDirectory(atPath: docsURL.path)
        
        var elements = [(Types, String)]()
        
        for doc in docs! {
            // Убираем из выдачи скрытый файл .DS_Store
            if !doc.contains(".DS_Store") {
                if let _ = try? FileManager.default.contentsOfDirectory(atPath: docsURL.path + "/\(doc)") {
                    elements.append((.directory, doc))
                } else {
                    elements.append((.file, doc))
                }
            }
        }
        
        return elements
    }
    
    func createDirectory(atPath: String) {
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let newDir = docsURL.appendingPathComponent(atPath)
        try? FileManager.default.createDirectory(at: newDir, withIntermediateDirectories: false, attributes: nil)
    }
    
    func createFile(withName name: String, atPath: String = "") {
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath = docsURL.path + "/" + name
        print(filePath)
        let content = text.data(using: .utf8)
//        let newDir = docsURL.appendingPathComponent(atPath)
        FileManager.default.createFile(atPath: filePath, contents: content, attributes: nil)
    }
    
}
