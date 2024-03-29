//
//  LabelCounting.swift
//  CountLabelSample
//
//  Created by 엄기철 on 2019/09/25.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit

class LabelCounting: UILabel {
  
  let counterVelocity: Float = 3.0
  
  enum CounterAnimationType {
    case Liner
    case EaseIn
    case EaseOut
  }
  
  enum CounterType {
    case Int
    case Float
  }
  
  var startNumber: Float = 0.0
  var endNumber: Float = 0.0
  
  var progress: TimeInterval!
  var duration: TimeInterval!
  var lastUpdate: TimeInterval!
  
  var timer: Timer?
  
  var counterType: CounterType!
  var counterAnimationType: CounterAnimationType!
  
  var currentCounterValue : Float {
    if progress >= duration {
      return endNumber
    }
    
    let percentage = Float(progress / duration)
    let update = updateCounter(counterValue: percentage)
    
    return startNumber + (update * (endNumber - startNumber))
  }
  
  
  
  func count(fromValue: Float, toValue: Float, duration: TimeInterval,
             animationType: CounterAnimationType, counterType: CounterType) {
    
    self.startNumber = fromValue
    self.endNumber = toValue
    self.duration = duration
    self.counterType = counterType
    self.counterAnimationType = animationType
    self.progress = 0
    self.lastUpdate = Date.timeIntervalSinceReferenceDate
    
    invalidateTimer()
    
    if duration == 0 {
      updateText(value: toValue)
      return 
    }
    
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(LabelCounting.updateValue), userInfo: nil, repeats: true)
    
    
  }
  
  private func updateText(value: Float) {
    switch counterType! {
    case .Int:
      self.text = "\(Int(value))"
    case .Float:
      self.text = String(format: "%.2f", value)
    }
  }
  
  private func updateCounter(counterValue: Float) -> Float {
    switch counterAnimationType! {
    case .Liner:
      return counterValue
    case .EaseIn:
      return pow(counterValue, counterVelocity)
    case .EaseOut:
      return 1.0 -  powf(1.0 - counterValue, counterVelocity)
    
    }
  }
  
  @objc private func updateValue() {
    let now = Date.timeIntervalSinceReferenceDate
    progress = progress + (now - lastUpdate)
    lastUpdate = now
    
    if progress >= duration {
      invalidateTimer()
      progress = duration
    }
    
    updateText(value: currentCounterValue)
    
    
  
  }
  
  private func invalidateTimer() {
    timer?.invalidate()
    timer = nil
  }
}
