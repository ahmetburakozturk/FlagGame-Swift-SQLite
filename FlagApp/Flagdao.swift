//
//  Flagdao.swift
//  FlagApp
//
//  Created by ahmetburakozturk on 1.06.2023.
//

import Foundation

class Flagdao{
    
    let db:FMDatabase?
    init() {
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("flagdb.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    
    func insert(flagCountry:String, flagImage:String){
        db?.open()
        do{
            try db?.executeUpdate("INSERT INTO flag (FlagCountry,FlagImage) VALUES (?,?)", values: [flagCountry, flagImage])
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func getAll() -> [Flag]{
        var flags = [Flag]()
        db?.open()
        do{
            let rs = try db!.executeQuery("SELECT * FROM flag", values: nil)
            while rs.next() {
                let flag = Flag(ID: Int(rs.string(forColumn: "ID")!),FlagCountry: rs.string(forColumn: "FlagCountry")!, FlagImage: rs.string(forColumn: "FlagImage")!)
                flags.append(flag)
            }
        }catch{
            print(error)
        }
        db?.close()
        return flags
    }
    
    func getByRandomLimit() -> [Flag]{
        var flags = [Flag]()
        db?.open()
        do{
            let rs = try db!.executeQuery("SELECT * FROM flag ORDER BY RANDOM() LIMIT 4", values: nil)
            while rs.next() {
                let flag = Flag(ID: Int(rs.string(forColumn: "ID")!), FlagCountry: rs.string(forColumn: "FlagCountry")!, FlagImage: rs.string(forColumn: "FlagImage")!)
                flags.append(flag)
            }
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        
        return flags
    }
}
