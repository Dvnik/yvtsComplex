//
//  PageChange3VC.swift
//  yvtsComplex
//
//  Created by Trixie Lulamoon on 2020/10/8.
//

import UIKit

class PageChange3VC: UIViewController
{

    // Values
    //放置訊息屬性
    var infoMessage: String!
    // 設置一個儲存ViewController實體的弱引用
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
    // 返回原始頁
    // 因為我的原始頁面是要把多個課堂練習整合起來，因此執行這個程式碼並不會跳到"第一頁"
    func sendToRoot()
    {
        //用navigationController的popToRootViewController方法，會直接跳到navigationController原始的頁面
        //那個頁面就不是PageChange這個練習的範圍了
        self.navigationController?.popToRootViewController(animated: true)
    }
    //返回上一頁
    func sendToLastPage()
    {
        if let page2 = self.lastVC as? PageChange2VC
        {
            page2.infoMessage = "From Page3 Back."
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func sendToPage1()
    {
        for controller in self.navigationController!.viewControllers
        {
            if let page1VC = controller as? PageChange1VC
            {
                page1VC.infoMessage = "Page3 turn into Page1."
                self.navigationController?.popToViewController(page1VC, animated: true)
                break
            }
        }
        // 以下模仿"前往InfoPage"的方式"返回"至第一頁，會行不通
        // 原因是從stroyboard指定的頁面和navigationController自行堆疊的列表並不吻合
        // 以至於直接使用navigationController?.popToViewController跳到指定的頁面會出現error
        // 反之用self.show呈現的方式是"前往"第一頁，這令navigationController的堆疊順序增加，
        // 這時的第一頁按下navigationBar的back鍵並不是回到根目錄頁，而是再回到第三頁。
        // 結果就不會是正確的
//        let page1VC = self.storyboard!.instantiateViewController(identifier: "PageChange1VC") as PageChange1VC
//        page1VC.infoMessage = "Page3 turn into Page1."
//        self.show(page1VC, sender: nil)//這個指令是"前往"的感覺，並不是"返回"
    }
    
    //MARK: -View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        showMessage()
    }
    
    //MARK:-Target Actions
    
    
    @IBAction func btnBackAction(_ sender: UIButton)
    {
        switch sender.restorationIdentifier
        {
            case "backToRoot":
                sendToRoot()
            case "backToPage1":
                sendToPage1()
            default:
                sendToLastPage()
        }
    }
    
    
    // 前往資訊頁面(由自行撰寫的程式碼直接前往，而非使用StoryBoard的牽線)
    @IBAction func btnInfoAction(_ sender: UIButton)
    {        
        let infoVC = self.storyboard!.instantiateViewController(identifier: "PageChangeInfoVC") as PageChangeInfoVC
        // 設置要傳遞的訊息
        infoVC.infoMessage = "Hey! I'm Page 3."
        // 顯示資訊頁
        self.show(infoVC, sender: nil)
    }
}
