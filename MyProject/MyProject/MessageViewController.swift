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
        self.creatTableView()
        tableView?.reloadData()
        
    }
    
@objc func creatTableView()
    {
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), style: UITableView.Style.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        
        
        
    }


}
