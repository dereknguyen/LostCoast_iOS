//
//  SurfSessionDataAPI.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/31/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RealmSwift

class SurfSessionDataAPI {
    
    /// Singleton instance
    static var shared = SurfSessionDataAPI()
    
    func generateSession() -> Session {
        let timestamp_sync = Date()
        
        let numOfWaves = randomInt(min: 2, max: 12)
        
        
        let waves = List<Wave>()
        
        for _ in 0..<numOfWaves {
            waves.append(generateWave(syncTime: timestamp_sync))
        }
        
        let power = getAvgPower(waves: waves)
        let flow = getAvgFlow(waves: waves)
        let speed = getAvgSpeed(waves: waves)
        let variety = getAvgVariety(waves: waves)
        let difficulty = getAvgDifficulty(waves: waves)
        
        return Session(time: timestamp_sync.timeIntervalSince1970, waves: waves, power: power, flow: flow, speed: speed, variety: variety, difficulty: difficulty)
    }
    
    func getAvgPower(waves: List<Wave>) -> Int {
        var total = 0
        for wave in waves {
            total += wave.powerScore.value ?? 0
        }
        return total / waves.count
    }
    
    func getAvgFlow(waves: List<Wave>) -> Int {
        var total = 0
        for wave in waves {
            total += wave.flowScore.value ?? 0
        }
        return total / waves.count
    }
    func getAvgSpeed(waves: List<Wave>) -> Int {
        var total = 0
        for wave in waves {
            total += wave.speedScore.value ?? 0
        }
        return total / waves.count
    }
    func getAvgVariety(waves: List<Wave>) -> Int {
        var total = 0
        for wave in waves {
            total += wave.varietyScore.value ?? 0
        }
        return total / waves.count
    }
    
    func getAvgDifficulty(waves: List<Wave>) -> Int {
        var total = 0
        for wave in waves {
            total += wave.difficultyScore.value ?? 0
        }
        return total / waves.count
    }

    func getScoreAvg(session: Session) -> Double {
        let total = getAvgPower(waves: session.waveData) + getAvgDifficulty(waves: session.waveData) + getAvgVariety(waves: session.waveData) + getAvgSpeed(waves: session.waveData) + getAvgFlow(waves: session.waveData)
        
        return (Double(total) / Double(session.waveData.count)).rounded(toPlaces: 1)
    }
    
    func getWaveAvgScore(session: Session) -> [Double] {
        
        var data = [Double]()
        
        for wave in session.waveData {
            let total = wave.powerScore.value! + wave.difficultyScore.value! + wave.flowScore.value! + wave.speedScore.value! + wave.varietyScore.value!
            let avg = (Double(total) / 5.0).rounded(toPlaces: 1)
            data.append(avg)
        }
        return data
    }
    
    
    private func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    private func randomFloat(_ firstNum: CGFloat, _ secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func generateWave(syncTime: Date) -> Wave {
        let calendar = Calendar.current
        let temp = randomInt(min: 2, max: 12)
        
        guard let timestamp_wave = calendar.date(byAdding: .minute, value: (-5 - temp), to: syncTime) else { return Wave() }
        let height = Double(randomFloat(1.0, 5.0))
        let distance = Double(randomFloat(5.0, 30.0))
        let rideTimeSeconds = randomInt(min: 0, max: 60)
        let cutbacks = List<Cutback>()
        let numCutback = randomInt(min: 1, max: 3)
        
        let power = randomInt(min: 0, max: 10)
        let flow = randomInt(min: 0, max: 10)
        let speed = randomInt(min: 0, max: 10)
        let variety = randomInt(min: 0, max: 10)
        let difficulty = randomInt(min: 0, max: 10)
        
        for _ in 1...numCutback {
            cutbacks.append(generateCutback())
        }
        
        return Wave(timestamp: timestamp_wave.timeIntervalSince1970, height: height, distance: distance, rideTimeMinute: 0, rideTimeSecond: rideTimeSeconds, cutbacks: cutbacks, power: power, flow: flow, speed: speed, variety: variety, difficulty: difficulty)
    }
    
    func generateCutback() -> Cutback {
        let force = Double(randomFloat(0.0, 2.0))
        let angle = Double(randomFloat(45.0, 120.0))
        return Cutback(force: force, angle: angle)
    }
    
    func getSessionAvgDistance(session: Session) -> Double {
        
        let count = Double(session.waveData.count)
        var totalDistance = 0.0
        
        for wave in session.waveData {
            totalDistance += wave.distance
        }
        
        return totalDistance / count
    }
    
    func getSessionHardestCutback(session: Session) -> Double {
        var hardestCB = 0.0
        for wave in session.waveData {
            for cb in wave.cutbacks {
                if cb.force > hardestCB {
                    hardestCB = cb.force
                }
            }
        }
        
        return hardestCB
    }
    
    func getTotalTime(session: Session) -> (hour: Int, minute: Int) {
        
        var tSeconds = 0
        
        for wave in session.waveData {
            tSeconds += wave.rideTimeSecond.value ?? 0
        }
        
        var tMinute = tSeconds / 60
        var tHour = 0
        
        if tMinute > 0 {
            tHour = tMinute / 60
        }
        
        if tHour > 0 {
            tMinute %= 60
        }
        else {
            tHour = 1
        }
        
        return (tHour, tMinute)
    }
    
    func getScoreArray(session: Session) -> [Int] {
        let power = session.powerScore.value ?? 0
        let flow = session.flowScore.value ?? 0
        let speed = session.speedScore.value ?? 0
        let variety = session.varietyScore.value ?? 0
        let difficulty = session.difficultyScore.value ?? 0
        return [power, flow, speed, variety, difficulty]
    }
    
    func getWeekday(session: Session) -> String {
        let date = Date(timeIntervalSince1970: session.syncTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return "\(dateFormatter.string(from: date))"
    }
    
    func getDate(session: Session) -> String {
        let date = Date(timeIntervalSince1970: session.syncTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return "\(dateFormatter.string(from: date))"
    }
    
    func getTimeSync(session: Session) -> String {
        let date = Date(timeIntervalSince1970: session.syncTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return "\(dateFormatter.string(from: date))"
    }
    
    func getDistances(session: Session) -> [Double] {
        
        var dist = [Double]()
        
        for wave in session.waveData {
            dist.append(wave.distance)
        }
        
        return dist
    }
    
    func getCutbackForces(session: Session) -> [Double] {
        var forces = [Double]()
        
        for wave in session.waveData {
            for cutback in wave.cutbacks {
                forces.append(cutback.force)
            }
        }
        
        return forces
    }
    
    func getAvgCutbackForce(session: Session) -> Double {
        let forces = getCutbackForces(session: session)
        var total = 0.0
        
        for force in forces {
            total += force 
        }
        
        return (total / Double(forces.count)).rounded(toPlaces: 1)
    }
    
    func getTimePerWaves(session: Session) -> [Double] {
        var data = [Double]()
        for wave in session.waveData {
            data.append(Double(wave.rideTimeSecond.value!))
        }
        return data
    }
    
    func getAvgSecondsPerWaves(session: Session) -> Double {
        var data = 0.0
        for wave in session.waveData {
            data += Double(wave.rideTimeSecond.value!)
        }
        return (data / Double(session.waveData.count)).rounded(toPlaces: 1)
    }
    
}
