//
//  CirleProgressWaveView.swift
//  ProgressCirleDemo
//
//  Created by SongLan on 2017/3/8.
//  Copyright © 2017年 Asong. All rights reserved.
//

import UIKit

class CirleProgressWaveView: UIView {
    lazy var waveDisplaylink = CADisplayLink()
    lazy var inCirleLayer = CAShapeLayer()
    lazy var firstWaveLayer = CAShapeLayer()
    lazy var secondWaveLayer = CAShapeLayer()
    var rect : CGRect?
    var waveSpeed : CGFloat = 0.05
    var waveSpeedH : CGFloat = 0.05
    var waveH : CGFloat = 0.01
    private var waveA: CGFloat = 0
    private var waveW: CGFloat = 0
    private var offsetX: CGFloat = 0
    private var b : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        rect = frame
        initData()
        self.configUI(frame: frame)
    }
    //MARK: - 数据的初始化
    private func initData(){
        waveSpeedH = 0.2
        waveSpeed = 0.15
        waveA = 1.25
        // 设置周期 :( 2* M_PI)/waveW = bounds.size.width 。因为涉及的是layer，所以只谈bounds,不说frame
        waveW = 2 * CGFloat(M_PI) / (bounds.size.width / 3)
        b  = (rect?.size.height)!
    }

    func configUI(frame : CGRect){
        //圆
        let path = UIBezierPath(roundedRect: frame, cornerRadius: frame.size.width/2)
        inCirleLayer.strokeColor = UIColor.lightGray.cgColor
        inCirleLayer.fillColor = UIColor.clear.cgColor
        inCirleLayer.path = path.cgPath
        inCirleLayer.lineWidth = 2
        inCirleLayer.lineCap = kCALineCapRound
        self.layer.addSublayer(inCirleLayer)
        
        
        //设置水波纹
        firstWaveLayer.fillColor = UIColor.init(colorLiteralRed: 69/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5).cgColor
        secondWaveLayer.fillColor = UIColor.init(colorLiteralRed: 69/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5).cgColor
        self.layer.addSublayer(firstWaveLayer)
        self.layer.addSublayer(secondWaveLayer)
        waveDisplaylink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        waveDisplaylink.add(to: RunLoop.current, forMode: .commonModes)
    }

    func getCurrentWave(){
        if (b >= (rect?.size.height)!/4) {
            b = b - waveSpeedH
        }
        offsetX += waveSpeed
        setCurrentStatusWavePath()
    }
    //MARK: - 关键部分
    private func setCurrentStatusWavePath() {
        // 创建一个路径
        let firstPath = CGMutablePath()
        var firstY = bounds.size.width/2
        firstPath.move(to: CGPoint(x: 0, y: b))
        for i in 0...Int(bounds.size.width) {
            firstY = waveA * sin(waveW * CGFloat(i) + offsetX) + b
            firstPath.addLine(to: CGPoint(x: CGFloat(i), y: firstY))
        }
        
        firstPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        firstPath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        firstPath.closeSubpath()
        firstWaveLayer.path = firstPath
        
        // 创建一个路径
        let secondPath = CGMutablePath()
        var secondY = bounds.size.width/2
        secondPath.move(to: CGPoint(x: 0, y: b))
        
        for i in 0...Int(bounds.size.width) {
            secondY = waveA * sin(waveW * CGFloat(i) + offsetX - bounds.size.width/2 ) + b
            secondPath.addLine(to: CGPoint(x: CGFloat(i), y: secondY))
        }
        
        secondPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        secondPath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        secondPath.closeSubpath()
        secondWaveLayer.path = secondPath
    }

    
    deinit {
        waveDisplaylink.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
