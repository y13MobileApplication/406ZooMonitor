//
//  FirstViewController.swift
//  UIKit015
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    var msg:String = "::"
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        
//-----------------テスト---------
        
        func getJSON() {
            let URL = NSURL(string: "http://editors.ascii.jp/c-minamoto/swift/swift-5-data.json")
            let req = NSURLRequest(URL: URL!)
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: configuration,delegate: nil,delegateQueue: NSOperationQueue.mainQueue())
            print("hoge500")
            let task = session.dataTaskWithRequest(req,completionHandler: {
                (data,request,error) -> Void in
                do{
                    print("start")
                    let myString = NSString(data:data!, encoding: NSUTF8StringEncoding) as! String
                    print(myString)
                    
                    let jsonDic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                    // まずキー"data"で、配列データを取り出す
                    if let arrayData = jsonDic["data"] as? NSArray {
                        // 配列のデータを１つずつ辞書データを取り出す
                        for datN in 0..<arrayData.count {
                            if let data = arrayData[datN] as? NSDictionary {
                               //  キー"name"の文字データを取り出して、msg変数に追加
                                print(data["name"])
                                if let nameDat = data["name"] as? String{
                                    print(nameDat)
                                    msg += "名前=\(nameDat):"
                                    
                                }
                                // キー"price"の数値データを取り出して、msg変数に追加
                                print(data["price"])
                                if let price = data["price"] as? Int{
                                    print(price)
                                    msg += "価格=\(price)\n"
                                    
                                }
                                
                            }
                        }
                         print(msg)

                   }
                    print("----hoge1---")
                    print(msg)
                    
                } catch{
                      print("----hoge200---")
                    print(msg)
                }
                print("----hoge1.5---")
                print(msg)
                
            })
            print("----hoge1.8---")
            print(msg)
            

            task.resume()
            print("----hoge3---")
            print(msg)
                     }
        
//-----------------テスト---------
        //log表示ブロック
       // let str = "hoge"
     let message = msg
                getJSON()
        print("----hoge2---")
         print(message)
 

        let label = UILabel(frame: CGRectMake(0, 0, 250, 20));
        label.center = CGPointMake(160, 284);//表示位置
        label.textAlignment = NSTextAlignment.Center//整列
     // label.text = str;
        label.text = message;
        self.view.addSubview(label);
        //
        // 入室者詳細ボタンを生成する.
        let infoButton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
        infoButton.backgroundColor = UIColor.whiteColor();
        infoButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        infoButton.layer.masksToBounds = true
        infoButton.setTitle("More Infomation", forState: .Normal)
        infoButton.layer.cornerRadius = 20.0
        infoButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-100)
        infoButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンを生成する.
        let logButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        logButton.backgroundColor = UIColor.whiteColor();
        logButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        logButton.layer.masksToBounds = true
        logButton.setTitle("log", forState: .Normal)
        logButton.layer.cornerRadius = 20.0
        logButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height-50)
        logButton.addTarget(self, action: "onClickMyButton2:", forControlEvents: .TouchUpInside)

        // ボタンを追加する.
        self.view.addSubview(infoButton);
        self.view.addSubview(logButton);
                
                
    }
    
    /*
    ボタンイベント.
    */
    internal func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = SecondViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
    internal func onClickMyButton2(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = FirstLogViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        self.presentViewController(mySecondViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}