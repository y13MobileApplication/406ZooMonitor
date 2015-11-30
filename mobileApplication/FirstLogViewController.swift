//
//  FirstViewController.swift
//  UIKit015
//

import UIKit

class FirstLogViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        
        //log表示ブロック
        let str = "hoge"
        let label = UILabel(frame: CGRectMake(0, 0, 250, 20));
        label.center = CGPointMake(160, 284);//表示位置
        label.textAlignment = NSTextAlignment.Center//整列
        label.text = str;
        self.view.addSubview(label);

        // 入室者詳細ボタンを生成する.
        let morelogButton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
        morelogButton.backgroundColor = UIColor.whiteColor();
        morelogButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        morelogButton.layer.masksToBounds = true
        morelogButton.setTitle("More log", forState: .Normal)
        morelogButton.layer.cornerRadius = 20.0
        morelogButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-100)
        morelogButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)

        //戻るボタンを生成する.
        let backButton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
        backButton.backgroundColor = UIColor.whiteColor();
        backButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        backButton.layer.masksToBounds = true
        backButton.setTitle("Back", forState: .Normal)
        backButton.layer.cornerRadius = 20.0
        backButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        backButton.addTarget(self, action: "onClickMyButton2:", forControlEvents: .TouchUpInside)
        

        
        // ボタンを追加する.
        self.view.addSubview(morelogButton);
        self.view.addSubview(backButton);
    }
    
    /*
    ボタンイベント.
    */
    internal func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondlogViewController: UIViewController = SecondLogViewController()
        
        // アニメーションを設定する.
        mySecondlogViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondlogViewController, animated: true, completion: nil)
    }
    
    internal func onClickMyButton2(sender: UIButton){
        
        // 遷移するViewを定義.
        let myViewController: UIViewController = FirstViewController()
        
        // アニメーションを設定.
        myViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        // Viewの移動.
        self.presentViewController(myViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}