//
//  DataManager.swift
//  MSSC
//
//  Created by wang on 2016/02/07.
//  Copyright © 2016年 wang. All rights reserved.
//

import Foundation

class SaveObject{
    internal var length: Int = 0
    internal var serverArray: [MinecraftServer] = []
    internal func add(server: MinecraftServer){
        serverArray.append(server)
        length += 1
    }
    internal func remove(index:Int){
        serverArray.removeAtIndex(index)
        length -= 1
    }
}
struct MinecraftServer {
    var name:String
    var host:String
    var port:String
}

class DataManager{
    private static var _instance :DataManager?
    internal var data: SaveObject = SaveObject()
    private var checker = MinecraftServerStatusChecker()

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
        checker.getAllStatus(data)
    }
    
    deinit{
        save(data)
    }
    
    func add(server: MinecraftServer){
        data.add(server)
        checker.updateStatus(data.serverArray, index: data.serverArray.count - 1)
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
            data.serverArray.append(MinecraftServer(name:name!,host:host!,port:port!))
        }
        return data
    }
}