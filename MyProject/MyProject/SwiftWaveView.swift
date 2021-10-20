//
//  SwiftWaveView.swift
//  MyProject
//
//  Created by liuyalu on 2021/9/30.
//

import UIKit

class SwiftWaveView: UIView {
    enum mCurveType : NSInteger {
        case mCurveTypeSin = 0
        case mCurveTypeCos = 1
    }
    var _link:CADisplayLink?
    var _offset:CGFloat = 0
    var _waveHeight:CGFloat?
    var _width:CGFloat?
    var _height:CGFloat?
    var _waveLayer:CAShapeLayer?
    var _maskLayer:CAShapeLayer?
    // 波浪移动速度
    public var waveSpeed: CGFloat = 0.1 //水纹的速度
    public var percent:CGFloat? {//水深占据整个view的比例
        didSet{
            assert(percent! >= 0.0 && percent! <= 1, "水波纹完成比例不得小于0或大于1!");
            _waveHeight = _height! * (1 - percent!)
        }
    }
    public var peak:CGFloat? //水纹的纵向高度
    public var waveColor:UIColor?
    public var maskColor:UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _width = frame.size.width
        _height = frame.self.height
        setDefaultProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        print("layoutSubviews");
        _width = frame.size.width
        _height = frame.size.height
        layoutWaveLayers()
    }
    
    // MARK: 添加水波纹Layer
    func layoutWaveLayers() {
        print("layoutWaveLayers");
        if _waveLayer == nil {
            _waveLayer = CAShapeLayer()
            layer.addSublayer(_waveLayer!)
        }
        if _maskLayer == nil {
            _maskLayer = CAShapeLayer()
            layer.addSublayer(_maskLayer!)
        }

    }
    
    
    @objc func startWave() {
        if _link == nil {
            _link = CADisplayLink.init(target: self, selector: #selector(displayLinkAction))
            _link?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        }
    }
    
    
    func stopWave() {
        _link?.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        _link?.invalidate()
        _link = nil
    }
    
    // MARK: 定时事件
    
    @objc func displayLinkAction() {
            _offset += waveSpeed
        let sinPath:UIBezierPath = pathWithCurveType(curveType: mCurveType.mCurveTypeSin)
        _waveLayer?.fillColor = waveColor?.cgColor
        _waveLayer?.path = sinPath.cgPath
        
        let cosPath:UIBezierPath = pathWithCurveType(curveType: mCurveType.mCurveTypeCos)
       
        _maskLayer?.fillColor = maskColor?.cgColor
        _maskLayer?.path = cosPath.cgPath
    }
    

    
    //MARK: 通过曲线类型获得对应的曲线路径
    func pathWithCurveType(curveType:mCurveType) -> UIBezierPath {
        let startY:CGFloat = _waveHeight! + _offset
        let mutablePath:UIBezierPath = UIBezierPath()
        mutablePath.move(to: CGPoint.init(x: 0, y: startY))
        var y : CGFloat
        
        var x = CGFloat(0)
        while x <= bounds.size.width {
            // y=Asin（ωx+φ）+h
            switch curveType {
            case .mCurveTypeSin:
                y =  _waveHeight! + peak! * sin(x * 2.0 * CGFloat.pi/_width! + _offset)
            case .mCurveTypeCos:
                y =  _waveHeight! + peak! * cos(x * 2.0 * CGFloat.pi/_width! + _offset)
            }
            mutablePath.addLine(to: CGPoint.init(x: CGFloat(x), y: CGFloat(y)))
            x += 0.1
        }
        mutablePath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        mutablePath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        mutablePath.close();
        return mutablePath
    }
    func setDefaultProperty() {
        //设置默认值
        _waveHeight = self.bounds.size.height/2;
        peak = self.bounds.size.height/5;
        waveSpeed = 0.1;

    }
    
    
}
