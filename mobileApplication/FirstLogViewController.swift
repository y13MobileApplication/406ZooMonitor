//
//  FirstViewController.swift
//  UIKit015
//

import UIKit

class FirstLogViewController: UIViewController {
    private var renewalButton: UIBarButtonItem!
    private var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        //メッセージを格納する変数
        var msg:String = "\n"
        //入退室の記述の変数
        var calcu:String = ""
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "detail_log"
        //-----------------テスト---------
        
        func getJSON() {
            //let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/vest.json")
            //let URL = NSURL(string: "http://10.0.3.187/log.json")
            guard let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/test.json") else{
                return
            }
            let req = NSURLRequest(URL: URL,cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,
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
                    // まずキー"data"で、配列データを取り出す
                    print(msg)
                    if let arrayData = jsonDic["log"] as? NSArray {
                        // 配列のデータを１つずつ辞書データを取り出す
                        print("ほげ1")
                        for datN in 0..<arrayData.count {
                            if let data = arrayData[datN] as? NSDictionary {
                                if let log = data["day"] as? String{
                                    msg += "\(log) : "
                                }
                                
                                if let cal = data["Count"] as? Int{
                                    print("ほげ2")
                                    msg += "\(cal)人\n"
                                }
                            }
                        }
                     //   msg += "\(calcu)"
                        print(msg)
                    }
                    //UITextFieldを表示。ここで呼び出すとjsonファイルが反映される
                    textbox(self.view.bounds.height - self.view.bounds.height*13/14)
                } catch{
                    print("Error Message : Proccess is interrupted by error")
                }
            })//ここまでTask
            task.resume()
        }
        
        //-----------------テスト---------
        //log表示ブロック
        getJSON()
        
        func textbox(tate: CGFloat){
            // let label = UILabel(frame: CGRectMake(0, 0, 250, 120));
            let label:UITextView = UITextView(frame: CGRectMake(0, tate, self.view.bounds.width - self.view.bounds.height*3/20,self.view.bounds.height - self.view.bounds.height*1/14));
            //label.center = CGPointMake(160, 284);//表示位置
            //label.textAlignment = NSTextAlignment.Center //中央
            label.textAlignment = NSTextAlignment.Left //左詰め
            // テキストを編集不可にする.
            label.editable = false
            
            label.text = msg;
            self.view.addSubview(label);
        }
        
        //ナビゲーションバーに更新ボタンを設置
        renewalButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self,  action: "onClickMyButton:")
        self.navigationItem.setRightBarButtonItems([renewalButton], animated: true)
        //ナビゲーションバーにホームボタンを設置
        backButton = UIBarButtonItem(title:"Home", style: .Plain, target: self,  action: "onClickMyButton2:")
        self.navigationItem.setLeftBarButtonItems([backButton], animated: true)
        
    }
    
    /*
    ボタンイベント.
    */
    internal func onClickMyButton(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = FirstLogViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        //self.presentViewController(mySecondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
    internal func onClickMyButton2(sender: UIButton){
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = FirstViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        //self.presentViewController(mySecondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}