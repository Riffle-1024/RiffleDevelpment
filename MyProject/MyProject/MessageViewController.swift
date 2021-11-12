//
//  MessageViewController.swift
//  MyProject
//
//  Created by liuyalu on 2021/9/28.
//

import UIKit

class MessageViewController: RIffleBaseViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style:UITableViewCell.CellStyle.value1, reuseIdentifier: "CellID")
        cell.detailTextLabel?.text = String(format: "第%ld组，第%ld行", indexPath.section,indexPath.row)
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
  
    var dataModel:RiffleBaseModel?
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.creatTableView()
//        tableView?.reloadData()
//        creatObjcHeadView()
//        creatHeadView()
//        creatPathHeadView()
        self.showXibView()
    }
    /*
     headView.firstWaveColor=kHexColor(@"398AE5", 1.0);
     headView.secondWaveColor=kHexColor(@"398AE5", 0.5);
     headView.percent = 0.35;
     headView.speed = 0.05;
     headView.peak = 8;
     headView.period=2;
 //    [self.view addSubview:headView];
     [headView startWave];*/
    
    
    //[[[NSBundle mainBundle] loadNibNamed:@"XibShowView" owner:self options:nil] lastObject];
    func showXibView() {
        let xibView:XibShowView = Bundle.main.loadNibNamed("XibShowView", owner: self, options: nil)?.last as! XibShowView
        self.view.addSubview(xibView)
    }
    
    func creatHeadView() {
        let headView = SwiftHeadView.init(frame: CGRect(x: 50, y: 120, width: 280, height: 280))
        headView.firstWaveColor = hexColor(str: "398AE5", alpha: 1.0)
        headView.secondWaveColor = hexColor(str: "398AE5", alpha: 0.5)
        headView.percent = 0.35
        headView.speed = 0.05
        headView.peak = 8
        headView.period = 2
        self.view.addSubview(headView)
        headView.startWave()
        
    }
    
    func creatPathHeadView() {
        let headView = SwiftWaveView.init(frame: CGRect(x: 50, y: 120, width: 280, height: 280))
        headView.waveColor = hexColor(str: "398AE5", alpha: 1.0)
        headView.maskColor = hexColor(str: "398AE5", alpha: 0.5)
        headView.percent = 0.35
        headView.waveSpeed = 0.05
        headView.peak = 8
        self.view.addSubview(headView)
        headView.startWave()
        
    }
    
    
    func creatObjcHeadView() {
        let headView = HeadView.init(frame: CGRect(x: 50, y: 120, width: 280, height: 280))
        headView.firstWaveColor = hexColor(str: "398AE5", alpha: 1.0)
        headView.secondWaveColor = hexColor(str: "398AE5", alpha: 0.5)
        headView.percent = 0.35
        headView.speed = 0.05
        headView.peak = 8
        headView.period = 2
        self.view.addSubview(headView)
        headView.startWave()
    }
    
@objc func creatTableView()
    {
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 120, width: ScreenWidth, height: ScreenHeight - 120), style: UITableView.Style.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }


}
