//
//  MinecraftClient.swift
//  MSSC
//
//  Created by wang on 2016/02/07.
//  Copyright © 2016年 wang. All rights reserved.
//
import Foundation

class MinecraftClient:NSObject,NSStreamDelegate {
    private var _buffer:[UInt8] = []
    private var _offset:Int = 0
    internal var host:String
    internal var port:String
    var inputStream : NSInputStream?
    var outputStream : NSOutputStream?
    
    init(host:String,port:String) {
        self.host = host
        self.port = port
    }
    
    override init(){
        self.host = "localhost"
        self.port = "25565"
    }
    
    internal func connect(){
        let host : CFString = NSString(string: self.host)
        let port : UInt32 = UInt32(self.port)!
        var readStream : Unmanaged<CFReadStream>?
        var writeStream : Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host, port, &readStream, &writeStream)
        
        inputStream = readStream!.takeUnretainedValue()
        outputStream = writeStream!.takeUnretainedValue()
        
        inputStream!.delegate = self
        outputStream!.delegate = self
        
        inputStream!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        outputStream!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        inputStream!.open()
        outputStream!.open()
    }
    
    func closeNetworkCommunication()
    {
        self.inputStream?.close()
        self.outputStream?.close()
        
        self.inputStream?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream?.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.inputStream?.delegate = nil
        self.outputStream?.delegate = nil
        
        self.inputStream = nil;
        self.outputStream = nil;
        
    }
    
    internal func GetStatus()->String{
        _buffer = Array<UInt8>(count: 0, repeatedValue: 0)
        writeVarInt(47);
        writeString(host);
        writeShort(Int16(self.port)!);
        writeVarInt(1);
        flush(0);
        flush(0);
        var buffer = Array<UInt8>(count: 4096*2, repeatedValue: 0)
        inputStream?.read(&buffer, maxLength: buffer.count)
        let jsonLength = try! readVarInt(buffer)
        var res = readString(buffer, length: jsonLength)
        if(res == "Optional()" || res == "nil" || res == ""){
            return ""
        }
        while(res[res.startIndex] != "{"){
            res.removeAtIndex(res.startIndex)
        }
        while(res[res.endIndex.advancedBy(-1)] != "}"){
            res.removeAtIndex(res.endIndex.advancedBy(-1))
        }
        return res
    }
    
    internal func readByte(buffer:[UInt8])->UInt8{
        let b = buffer[_offset]
        _offset += 1
        return b
    }
    
    internal func read(buffer:[UInt8],length:Int)->[UInt8]{
        var data = Array<UInt8>(count: length, repeatedValue: 0)
        for(var i = 0; i < length; i++){
            data[i] = buffer[_offset + i]
        }
        _offset += length
        return data
    }
    
    internal func readVarInt(buffer: [UInt8])throws->Int{
        var value = 0
        var size = 0
        var b = Int(readByte(buffer))
        while((b & 0x80) == 0x80){
            value |= (b & 0x7F) << (size++ * 7)
            if(size > 5){
                throw NSError(domain: "This VarInt is an imposter!", code: -1, userInfo: nil)
            }
            b = Int(readByte(buffer))
        }
        return value | ((b & 0x7F) << (size * 7));
    }
    
    internal func readString(buffer: [UInt8],length: Int)->String{
        let data = read(buffer,length: length)
        return  String(NSString(bytes: data,length:length, encoding: NSUTF8StringEncoding))
    }
    
    internal func writeVarInt(var value:Int){
        while((value & 128) != 0){
            _buffer.append(UInt8(value & 127 | 128))
            value = Int(UInt(value)) >> 7
        }
        _buffer.append(UInt8(value))
    }
    
    func toByteArray<T>(var value: T) -> [UInt8] {
        return withUnsafePointer(&value) {
            Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)))
        }
    }
    
    internal func writeShort(value:Int16){
        _buffer.appendContentsOf(toByteArray(value))
    }
    
    internal func writeString(data:String){
        let buffer = data.utf8
        writeVarInt(buffer.count)
        _buffer.appendContentsOf(buffer)
    }
    
    internal func write(b :UInt8){
        outputStream?.write([b], maxLength: 1)
    }
    
    private func copybuffer(buffer :[UInt8])->[UInt8]{
        var cbuffer = Array<UInt8>(count: buffer.count, repeatedValue: 0)
        for(var i=0;i < buffer.count;i++){
            cbuffer[i] = buffer[i]
        }
        return cbuffer
    }
    
    internal func flush(id :Int = -1){
        let buffer = copybuffer(_buffer)
        _buffer = Array<UInt8>(count: 0, repeatedValue: 0)
        
        var add = 0;
        var packetData = [UInt8(0x00)]
        if(id >= 0){
            writeVarInt(id)
            packetData = copybuffer(_buffer)
            add = packetData.count;
            _buffer = Array<UInt8>(count: 0, repeatedValue: 0)
        }
        
        writeVarInt(buffer.count + add)
        let bufferLength = copybuffer(_buffer)
        _buffer = Array<UInt8>(count: 0, repeatedValue: 0)
        
        outputStream?.write(bufferLength, maxLength:bufferLength.count)
        outputStream?.write(packetData, maxLength:packetData.count)
        outputStream?.write(buffer, maxLength:buffer.count)
    }
}

