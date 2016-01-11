//
//  FirstViewController.swift
//  UIKit015
//

import UIKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //メッセージを格納する変数
        var msg:String = "現在自習室には"
        var log:String = ""
        //現在の人数を計算する変数
        var calcu:Int = 0
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        
//-----------------テスト---------
        
        func getJSON() {//http://www.cc.u-ryukyu.ac.jp/~e135740/test.json
            // let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/test.json")
           // let URL = NSURL(string: "http://10.0.3.187/log.json")
            guard let URL:NSURL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/test.json") else{
                return
            }
            let req:NSURLRequest = NSURLRequest(URL: URL,cachePolicy: .ReloadIgnoringLocalCacheData,
                timeoutInterval: 15.0)
            
            //URLを格納
            let configuration:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
            //通信の初期化
            let session:NSURLSession = NSURLSession(configuration: configuration,delegate: nil,delegateQueue: NSOperationQueue.mainQueue())
            //通信するためにインスタンス化
            
            //taskの中は後から処理されるので、VMからのデータを扱う際はこの中で行うと良い？
            let task:NSURLSessionDataTask = session.dataTaskWithRequest(req,completionHandler: {
                (data,request,error) -> Void in
                //エラーでなければ、do{}を実行する。エラーの場合はcatch{}を実行する
                do{
                    print("なぜ")
                    //URL先のデータを格納
                    let myString:NSString = NSString(data:data!, encoding: NSUTF8StringEncoding) as! String
                    //データが格納されているかを確認
                    print(myString)
                    
                     print("ほげ-2")
                    //jsonデータ解析
                    let jsonDic:NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                        print("ほげ-1")
                        print(msg)
                    if let arrayData:NSArray = jsonDic["log"] as? NSArray {
                    // 配列のデータを１つずつ辞書データを取り出す
                         print("ほげ1")
                        //  let mem_count = arrayData[0]["Count"]
                       
                    for datN in 0..<5 {
                        if let data:NSDictionary = arrayData[datN] as? NSDictionary {
                            if datN == 0 {
                                if let dat:String = data["day"] as? String{
                                    log += "log\n\(dat):"
                                }
                                if let cal:Int = data["Count"] as? Int{
                                    log += "\(cal)人\n"
                                    msg = "現在\(cal)人います"
                                }
                            }
                            else{
                                if let dat:String = data["day"] as? String{
                                    log += "\(dat):"
                                }
                                if let cal:Int = data["Count"] as? Int{
                                    log += "\(cal)人\n"
                                    
                                }
                            }
                        }
                    }
                    print(msg)
                    print(log)
                    }
                    
                        print(msg)
                    //UITextFieldを表示。ここで呼び出すとjsonファイルが反映される
                        textbox(self.view.bounds.height - self.view.bounds.height*6/10)
                        logbox(self.view.bounds.height - self.view.bounds.height*2/10)
                } catch{
                      print("Proccess is interrupted by error")
                }
            })//ここまでTask
            task.resume()
        }
        
//-----------------テスト---------
        //log表示ブロック
        getJSON()
 
        func textbox(tate: CGFloat){
            // let label = UILabel(frame: CGRectMake(0, 0, 250, 120));
            let label:UITextView = UITextView(frame: CGRectMake(0, 0, 150, 80));
            //label.center = CGPointMake(160, 284);//表示位置
            label.center = CGPointMake(160,tate);
            
            label.textAlignment = NSTextAlignment.Center //中央

            //label.textAlignment = NSTextAlignment.Left //左詰め
            // テキストを編集不可にする.
            label.editable = false
            
            label.text = msg;
            self.view.addSubview(label);
        }
        
        func logbox(tate: CGFloat){
            // let label = UILabel(frame: CGRectMake(0, 0, 250, 120));
            let label:UITextView = UITextView(frame: CGRectMake(0, 0, 150,80));
            //label.center = CGPointMake(160, 284);//表示位置
            label.center = CGPointMake(160,tate);
            // 角に丸みをつける.
            label.layer.masksToBounds = true
            // 丸みのサイズを設定する.
            label.layer.cornerRadius = 20.0
            // 枠線の太さを設定する.
            label.layer.borderWidth = 1
            // 枠線の色を設定する.
            label.layer.borderColor = UIColor.blackColor().CGColor
            label.textAlignment = NSTextAlignment.Center //中央
            //label.textAlignment = NSTextAlignment.Left //左詰め
            // テキストを編集不可にする.
            label.editable = false
            
            label.text = log;
            self.view.addSubview(label);
        }

        //
        // 入室者詳細ボタンを生成する.
        let infoButton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
        infoButton.backgroundColor = UIColor.whiteColor();
        infoButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        infoButton.layer.masksToBounds = true
        infoButton.setTitle("More Infomation", forState: .Normal)
        infoButton.layer.cornerRadius = 20.0
        infoButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height - self.view.bounds.height*3/10)
        infoButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ボタンを生成する.
        let logButton: UIButton = UIButton(frame: CGRectMake(0,0,150,50))
        logButton.backgroundColor = UIColor.whiteColor();
        logButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        logButton.layer.masksToBounds = true
        logButton.setTitle("detail_log", forState: .Normal)
        logButton.layer.cornerRadius = 20.0
        logButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height - self.view.bounds.height/10)
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