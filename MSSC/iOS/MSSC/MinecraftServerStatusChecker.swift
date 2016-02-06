//
//  MinecraftServerStatusChecker.swift
//  MSSC
//
//  Created by 王一道 on 2016/02/07.
//  Copyright © 2016年 王一道. All rights reserved.
//

import Foundation
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
}