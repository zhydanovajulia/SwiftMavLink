//
//  MavlinkScanner.swift
//  SwiftMavlink
//
//  Created by Jonathan Wight on 4/22/15.
//  Copyright (c) 2015 schwa.io. All rights reserved.
//

import SwiftUtilities

public class MavlinkDataScanner: DataScanner {
    public func scan() -> Message? {
        if let message = Message(buffer: remaining, skipCRC:true) {
            current += message.length
            return message
        }
        return nil
    }
}