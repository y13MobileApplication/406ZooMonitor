//
//  SecondViewController.swift
//  UIKit015
//

import UIKit

class SecondLogViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景色を設定.
        self.view.backgroundColor = UIColor.whiteColor()
        
        //log表示ブロック
        let str = "hoge"
        let label = UILabel(frame: CGRectMake(0, 0, 250, 20));
        label.center = CGPointMake(160, 284);//表示位置
        label.textAlignment = NSTextAlignment.Center//整列
        label.text = str;
        self.view.addSubview(label);
        
        // ボタンを作成.
        let backButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        backButton.backgroundColor = UIColor.whiteColor();
        backButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        backButton.layer.masksToBounds = true
        backButton.setTitle("Back", forState: .Normal)
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        backButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton);
    }
    
    /*
    ボタンイベント.
    */
    internal func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義.
        let mybackViewController: UIViewController = FirstLogViewController()
        
        // アニメーションを設定.
        mybackViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        // Viewの移動.
        self.presentViewController(mybackViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}