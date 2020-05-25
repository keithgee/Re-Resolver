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
    
    // Choose an item from the list
    // Returns an empty String if the list is empty.
    func choose() -> String  {
        choices.randomElement() ?? ""
    }
    
    
    // MARK: - Save and load features
    // code here adapted from:
    // iOS Apprentice, 4th edition - Matthjis Hollemans
    // The book is available from http://raywenderlich.com
    private func documentsDirectory() -> String  {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0]
    }
    
    
    private func dataFilePath() -> String  {
        return (documentsDirectory() as NSString).appendingPathComponent(dataFileName!)
    }
    
    // Save choices to the dataFile, if set
    func save() throws {
        
        guard dataFileName != nil else {
            return
        }
        
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        archiver.encode(choices, forKey: "Choices")
        let data = archiver.encodedData
        try data.write(to: URL(fileURLWithPath: dataFilePath()), options: .atomic)
    }
    
    // Replace data in the choices array with data
    // from a file.
    // If the file doesn't exist, nothing will happen
    // and no error is returned
    func load() {
        
        guard dataFileName != nil else {
            return
        }
        
        let path = dataFilePath()
        
        if FileManager.default.fileExists(atPath: path)  {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path))  {
                do  {
                    if let unarchiver = try? NSKeyedUnarchiver(forReadingFrom: data)  {
                        choices = unarchiver.decodeDecodable([String].self, forKey: "Choices") ?? []
                    }
                }
                
            }
        }
    }
  

}



