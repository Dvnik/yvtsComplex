//
//  PageChange1VC.swift
//  yvtsComplex
//
//  Created by Trixie Lulamoon on 2020/10/8.
//

import UIKit

class PageChange1VC: UIViewController
{
    // Values
    //放置訊息屬性
    var infoMessage: String?
    
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
    
    //MARK: - View Life Cycle
    // 畫面載入完成
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if infoMessage == nil
        {
            infoMessage = "Page 1 Load Finish."
        }
        showMessage()
        print("page1載入完成")
    }
    // 觀察：即將出現
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showMessage()
        print("page1即將出現")
    }
    // 觀察：已經出現
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("page1已經出現")
    }
    // 觀察：已經完成介面佈置
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("page1已經完成介面佈置")
    }
    // 觀察：即將消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 注意：進入背景畫面即將消失時，不會呼叫此事件!(除非是頁面轉換時)
        print("page1即將消失")
    }
    // 觀察：已經消失
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 注意：進入背景畫面，並不會呼叫此事件！
        print("page1已經消失")
    }
    // 即將由連接線換頁
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //這是一個習慣，沿用繼承下來的父類別方法，以防iOS生命週期中一些必要的環境沒做到
        super.prepare(for: segue, sender: sender)
        
        //卻認由特定的連接線進行換頁
        if segue.identifier == "ToPC2"
        {
            //由連接線的轉換端取得下一頁的執行實體（必須精確轉型）
            let page2 = segue.destination as! PageChange2VC
            //對下一頁的執行實體，進行屬性傳遞（值型別的傳遞）
            page2.infoMessage = "Page1 Segue to Page2."
            //直接對下一頁的執行實體，進行屬性傳遞（引用別的傳遞）
            page2.lastVC = self
        }
        
    }
    deinit
    {
        print("page1即將被釋放")
    }
    
    //MARK: - Target Actions
    // 前往資訊頁面(由自行撰寫的程式碼直接前往，而非使用StoryBoard的牽線)
    @IBAction func btnInfoAction(_ sender: UIButton)
    {
        let infoVC = self.storyboard!.instantiateViewController(identifier: "PageChangeInfoVC") as PageChangeInfoVC
        // 設置要傳遞的訊息
        infoVC.infoMessage = "Hey! I'm Page 1."
        // 顯示資訊頁
        self.show(infoVC, sender: nil)
    }
    
    


}
