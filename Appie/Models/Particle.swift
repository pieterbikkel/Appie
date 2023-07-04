//
//  Particle.swift
//  Appie
//
//  Created by Pieter Bikkel on 01/07/2023.
//

import Foundation
import SwiftUI

/// Particle Model
struct Particle: Identifiable {
    var id: UUID = .init()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    /// Optional
    var opacity: CGFloat = 1
    
    /// Reset's All Properties
    mutating func reset() {
        randomX = 0
        randomY = 0
        scale = 1
        opacity = 1
    }
}
