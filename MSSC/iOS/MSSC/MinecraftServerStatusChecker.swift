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
        
        let description = json["description"].string
        
        var sample:[Sample] = []
        let a = json["players"]["sample"].arrayValue
        for(var i = 0; i < a.count;i++){
            sample.append(Sample(name:json["players"]["sample"][i]["name"].string,id:json["players"]["sample"][i]["id"].string))
        }
        
        players = Players(max: json["players"]["max"].int,
            online: json["players"]["online"].int,
            sample: sample,
            description: description,
            favicon: json["favation"].string)
        
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
        var description:String!
        var favicon:String!
    }
    struct Sample{
        var name:String!
        var id:String!
    }
}

class MinecraftServerStatusChecker{
    var serverlist:[(server: MinecraftServer,data: StatusFormat)] = []
    
    private func getStatus(host:String, port:String)->StatusFormat{
        let client = MinecraftClient(host: host, port: port)
        client.connect()
        let json = JSON.parse(client.GetStatus())
        client.closeNetworkCommunication()
        return StatusFormat(json: json)
    }
    
    func getAllStatus(data: SaveObject){
        serverlist = []
        for(var i = 0; i < data.length; i++){
            serverlist.append((data.serverArray[i],getStatus(data.serverArray[i].host, port: data.serverArray[i].port)))
        }
    }

    func updateStatus(array: [MinecraftServer], index:Int){
        if(index == serverlist.count){
            serverlist.append((server: array[index], data: getStatus(array[index].host, port: array[index].port)))
        }
        else if(index < serverlist.count){
            serverlist[index].data = getStatus(array[index].host, port: array[index].port)
        }
    }
}