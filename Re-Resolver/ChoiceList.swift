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
    
    // MARK: operations on ChoiceList
    func choose() -> String  {
        
        let numChoices = UInt32(choices.count)
        
        if numChoices == 0  {  // handle empty list
            return ""
        }  else  {
            let randomIndex = Int(arc4random() % numChoices)
            return choices[randomIndex]
        }
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
    
    // Save choices to a data file
    func saveChoices()  {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(choices, forKey: "Choices")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    // Replace data in the choices array with data
    // from a file.
    // If the file doesn't exist, nothing will happen
    // and no error is returned
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



