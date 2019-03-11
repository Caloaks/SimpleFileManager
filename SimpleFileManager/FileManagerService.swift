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
    
    func listFiles(in directory: String = "") {
        let docsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsURL = docsPath[0]
        
        print(docsURL)
        for doc in docsPath {
            print(doc.baseURL)
        }
    }
    
    func createDirectory(atPath: String) {
        let docsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let newDir = docsURL.appendingPathComponent(atPath)
        try? FileManager.default.createDirectory(at: newDir, withIntermediateDirectories: false, attributes: nil)
    }
    
}
