//
//  ChoiceList.swift
//  Re-Resolver
//
//  Created by Keith Gilbertson on 5/15/16.
//  Copyright © 2016 Amanda and Keith. All rights reserved.
//

import Foundation

// This class represents a list of choices
//
// The list of choices can select a single
// choice from itself.
//
// The list also includes functionality to load
// and save itself to device storage.
//
// Although this class was added as part of a refactor,
// it is itself a candidate for a future refactor due to
// some oddities:
//
// - Load/Save functionality is available only
//    when the dataFileName property is set
//
// - The "choices" property, an Array of strings,
//   is an exposed implementation detail that clients
//   access directly
//
// - Though the class supports loading and saving,
//   control and timing of loading and saving
//   is left up to the calling class.
//   An alternate implementation of this class might
//   have saves performed automatially when the list is
//   modified, and automatically load contents 
//   upon initialization
class ChoiceList  {
    
    
    var choices: [String] = []
    var dataFileName: String?
    
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
    // code here adapted from:
    // iOS Apprentice, 4th edition - Matthjis Hollemans
    // The book is available from http://raywenderlich.com
    private func documentsDirectory() -> String  {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    
    private func dataFilePath() -> String  {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent(dataFileName!)
    }
    
    // Save choices to the dataFile, if set
    func saveChoices()  {
        
        guard dataFileName != nil else {
            return
        }
        
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
        
        guard dataFileName != nil else {
            return
        }
        
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path)  {
            if let data = NSData(contentsOfFile: path)  {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                choices = unarchiver.decodeObjectForKey("Choices") as! [String]
            }
        }
    }
  

}



