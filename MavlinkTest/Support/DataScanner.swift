//
//  DataScanner.swift
//  MavlinkTest
//
//  Created by Jonathan Wight on 3/29/15.
//  Copyright (c) 2015 schwa.io. All rights reserved.
//

import Foundation

struct DataScanner {
    typealias BufferType = UnsafeBufferPointer <UInt8>
    let buffer:BufferType
    var current:BufferType.Index

    init(buffer:BufferType) {
        self.buffer = buffer
        current = self.buffer.startIndex
    }

    mutating func scan() -> UInt8? {
        if atEnd {
            return nil
        }
        let result = buffer[current]
        current = current.advancedBy(1)
        return result
    }


    mutating func scan() -> Int8? {
        if let unsigned:UInt8 = scan() {
            return Int8(unsigned)
        }
        else {
            return nil
        }
    }

    mutating func scan() -> UInt16? {
        typealias Type = UInt16
        if atEnd {
            return nil
        }
        let offset = buffer.baseAddress.advancedBy(current)
        let b = UnsafePointer <Type> (offset)
        let result = b.memory
        // TODO; Endianness
        current = current.advancedBy(sizeof(Type))
        return result
    }

    mutating func scan() -> Int16? {
        if let unsigned:UInt16 = scan() {
            return Int16(unsigned)
        }
        else {
            return nil
        }
    }

    mutating func scan() -> UInt32? {
        typealias Type = UInt32
        if atEnd {
            return nil
        }
        let offset = buffer.baseAddress.advancedBy(current)
        let b = UnsafePointer <Type> (offset)
        let result = b.memory
        // TODO; Endianness
        current = current.advancedBy(sizeof(Type))
        return result
    }

    mutating func scan() -> Int32? {
        if let unsigned:UInt32 = scan() {
            return Int32(unsigned)
        }
        else {
            return nil
        }
    }

    mutating func scan() -> UInt64? {
        typealias Type = UInt64
        if atEnd {
            return nil
        }
        let offset = buffer.baseAddress.advancedBy(current)
        let b = UnsafePointer <Type> (offset)
        let result = b.memory
        // TODO; Endianness
        current = current.advancedBy(sizeof(Type))
        return result
    }

    mutating func scan() -> Int64? {
        if let unsigned:UInt64 = scan() {
            return Int64(unsigned)
        }
        else {
            return nil
        }
    }


    mutating func scan() -> Float? {
        return nil
    }

    mutating func scan() -> Double? {
        return nil
    }

    mutating func scan(value:UInt8) -> Bool {
        if let scannedValue:UInt8 = scan() {
            return scannedValue == value
        }
        else {
            return false
        }
    }

    mutating func scanBuffer(count:Int) -> UnsafeBufferPointer <UInt8>? {
        if atEnd {
            return nil
        }
        let scannedBuffer = UnsafeBufferPointer <UInt8> (start: buffer.baseAddress.advancedBy(current), count: count)
        current = current.advancedBy(count)
        return scannedBuffer
    }

    mutating func scanString(count:Int) -> String? {
        if atEnd {
            return nil
        }
        if let buffer:UnsafeBufferPointer <CChar> = scanBuffer(count)?.asUnsafeBufferPointer() {
            // TODO: bil byte???

            // Use NSData etc

            return String.fromCString(buffer.baseAddress)
        }
        else {
            return nil
        }
    }


    var atEnd:Bool {
        get {
            return current == buffer.endIndex
        }
    }
}