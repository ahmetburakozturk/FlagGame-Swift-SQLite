//
//  ViewController.swift
//  FlagApp
//
//  Created by ahmetburakozturk on 1.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        copyDbToDevice()
    }
    
    func copyDbToDevice(){
        let bundlePath = Bundle.main.path(forResource: "flagdb", ofType: ".sqlite")
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let copyPath = URL(fileURLWithPath: destinationPath).appendingPathComponent("flagdb.sqlite")
        if fileManager.fileExists(atPath: copyPath.path){
            print("DB Already Exist in This Device!")
        } else {
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: copyPath.path)
            } catch{
                print(error)
            }
        }
    }


}

