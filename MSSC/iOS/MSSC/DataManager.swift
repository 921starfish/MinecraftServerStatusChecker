//
//  DataManager.swift
//  MSSC
//
//  Created by 王一道 on 2016/02/07.
//  Copyright © 2016年 王一道. All rights reserved.
//

import Foundation

class SaveObject{
    internal var length: Int = 0
    internal var serverArray: [(name:String, host:String, port:String)] = []
    internal func append(name:String,host:String,port:String){
        serverArray.append((name:name,host:host,port:port))
        length += 1
    }
    internal func remove(index:Int){
        serverArray.removeAtIndex(index)
        length -= 1
    }
}

class DataManager{
    private static var _instance :DataManager?
    internal var data: SaveObject = SaveObject()
    
    static var instance :DataManager{
        get{
            if(_instance != nil){
                return _instance!
            }else{
                _instance = DataManager()
                return _instance!
            }
        }
    }
    
    init(){
        data = load()
    }
    
    deinit{
        save(data)
    }
    
    func save(data :SaveObject){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        userDefaults.setObject(data.length, forKey: "length")
        
        for(var i = 0; i < data.length; i++){
            userDefaults.setObject(data.serverArray[i].name, forKey: "name" + String(i))
            userDefaults.setObject(data.serverArray[i].host, forKey: "host" + String(i))
            userDefaults.setObject(data.serverArray[i].port, forKey: "port" + String(i))
        }
    }
    
    func load()->SaveObject{
        data = SaveObject()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        data.length = userDefaults.integerForKey("length")
        
        for(var i = 0; i < data.length; i++){
            let name = userDefaults.stringForKey("name" + String(i))
            let host = userDefaults.stringForKey("host" + String(i))
            let port = userDefaults.stringForKey("port" + String(i))
            data.serverArray.append((name:name!,host:host!,port:port!))
        }
        return data
    }
}