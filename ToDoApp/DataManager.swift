//
//  DataManager.swift
//  ToDoApp
//
//  Created by macOS High Sierra on 20/11/18.
//  Copyright © 2018 Hasmot Ali Hasu. All rights reserved.
//

import Foundation

public class DataManager {
    
    //get document directory
    static fileprivate func getDocumentDictionary() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        }else{
            fatalError("Unable To Access Document Directory")
        }
    }
    
    //save any kind of codable object
    
    static func save <T: Encodable>  ( Object:T, with fileName: String) {
            let url = getDocumentDictionary().appendingPathComponent(fileName, isDirectory: false)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(Object)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }catch{
            fatalError(error.localizedDescription)
        }
    }
    //load any kind of codable object
    
    static func load <T: Decodable> ( fileName: String, with type:T.Type) -> T {
        let url = getDocumentDictionary().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File Not Found At Path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            do{
                let model = try JSONDecoder().decode(type, from: data)
                return model
            }catch{
                fatalError(error.localizedDescription)
            }
        }else{
            fatalError("Data Unavailable at path \(url.path)")
        }
    }
    //load data from a file
    static func loadData ( fileName: String) -> Data? {
        let url = getDocumentDictionary().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path) {
            fatalError("File Not Found At Path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            return data
        }else{
            fatalError("Data Unavailable at path \(url.path)")
        }
    }
    //load all file from a directory
    static func loadAll <T:Decodable> ( type:T.Type) -> [T] {
        do{
            let files =  try FileManager.default.contentsOfDirectory(atPath: getDocumentDictionary().path)
            var modelObject = [T] ()
            for fileName in files{
                modelObject.append(load(fileName: fileName, with: type))
            }
            return modelObject
        }catch{
            fatalError("Could Not Load Any File!")
        }
    }
    
    //delete a file
    static func delete  ( filename : String) {
        let url = getDocumentDictionary().appendingPathComponent(filename, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.removeItem(at: url)
            }catch{
                fatalError(error.localizedDescription)
            }
        }
    }
}
