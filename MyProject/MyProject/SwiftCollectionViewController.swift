//
//  SwiftCollectionViewController.swift
//  MyProject
//
//  Created by liuyalu on 2021/11/3.
//

import UIKit


class SwiftCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
 
 

    
    
    var colltionView:UICollectionView?
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height//获取屏幕高
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatCollectionView()
        
    }
    
    
    
    func creatCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        colltionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: height), collectionViewLayout: layout)
        //注册一个cell
//        colltionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        colltionView?.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        colltionView?.delegate = self
        colltionView?.dataSource = self
        colltionView?.backgroundColor = UIColor.white
        //设置每一个cell的宽高
        layout.itemSize = CGSize(width: (width-30)/3, height: 200)
        self.view.addSubview(colltionView!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CollectionViewCell
        var title = String()
        title = String.init(format: "第%d组，第%d个", arguments: [indexPath.section,indexPath.row])
        cell.mTitleLabel?.text = title
        cell.mDetailLabel?.text = "哈哈哈哈哈哈哈"
        
        return cell
    }
    
}
