//
//  ViewController.swift
//  hangge_2278
//
//  Created by hangge on 2019/1/21.
//  Copyright © 2019年 hangge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建文本标签
        let label = UILabel()
        label.text = "正在加载中......"
        label.textColor = .white
        label.textAlignment = .center
        label.frame = CGRect(x: (screenWidth() * 0.5 - 100), y: 0, width: 200, height: 50)
        
        // 创建波浪视图
        let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: screenWidth(),
                                              height: 130))
        // 波浪动画回调
        waveView.closure = {centerY in
            // 同步更新文本标签的y坐标
            label.frame.origin.y = waveView.frame.height + centerY - 55
        }
        
        // 添加两个视图
        self.view.addSubview(waveView)
        self.view.addSubview(label)
        
        // 开始播放波浪动画
        waveView.startWave()
    }
    
    // 返回当前屏幕宽度
    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
}

