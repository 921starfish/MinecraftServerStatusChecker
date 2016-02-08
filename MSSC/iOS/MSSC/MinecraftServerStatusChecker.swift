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
        
        description = json["description"].string
        favicon = json["favicon"].string
        
        var sample:[Sample] = []
        let a = json["players"]["sample"].arrayValue
        for(var i = 0; i < a.count;i++){
            sample.append(Sample(name:json["players"]["sample"][i]["name"].string,id:json["players"]["sample"][i]["id"].string))
        }
        
        players = Players(max: json["players"]["max"].int,
            online: json["players"]["online"].int,
            sample: sample)
        
    }
    var version :Version!
    var players :Players!
    var description:String!
    var favicon:String!
    
    struct Version{
        var name:String!
        var _protocol:String!
    }
    struct Players {
        var max:Int!
        var online:Int!
        var sample:[Sample]!
    }
    struct Sample{
        var name:String!
        var id:String!
    }
}

class MinecraftServerStatusChecker{
    
    private func getStatus(host:String, port:String)->StatusFormat{
        let client = MinecraftClient(host: host, port: port)
        client.connect()
        let json = JSON.parse(client.GetStatus())
        client.closeNetworkCommunication()
        return StatusFormat(json: json)
    }
    
    func getAllStatus(array: [MinecraftServer])->[StatusFormat]{
        var statusList: [StatusFormat] = []
        for(var i = 0; i < array.count; i++){
            statusList.append(getStatus(array[i].host, port: array[i].port))
        }
        return statusList
    }

    func updateStatus(array: [MinecraftServer],var statusList: [StatusFormat], index:Int)->[StatusFormat]{
        let server: MinecraftServer = array[index]
        if(index == statusList.count){
            statusList.append(getStatus(server.host, port: server.port))
        }
        else if(index < statusList.count){
            statusList[index] = getStatus(server.host, port: server.port)
        }
        else if(index > statusList.count){
            statusList = getAllStatus(array)
        }
        return statusList
    }
}