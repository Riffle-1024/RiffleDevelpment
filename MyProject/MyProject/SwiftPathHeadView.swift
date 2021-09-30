//
//  SwiftPathHeadView.swift
//  MyProject
//
//  Created by liuyalu on 2021/9/30.
//

import UIKit

class SwiftPathHeadView: UIView {
    enum mCurveType : NSInteger {
        case mCurveTypeSin = 0
        case mCurveTypeCos = 1
    }
    var _link:CADisplayLink?
    var _changePercent:CGFloat?
    var _offset:CGFloat = 0
    var _waveHeight:CGFloat?
    var _width:CGFloat?
    var _height:CGFloat?
    var _firstWaveLayer:CAShapeLayer?
    var _secondWaveLayer:CAShapeLayer?
    // 波浪宽度系数a
    var waveRate: CGFloat = 0.01
    // 波浪移动速度
    var waveSpeed: CGFloat = 0.1
    // 波浪位置（默认是在下方）
    var waveOnBottom = true
    public var percent:CGFloat? {/**<完成比例 DEFAULT:0.0*/
        didSet{
            assert(percent! >= 0.0 && percent! <= 1, "水波纹完成比例不得小于0或大于1!");
            _changePercent = percent
            _waveHeight = _height! * (1 - percent!)
        }
    }
    @objc func setPercent(newPercent:CGFloat) {
        percent = newPercent
    }
    public var speed:CGFloat? /**<水波纹横向移动的速度 DEFAULT:0.1*/
    @objc func setSpeed(newPercent:CGFloat) {
        speed = newPercent
    }
    public var peak:CGFloat? /**<峰值:水波纹的纵向高度 DEFAULT:6.0*/
    @objc func setPeak(newPercent:CGFloat) {
        peak = newPercent
    }
    public var period:CGFloat?/**<周期数:一定宽度内水波纹的周期个数 DEFAULT:1.2*/
    @objc func setPeriod(newPercent:CGFloat) {
        period = newPercent
    }
    public var firstWaveColor:UIColor?
    @objc func setFirstWaveColor(newPercent:UIColor) {
        firstWaveColor = newPercent
    }
    public var secondWaveColor:UIColor?
    @objc func setSecondWaveColor(newPercent:UIColor) {
        secondWaveColor = newPercent
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _width = frame.size.width
        _height = frame.self.height
        print("super.init(frame: frame)");
        setDefaultProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        _width = frame.size.width
        _height = frame.self.height
        setDefaultProperty()
    }
    
    
    override func layoutSubviews() {
        print("layoutSubviews");
        _width = frame.size.width
        _height = frame.size.height
//        layer.cornerRadius = _width! * 0.5
        layoutWaveLayers()
    }
        // MARK: 添加水波纹Layer
    
    
    func layoutWaveLayers() {
        print("layoutWaveLayers");
        if firstWaveColor == nil {
            firstWaveColor = firstColor
        }
        if secondWaveColor == nil {
            secondWaveColor = secondColor
        }
        if _firstWaveLayer == nil {
            _firstWaveLayer = CAShapeLayer()
            layer.addSublayer(_firstWaveLayer!)
        }
        if _secondWaveLayer == nil {
            _secondWaveLayer = CAShapeLayer()
            layer.addSublayer(_secondWaveLayer!)
        }
        _firstWaveLayer?.fillColor = firstWaveColor?.cgColor
        _secondWaveLayer?.fillColor = secondWaveColor?.cgColor
    }
    
    
    @objc func startWave() {
        print("startWave");
        if _link == nil {
            _link = CADisplayLink.init(target: TimerTarget.init(self), selector: #selector(displayLinkAction))
            _link?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        }
    }
    
    
    func stopWave() {
        print("stopWave");
        _changePercent = 0.0
        _link?.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        _link?.invalidate()
        _link = nil
    }
    
    // MARK: 定时事件
    
    @objc func displayLinkAction() {
        print("displayLinkAction");
//        _offset = speed
//        percentChange()
//        if _offset <= peak! {
            _offset += waveSpeed
//        }else{
//            _offset = 0
//        }
    
        
        let sinPath:UIBezierPath = pathWithCurveType(curveType: mCurveType.mCurveTypeSin)
        _firstWaveLayer?.path = sinPath.cgPath
//        let sinPath = HeadView.path(withCurveType: 0, waveHeight: _waveHeight!, changePercent: _changePercent!, height: _height!, period: period!, width: _width!, peak: peak!, offSet: _offset!,layer: _firstWaveLayer!)
       
        
        
        let cosPath:UIBezierPath = pathWithCurveType(curveType: mCurveType.mCurveTypeCos)

        _secondWaveLayer?.path = cosPath.cgPath
        
//        let cosPath = HeadView.path(withCurveType: 1, waveHeight: _waveHeight!, changePercent: _changePercent!, height: _height!, period: period!, width: _width!, peak: peak!, offSet: _offset!,layer: _secondWaveLayer!)
    
        
    }
    
    //MARK: 通过改变percent的值实现动画效果
    func percentChange() {
        print("percentChange");
        _changePercent! += 0.005
        if _changePercent! > percent! {
            //当定时器改变的值(_changePercent)大于设定的值(_percent)时停止变化【注意:不可以使用等于号】
            _changePercent! -= 0.05
        }
    }
    
    //MARK: 通过曲线类型获得对应的曲线路径
    func pathWithCurveType(curveType:mCurveType) -> UIBezierPath {
        print("pathWithCurveType:curveType");
//        _waveHeight! = (1 - _changePercent!) * _height!
        let startY:CGFloat = _waveHeight! + _offset
        let mutablePath:UIBezierPath = UIBezierPath()
        mutablePath.move(to: CGPoint.init(x: 0, y: startY))
        var y : CGFloat
        
        var x = CGFloat(0)
        while x <= bounds.size.width {
            // y=Asin（ωx+φ）+h
            switch curveType {
            case .mCurveTypeSin:
                y =  _waveHeight! + peak! * sin(x * period! * CGFloat.pi/_width! + _offset)
            case .mCurveTypeCos:
                y =  _waveHeight! + peak! * cos(x * period! * CGFloat.pi/_width! + _offset)
            }
            mutablePath.addLine(to: CGPoint.init(x: CGFloat(x), y: CGFloat(y)))
            x += 0.1
        }
        mutablePath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        mutablePath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        
//        for x in (0..<ceilWidth){
//            switch curveType {
//            case .mCurveTypeSin:
//               y =  peak! *  sin(period! * CGFloat.pi / _width! * CGFloat(x) + _offset!) + _waveHeight!
//            case .mCurveTypeCos:
//                y = peak! * cos(period! * CGFloat.pi / _width! * CGFloat(x) + _offset!) + _waveHeight!
//            }
//            mutablePath.addLine(to: CGPoint(x: CGFloat(x), y: CGFloat(y)))
//        }

//        mutablePath.addLine(to: CGPoint(x: _width!, y: _height!))
//        mutablePath.addLine(to: CGPoint(x: 0, y: _height!))
        mutablePath.close();
        return mutablePath
    }
    //MARK: 通过曲线类型获得对应的曲线路径
//    func pathWithCurveType(curveType:mCurveType) -> UIBezierPath {
//        print("pathWithCurveType:curveType");
//        _waveHeight! = (1 - _changePercent!) * _height!
//        let mutablePath:UIBezierPath = UIBezierPath()
//        mutablePath.move(to: CGPoint.init(x: 0, y: _waveHeight!))
//        var y : CGFloat
//        let ceilWidth:NSInteger = NSInteger(ceil(_width!))
//        for x in (0..<ceilWidth){
//            switch curveType {
//            case .mCurveTypeSin:
//               y =  peak! *  sin(period! * CGFloat.pi / _width! * CGFloat(x) + _offset!) + _waveHeight!
//            case .mCurveTypeCos:
//                y = peak! * cos(period! * CGFloat.pi / _width! * CGFloat(x) + _offset!) + _waveHeight!
//            }
//            mutablePath.addLine(to: CGPoint.init(x: CGFloat(x), y: CGFloat(y)))
//        }
//
//        mutablePath.addLine(to: CGPoint.init(x: _width!, y: _height!))
//        mutablePath.addLine(to: CGPoint.init(x: 0, y: _height!))
//        mutablePath.close()
//
//        return mutablePath
//    }
    
    func setDefaultProperty() {
        print("setDefaultProperty");
//        layer.cornerRadius = _width! * 0.5
//        clipsToBounds = true
        //设置默认值
        _waveHeight = _height
        speed = mWATERWAVE_DEFAULT_SPEED
        peak = mWATERWAVE_DEFAULT_PEAK
        period = mWATERWAVE_DEFAULT_PERIOD
    }
    
    
}
