//
//  SecondViewController.swift
//  UIKit015
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //メッセージを格納する変数
        var msg:String = "入居者詳細\n"
        //現在の人数を計算する変数
        var calcu:Int = 0
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        
        //-----------------テスト---------
        
        func getJSON() {//http://www.cc.u-ryukyu.ac.jp/~e135740/test.json
            //http://editors.ascii.jp/c-minamoto/swift/swift-5-data.json
            let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/vest.json")
            //let URL = NSURL(string: "http://10.0.3.187/test.json")
            let req = NSURLRequest(URL: URL!)
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
                    if let arrayData = jsonDic["detail"] as? NSArray {
                        // 配列のデータを１つずつ辞書データを取り出す
                        for datN in 0..<arrayData.count {
                            if let data = arrayData[datN] as? NSDictionary {
                                //  キー"name"の文字データを取り出して、msg変数に追加
                                if let nameDat = data["mem"] as? String{
                                    msg += "\(nameDat)\n"
                                }
                            }
                            
                        }}
                    print(msg)
                /*    if let arrayData = jsonDic["log"] as? NSArray {
                        // 配列のデータを１つずつ辞書データを取り出す
                        print("ほげ1")
                        for datN in 0..<arrayData.count {
                            if let data = arrayData[datN] as? NSDictionary {
                                if let cal = data["Count"] as? Int{
                                    print("ほげ2")
                                    if cal == 1 {calcu += 1}
                                    if cal == 0 {calcu -= 1}
                                    //msg += "\(calcu)"
                                }
                            }
                        }
                        msg += "\(calcu)"
                        print(msg)
                    }*/
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
        
        //log表示ブロック
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
        
        // 戻るボタンを作成.
        let backButton: UIButton = UIButton(frame: CGRectMake(0,0,120,50))
        backButton.backgroundColor = UIColor.redColor();
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
        let myViewController: UIViewController = FirstViewController()
        
        // アニメーションを設定.
        myViewController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        // Viewの移動.
        self.presentViewController(myViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}