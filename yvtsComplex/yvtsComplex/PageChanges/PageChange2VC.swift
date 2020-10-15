//
//  PageChange2VC.swift
//  yvtsComplex
//
//  Created by Trixie Lulamoon on 2020/10/8.
//

import UIKit

class PageChange2VC: UIViewController
{
    // Values
    //放置訊息屬性
    var infoMessage: String!
    // 設置一個儲存ViewController實體的弱引用
    // 快速的做法就是已經知道前一頁必定是Page1，就直接指定Page1的Class。
    // 不過我想在這個範例完成之後，嘗試再做一次重構，將可以整合的方法用一個Message控制，所以就先用父類別
    weak var lastVC: UIViewController?
    
    
    // UI Objects
    @IBOutlet weak var lblMessage: UILabel!
    
    
    //MARK: - my Functions
    func showMessage()
    {
        if let infoStr = infoMessage
        {
            lblMessage.text = infoStr
        }
        else
        {
            lblMessage.text = "Not any message send to here."
        }
    }
    
    //MARK: -View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        showMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMessage()
    }
    
    // 即將由連接線換頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //這是一個習慣，沿用繼承下來的父類別方法，以防iOS生命週期中一些必要的環境沒做到
        super.prepare(for: segue, sender: sender)
        
        //卻認由特定的連接線進行換頁
        if segue.identifier == "ToPC3"
        {
            //由連接線的轉換端取得下一頁的執行實體（必須精確轉型）
            let page3 = segue.destination as! PageChange3VC
            //對下一頁的執行實體，進行屬性傳遞（值型別的傳遞）
            page3.infoMessage = "Page2 Segue to Page3."
            //直接對下一頁的執行實體，進行屬性傳遞（引用別的傳遞）
            page3.lastVC = self
        }
        
    }
    
    //MARK:-Target Actions
    //Button可以直接使用事件連結而不需要把實體抓進來
    //如果做的事情不一樣，就不需要刻意將所有按鈕都集中在同一個function裡面
    
    
    //用程式碼撰寫返回上一頁
    //做到和Navigation Bar自帶的back按鈕有相同效果
    @IBAction func btnBackAction(_ sender: UIButton)
    {
        if let page1 = self.lastVC as? PageChange1VC
        {
            //翻頁之前就要先執行好設置訊息的方法
            //經過觀察，返回頁面的時候不會走viewDidLoad，而是viewWillAppear和viewDidAppear這兩塊
            //如果想要單純設置訊息讓生命週期自行更新，就要注意位置
            //另外一種方式就是直接更新前一頁的物件或方法
//            page1.showMessage(showMsg: "From Page2 Back.")
            page1.infoMessage = "From Page2 Back."
//            print("page2訊息設置完成")
            // 此方法可以退掉由navigation流程管理顯示的VC(show方法)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // 前往資訊頁面(由自行撰寫的程式碼直接前往，而非使用StoryBoard的牽線)
    @IBAction func btnInfoAction(_ sender: UIButton)
    {
        let infoVC = self.storyboard!.instantiateViewController(identifier: "PageChangeInfoVC") as PageChangeInfoVC
        // 設置要傳遞的訊息
        infoVC.infoMessage = "Hey! I'm Page 2."
        // 顯示資訊頁
        self.show(infoVC, sender: nil)
    }
    
    
    
}
