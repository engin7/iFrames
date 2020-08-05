//
//  PersistenceManager.swift
//  iFrames
//
//  Created by Engin KUK on 3.08.2020.
//  Copyright © 2020 Engin KUK. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum PersistenceManager {
    
  
    static func saveImage(image: UIImage, path: String) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(path)!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        
    }
 
    static func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }

     
}

 

//usage:
//let success = saveImage(image: UIImage(named: "image.png")!)
//_ = PersistenceManager.saveImage(image: image, path: path)

// to get image:

//if let image = PersistenceManager.getSavedImage(named: path) {
//     do something with image
//}


