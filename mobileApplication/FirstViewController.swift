//
//  FirstViewController.swift
//  UIKit015
//

import UIKit
import LTMorphingLabel
import ZFRippleButton
import ZCAnimatedLabel
import PNChart


class FirstViewController: UIViewController,UIApplicationDelegate,PNChartDelegate {
    
    //関数宣言
    private var myImageView: UIImageView!
    private var renewalButton: UIBarButtonItem!
    private var nullButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var calcu:Int?
        
        //グラフの描画
        //参考サイト:http://developer-blog.finc.co.jp/post/133981060627/
        drawLineGraph()

        //メッセージを格納する変数
        var msg:String = "現在自習室には"
        var log:String = ""
        //現在の人数を計算する変数
        
        // 背景色を設定する.
        self.view.backgroundColor = UIColor.whiteColor()
 
        
//-----------------画像---------
        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRectMake(0,0,200,160))
        // 表示する画像を設定する.
        let myImage = UIImage(named: "graph.png")
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        // 画像の表示する座標を指定する.
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: 300.0)
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
//-----------------画像---------

        
        
//------------JSON取得---------
        
        func getJSON()  {//http://www.cc.u-ryukyu.ac.jp/~e135740/test.json
            // let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/test.json")
           // let URL = NSURL(string: "http://10.0.3.187/log.json")
            guard let URL:NSURL = NSURL(string: "http://10.0.3.187/log.json") else{
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
                                    calcu = cal
                                    log += "\(cal)人\n"
                                    msg = "現在\(cal)人います"
                                    self.title = "現在\(cal)人"
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
                        //受け渡し用
                        print("calcu:\(calcu)人\n")
                        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.badge = calcu
                        
                        //
                    print(msg)
                    print(log)
                    }
                    
                        print(msg)
                    //UITextFieldを表示。ここで呼び出すとjsonファイルが反映される
                        textbox(self.view.bounds.height - self.view.bounds.height*7/10)
                        logbox(self.view.bounds.height - self.view.bounds.height*2/10)
                } catch{
                      print("Proccess is interrupted by error")
                }
            })//ここまでTask
            task.resume()
        }
        
//--------------JSON取得---------
        //log表示ブロック
        getJSON()
        

 
        func textbox(tate: CGFloat){
             //let label = LTMorphingLabel(frame: CGRectMake(0, 0, 150, 50));
            let label:UITextView = UITextView(frame: CGRectMake(0, 0, 150, 50));
            //label.center = CGPointMake(160, 284);//表示位置
            label.center = CGPointMake(160,tate);
            label.backgroundColor = UIColor.clearColor();
            
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
            label.backgroundColor = UIColor.whiteColor();
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
        
        


        // 入室者詳細ボタンを生成する.
        let infoButton: UIButton = UIButton(frame: CGRectMake(0,0,200,50))
        infoButton.backgroundColor = UIColor.clearColor();
        infoButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        infoButton.layer.masksToBounds = true
        infoButton.setTitle("More Infomation", forState: .Normal)
        infoButton.layer.cornerRadius = 20.0
        infoButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height - self.view.bounds.height*3/10)
        infoButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // ログボタンを生成する.
        //let logButton: UIButton = ZFRippleButton(frame: CGRectMake(0,0,150,50))
        let logButton: UIButton = UIButton(frame: CGRectMake(0,0,150,50))
        logButton.backgroundColor = UIColor.clearColor();
        logButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        logButton.layer.masksToBounds = true
        logButton.setTitle("detail_log", forState: .Normal)
        logButton.layer.cornerRadius = 20.0
        logButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height - self.view.bounds.height/10)
        logButton.addTarget(self, action: "onClickMyButton2:", forControlEvents: .TouchUpInside)

        renewalButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self,  action: "onClickMyButton3:")
        // ナビゲーションバーの右に設置する.
        self.navigationItem.setRightBarButtonItems([renewalButton], animated: true)
        
        nullButton = UIBarButtonItem(title:"", style: .Plain, target: self,  action: "onClickMyButton4:")
        // ナビゲーションバーの右に設置する.
        self.navigationItem.setLeftBarButtonItems([nullButton], animated: true)
        
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
        //self.presentViewController(mySecondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
    internal func onClickMyButton2(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = FirstLogViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        //self.presentViewController(mySecondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
    }
    
    internal func onClickMyButton3(sender: UIButton){
        
        // 遷移するViewを定義する.
        let mySecondViewController: UIViewController = FirstViewController()
        
        // アニメーションを設定する.
        mySecondViewController.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        // Viewの移動する.
        //self.presentViewController(mySecondViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(mySecondViewController, animated: true)
        
        
    }
    
    internal func onClickMyButton4(sender: UIButton){
        
    }
    
    //グラフ描画
    func drawLineGraph() {

        var ChartLabel:UILabel = UILabel(frame: CGRectMake(0, 90, 320.0, 30))
        

        ChartLabel.textColor = UIColor.cyanColor()
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.textAlignment = NSTextAlignment.Center
        //Add LineChart
        ChartLabel.text = "Line Chart"
        
       
        

        //Add BarChart
        ChartLabel.text = "Bar Chart"
        
        var barChart = PNBarChart(frame: CGRectMake(0, 140.0, 320.0, 250.0))
        barChart.backgroundColor = UIColor.clearColor()
        //            barChart.yLabelFormatter = ({(yValue: CGFloat) -> NSString in
        //                var yValueParsed:CGFloat = yValue
        //                var labelText:NSString = NSString(format:"%1.f",yValueParsed)
        //                return labelText;
        //            })
        
        
        // remove for default animation (all bars animate at once)
        
        
        barChart.labelMarginTop = 20.0
        barChart.xLabels = ["1/25","1/26","1/27","1/28","1/29","1/30","1/31"]
        barChart.yValues = [1,24,12,18,30,10,21]
        barChart.strokeChart()
        
        barChart.delegate = self
        
        view.addSubview(ChartLabel)
        view.addSubview(barChart)
    
        }

}