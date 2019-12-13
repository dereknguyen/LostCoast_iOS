//
//  Enums.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 8/19/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import Foundation

enum TextFieldType: String {
    case firstName = "First name"
    case lastName = "Last name"
    case userName = "Username"
    case email = "Email"
    case password = "Password"
    case retype = "Retype password"
}

enum ProcessErrorType: String {
    case signUp = "Sign Up"
    case aboutYou = "Empty Field"
    case logIn = "Log In"
}

enum ProfileField: String {
    case username
}

enum GenderType: String {
    case male
    case female
    case neither
}

enum StatType: String {
    case wavesCaught = "Caught"
    case avgDistance = "Avg. Distance"
    case hardCutBack = "Hardest Cutback"
    case totalSessionTime = "Total Session Time"
    case sessionScore = "Session Score"
}

enum StatUnit: String {
    case waves = "Waves"
    case feet = "Feet"
    case pounds = "LBs."
    case hour = "Hours"
    case minute = "Minutes"
}

enum TrackingProgress: String {
    case personalBest = "Personal Best"
    case weeklyGoal = "Weekly Goal"
}
