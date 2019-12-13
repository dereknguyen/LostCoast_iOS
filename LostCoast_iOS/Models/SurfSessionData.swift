//
//  SurfSessionData.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/30/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation
import RealmSwift

class SurfSessionData {
    
    /// Saved sessions
    var sessions = List<Session>()
}

@objcMembers
class Session: Object {
    
    /// Session Sync time
    dynamic var syncTime: TimeInterval = 0
    
    /// Session wave data
    dynamic var waveData = List<Wave>()
    
    dynamic var powerScore = RealmOptional<Int>()
    dynamic var flowScore = RealmOptional<Int>()
    dynamic var speedScore = RealmOptional<Int>()
    dynamic var varietyScore = RealmOptional<Int>()
    dynamic var difficultyScore = RealmOptional<Int>()
    
    convenience init(time: TimeInterval, waves: List<Wave>, power: Int, flow: Int, speed: Int, variety: Int, difficulty: Int) {
        self.init()
        
        self.syncTime = time
        self.waveData = waves
        self.powerScore.value = power
        self.flowScore.value = flow
        self.speedScore.value = speed
        self.varietyScore.value = variety
        self.difficultyScore.value = difficulty
    }
}

@objcMembers
class Wave: Object {
    
    /// Time stamp of the wave
    dynamic var timestamp: TimeInterval = 0
    
    /// Height of the wave
    dynamic var height: Double = 0.0
    
    /// Distance that the user rode the wave for
    dynamic var distance: Double = 0.0
    
    /// The ride time of the wave
    dynamic var rideTimeMinute = RealmOptional<Int>()
    dynamic var rideTimeSecond = RealmOptional<Int>()
    
    /// The location of the wave (x, y, z)
    dynamic var x: Double = 0.0
    dynamic var y: Double = 0.0
    dynamic var z: Double = 0.0
    
    /// Unit for distance
    dynamic var distanceUnit: String = "Feet"
    
    /// Unit for force
    dynamic var forceUnit: String = "G"
    
    /// The cutbacks that user made
    dynamic var cutbacks = List<Cutback>()
    
    dynamic var powerScore = RealmOptional<Int>()
    dynamic var flowScore = RealmOptional<Int>()
    dynamic var speedScore = RealmOptional<Int>()
    dynamic var varietyScore = RealmOptional<Int>()
    dynamic var difficultyScore = RealmOptional<Int>()
    
    convenience init(timestamp: TimeInterval, height: Double, distance: Double, rideTimeMinute: Int, rideTimeSecond: Int, cutbacks: List<Cutback>, power: Int, flow: Int, speed: Int, variety: Int, difficulty: Int) {
        self.init()
        
        self.timestamp = timestamp
        self.height = height
        self.distance = distance
        self.rideTimeMinute.value = rideTimeMinute
        self.rideTimeSecond.value = rideTimeSecond
        self.cutbacks = cutbacks
        self.powerScore.value = power
        self.flowScore.value = flow
        self.speedScore.value = speed
        self.varietyScore.value = variety
        self.difficultyScore.value = difficulty
    }
}

@objcMembers
class Cutback: Object {
    
    /// Cutback force
    dynamic var force: Double = 0.0
    
    /// Cutback angle
    dynamic var angle: Double = 0.0
    
    convenience init(force: Double, angle: Double) {
        self.init()
        
        self.force = force
        self.angle = angle
    }

}
