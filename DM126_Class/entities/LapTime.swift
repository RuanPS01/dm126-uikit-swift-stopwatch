//
//  LapTime.swift
//  DM126_Class
//
//  Created by user270231 on 10/26/24.
//
import Foundation

struct LapTime {
    var timeInMiliseconds: Int;
    var createdAt: Date;
    
    func formattedTime() -> String {
        let minutes = (timeInMiliseconds / 60000) % 60
        let seconds = (timeInMiliseconds / 1000) % 60
        let milliseconds = (timeInMiliseconds % 1000) / 100
        return String(format: "%02d:%02d:%d", minutes, seconds, milliseconds)
    }
}
