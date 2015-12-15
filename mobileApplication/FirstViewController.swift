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
        //現在の人数を計算する変数
        var calcu:Int = 0
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        
//-----------------テスト---------
      /*  enum NSURLRequestCachePolicy : UInt {
            case UseProtocolCachePolicy
            case ReloadIgnoringLocalCacheData
            case ReloadIgnoringLocalAndRemoteCacheData
            static var ReloadIgnoringCacheData: NSURLRequestCachePolicy { get }
            case ReturnCacheDataElseLoad
            case ReturnCacheDataDontLoad
            case ReloadRevalidatingCacheData
        }*/
        
        func getJSON() {//http://www.cc.u-ryukyu.ac.jp/~e135740/test.json
            // let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/test.json")
           // let URL = NSURL(string: "http://10.0.3.187/log.json")
            guard let URL = NSURL(string: "http://10.0.3.187/log.json") else{
                return
            }
            let req = NSURLRequest(URL: URL,cachePolicy: .ReloadIgnoringLocalCacheData,
                timeoutInterval: 15.0)
            
            //URLを格納
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            //通信の初期化
            let session = NSURLSession(configuration: configuration,delegate: nil,delegateQueue: NSOperationQueue.mainQueue())
            //通信するためにインスタンス化
            
            //taskの中は後から処理されるので、VMからのデータを扱う際はこの中で行うと良い？
            let task = session.dataTaskWithRequest(req,completionHandler: {
                (data,request,error) -> Void in
                //エラーでなければ、do{}を実行する。エラーの場合はcatch{}を実行する
                do{
                    print("なぜ")
                    //URL先のデータを格納
                    let myString = NSString(data:data!, encoding: NSUTF8StringEncoding) as! String
                    //データが格納されているかを確認
                    print(myString)
                    
                     print("ほげ-2")
                    //jsonデータ解析
                    let jsonDic = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves) as! NSDictionary
                        print("ほげ-1")
                        print(msg)
                    if let arrayData = jsonDic["log"] as? NSArray {
                    // 配列のデータを１つずつ辞書データを取り出す
                         print("ほげ1")
                        //  let mem_count = arrayData[0]["Count"]
                       
                    for datN in 0..<arrayData.count {
                        if let data = arrayData[0] as? NSDictionary {
                           if let cal = data["Count"] as? Int{
                            print("ほげ2")
                        msg = "現在\(cal)人います"
                            }
                        }
                        }
                    print(msg)
                    }
                        print(msg)
                    //UITextFieldを表示。ここで呼び出すとjsonファイルが反映される
                        textbox(300)
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
            let label = UITextView(frame: CGRectMake(0, 0, 250, 120));
            //label.center = CGPointMake(160, 284);//表示位置
            label.center = CGPointMake(160,tate);
            
            label.textAlignment = NSTextAlignment.Center //中央

            //label.textAlignment = NSTextAlignment.Left //左詰め
            // テキストを編集不可にする.
            label.editable = false
            
        label.text = msg;
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