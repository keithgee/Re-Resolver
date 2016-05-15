//
//  ChoiceList.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import Foundation

// This class represents a list of choices
// and includes functionality to load and save itself
// to device storage.
class ChoiceList  {
    
    
    var choices: [String] = []
    
    init  (choices: [String]) {
        self.choices = choices
    }
    
    // MARK: - Save and load features

    // code here adapted from iOS Apprentice - Matthjis Hollemans
    func documentsDirectory() -> String  {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    
    func dataFilePath() -> String  {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent("Choices.plist")
    }
    
    func saveChoices()  {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(choices, forKey: "Choices")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChoices() {
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path)  {
            if let data = NSData(contentsOfFile: path)  {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                choices = unarchiver.decodeObjectForKey("Choices") as! [String]
            }
        }
    }

}



