//
//  MinecraftServerStatusChecker.swift
//  MSSC
//
//  Created by wang on 2016/02/07.
//  Copyright © 2016年 wang. All rights reserved.
//

import Foundation
struct StatusFormat {
    init(json:JSON){
        version = Version(name:json["version"]["name"].string,
            _protocol:json["version"]["protocol"].string)
        
        let description = Description(text: json["players"]["description"]["text"].string)
        
        var sample:[Sample] = []
        let a = json["players"]["sample"].arrayValue
        for(var i = 0; i < a.count;i++){
            sample.append(Sample(name:json["players"]["sample"][i]["name"].string,id:json["players"]["sample"][i]["id"].string))
        }
        
        players = Players(max: json["players"]["max"].int,
            online: json["players"]["online"].int,
            sample: sample,
            description: description,
            favicon: json["players"]["favation"].string)
        
    }
    var version :Version!
    var players :Players!

    struct Version{
        var name:String!
        var _protocol:String!
    }
    struct Players {
        var max:Int!
        var online:Int!
        var sample:[Sample]!
        var description:Description!
        var favicon:String!
    }
    struct Sample{
        var name:String!
        var id:String!
    }
    struct Description{
        var text:String!
    }
}

class MinecraftServerStatusChecker{
    private static var _instance: MinecraftServerStatusChecker?
    
    static var instance: MinecraftServerStatusChecker{
        get{
            if(_instance != nil){
                return _instance!
            }else{
                _instance = MinecraftServerStatusChecker()
                return _instance!
            }
        }
    }
    
    func getStatus(host:String, port:String)->StatusFormat{
        let client = MinecraftClient(host: host, port: port)
        client.connect()
        let json = JSON.parse(client.GetStatus())
        return StatusFormat(json: json)
    }
}