//
//  Particle.swift
//  CoMotion
//
//  Created by Vina Melody on 6/4/22.
//

import Foundation

struct Particle: Hashable {
    let x: Double
    let y: Double
    let creationDate = Date.now.timeIntervalSinceReferenceDate
    let hue: Double
    
}
