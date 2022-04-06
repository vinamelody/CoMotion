//
//  ContentView.swift
//  CoMotion
//
//  Created by Vina Melody on 6/4/22.
//

import SwiftUI

struct ContentView: View {
    @State private var particleSystem = ParticleSystem()
    @State private var motionHandler = MotionManager()
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                
                context.blendMode = .plusLighter
                particleSystem.center = UnitPoint(x: 0.5 + motionHandler.roll, y: 0.5 + motionHandler.pitch)
                
                for particle in particleSystem.particles {
                    var contextCopy = context
                    contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    
                    let xPos = particle.x * size.width
                    let yPos = particle.y * size.height
                    
                    contextCopy.opacity = 1 - (timelineDate - particle.creationDate)
                    contextCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0).onChanged({ drag in
                    // do not use UIScreen for other than iphone
                    particleSystem.center.x = drag.location.x / UIScreen.main.bounds.width
                    particleSystem.center.y = drag.location.y / UIScreen.main.bounds.height
                })
            )
            .ignoresSafeArea()
            .background(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
