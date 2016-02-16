//
//  FirstViewController.swift
//  UIKit015
//

import UIKit
import PNChartSwift

class FirstLogViewController: UIViewController, PNChartDelegate {
    private var renewalButton: UIBarButtonItem!
    private var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        //メッセージを格納する変数
        var msg:String = "\n"
        //入退室の記述の変数
        var calcu:String = ""
        // 室温と湿度
        var roomArray: [CGFloat] = []
        var rhArray: [CGFloat] = []
        var timeArray: [String] = []
        // 背景色をGreenに設定する.
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "detail_log"
        //-----------------テスト---------
        
        func getJSON() {
            //let URL = NSURL(string: "http://www.cc.u-ryukyu.ac.jp/~e135740/vest.json")
            //let URL = NSURL(string: "http://10.0.3.187/log.json")
            guard let URL = NSURL(string: "http://10.0.3.187/log.json") else{
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
                        //arrayData.count
                        for datN in 0..<arrayData.count {
                            if let data = arrayData[datN] as? NSDictionary {
                                if datN <= 5 {
                                    if let year:String = data["year"] as? String{
                                        msg += "20\(year),"
                                        print("\(year)")
                                    }
                                    if let day:String = data["day"] as? String{
                                        msg += "\(day),"
                                        print("\(day)")
                                    }
                                    if let time:String = data["time"] as? String{
                                        msg += "\(time),"
                                        timeArray.append("\(time)")
                                    }
                                
                                    if let cal = data["Count"] as? Int{
                                        print("ほげ2")
                                        msg += "\(cal)人,"
                                    }
                                    if let room:CGFloat = data["Room"] as? CGFloat{
                                        msg += "\(room)℃,"
                                        roomArray.append(room)
                                    }
                                    if let rh:CGFloat = data["Rh"] as? CGFloat{
                                        msg += "\(rh)%\n"
                                        rhArray.append(rh)
                                    }
                                }
                                else {
                                    if let year:String = data["year"] as? String{
                                        msg += "20\(year),"
                                        print("\(year)")
                                    }
                                    if let day:String = data["day"] as? String{
                                        msg += "\(day),"
                                        print("\(day)")
                                    }
                                    if let time:String = data["time"] as? String{
                                        msg += "\(time),"
                                    }
                                    
                                    if let cal = data["Count"] as? Int{
                                        print("ほげ2")
                                        msg += "\(cal)人,"
                                    }
                                    if let room:CGFloat = data["Room"] as? CGFloat{
                                        msg += "\(room)℃,"
                                    }
                                    if let rh:CGFloat = data["Rh"] as? CGFloat{
                                        msg += "\(rh)%\n"
                                    }
                                }
                            }
                        }
                     //   msg += "\(calcu)"
                        print(msg)
                        print(roomArray)
                    }
                    //UITextFieldを表示。ここで呼び出すとjsonファイルが反映される
                    textbox(self.view.bounds.height - self.view.bounds.height*13/14)
                    self.drawLineGraph(roomArray,rh: rhArray,time: timeArray)
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
            let label:UITextView = UITextView(frame: CGRectMake(0, tate, self.view.bounds.width,self.view.bounds.height - self.view.bounds.height/2));
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
    func drawLineGraph(room:[CGFloat],rh:[CGFloat],time: [String]) {
        
        //let ChartLabel:UILabel = UILabel(frame: CGRectMake(0,self.view.bounds.height - self.view.bounds.height/2, 320.0, 30))
        let ChartLabel:UILabel = UILabel(frame: CGRectMake(0,self.view.bounds.height - self.view.bounds.height/2, 320.0, 300))
        
        ChartLabel.textColor = PNGreenColor
        ChartLabel.font = UIFont(name: "Avenir-Medium", size:23.0)
        ChartLabel.textAlignment = NSTextAlignment.Center
        
        //Add BarChart
        
        
        let lineChart:PNLineChart = PNLineChart(frame: CGRectMake(0, self.view.bounds.height*3/5, 320, 200.0))
        lineChart.yLabelFormat = "%1.1f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clearColor()
        lineChart.xLabels = time
        lineChart.showCoordinateAxis = true
        lineChart.delegate = self
        
        // Line Chart Nr.1
        var data01Array: [CGFloat] = room
        var data02Array: [CGFloat] = rh
        let data01:PNLineChartData = PNLineChartData()
        let data02:PNLineChartData = PNLineChartData()
       //data01
        data01.color = PNGreenColor
        data01.itemCount = data01Array.count
        data01.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data01.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data01Array[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
       //data02
        data02.color = PNGreyColor
        data02.itemCount = data01Array.count
        data02.inflexionPointStyle = PNLineChartData.PNLineChartPointStyle.PNLineChartPointStyleCycle
        data02.getData = ({(index: Int) -> PNLineChartDataItem in
            let yValue:CGFloat = data02Array[index]
            let item = PNLineChartDataItem(y: yValue)
            return item
        })
        
        lineChart.chartData = [data01,data02]
        lineChart.strokeChart()
        
                lineChart.delegate = self
        
        view.addSubview(lineChart)
        view.addSubview(ChartLabel)
        
    }
    
    func userClickedOnLineKeyPoint(point: CGPoint, lineIndex: Int, keyPointIndex: Int)
    {
        print("Click Key on line \(point.x), \(point.y) line index is \(lineIndex) and point index is \(keyPointIndex)")
    }
    
    func userClickedOnLinePoint(point: CGPoint, lineIndex: Int)
    {
        print("Click Key on line \(point.x), \(point.y) line index is \(lineIndex)")
    }
    
    func userClickedOnBarChartIndex(barIndex: Int)
    {
        print("Click  on bar \(barIndex)")
    }

}