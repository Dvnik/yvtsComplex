//
//  DrViewController.swift
//  yvtsComplex
//
//  Created by Trixie Lulamoon on 2020/10/15.
//

import UIKit

class DrViewController: UIViewController
{
    // values
    // 儲存裝置目前的長寬
    var deviceWidth:CGFloat = 0
    var deviceHeight:CGFloat = 0
    // 動畫結束之後的XY軸
    var animeEndX:CGFloat = 20
    var animeEndY:CGFloat = 100
    // UI Objects
    @IBOutlet weak var imgPic: UIImageView!// 執行動畫的圖片
    //MARK: - my Functions
    // 確認機器類型與記錄解析度
    func copyDevicesFrame()
    {
        // 確認目前的螢幕大小
//        print(self.view.frame) // 印出frame資訊
        // 記錄螢幕的寬高
        deviceWidth = self.view.frame.size.width
        deviceHeight = self.view.frame.size.height
        print("寬：\(deviceWidth)高：\(deviceHeight)")
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //記錄首次的畫面大小
        copyDevicesFrame()
    }
    // 當畫面完成佈置時(包含設備旋轉時)
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        // 刷新畫面大小紀錄
        copyDevicesFrame()
        // 更動位置必須在完成限制條件的配置之後
        self.imgPic.frame = CGRect(x: animeEndX, y: animeEndY, width: 64, height: 64)
        
        var picName = "" // 儲存要更換圖片的名稱
        
        switch UIDevice.current.orientation
        {
            case .landscapeLeft, .landscapeRight:
                picName = "drCar1"
            case .portrait, .portraitUpsideDown:
        
                picName = "drCar2"
            default:// enum的switch-case需要有預設情況，不能省略(或是全部列舉都舉出)
                //似乎畫面載入完成後的狀態無法辨識，印出來的UIDevice.current.orientation.rawValue為0
                picName = "drSteps" //非左右上下的情況用第三張圖片辨識結果不如預期
        }
        // 更換圖片
        self.imgPic.image = UIImage(named: picName)
    }
    // 當設備寬高的Compact或Regular有變化時（注意：iPad永遠不會呼叫這個事件，因為都是Regular）
    // Compact或Regular要說的話就是Apple給它的裝置的比例形式做一個稱呼
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
//    {
//        super.willTransition(to: newCollection, with: coordinator)
//
//        // 注意：newCollection 與 self.traitCollection 為同一個裝置型態管理的實體
//        // 如果裝置的寬度(horizontalSizeClass)為特定模式時
//        if newCollection.horizontalSizeClass == .compact
//        {
//            print("寬度：Compact")
//        }
//        else if newCollection.horizontalSizeClass == .regular
//        {
//            print("寬度：Regular")
//        }
//        // 如果裝置的高度(verticalSizeClass)為特定模式時
//        if newCollection.verticalSizeClass == .compact
//        {
//            print("高度：Compact")
//        }
//        else if newCollection.verticalSizeClass == .regular
//        {
//            print("高度：Regular")
//        }
//        // 其他註記：用這個判斷機器是否轉為橫向是不可靠的
//    }
    //裝置即將旋轉時
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        print("解析度為：\(size.width) x \(size.height)")
        // 執行伴隨旋轉產生的動畫
        coordinator.animate(alongsideTransition:
            {
                (context)
                in
                //由程式按下動畫按鈕
                self.doAnimation(nil)
            }, completion: nil)

        
    }
    
    //MARK: - Target Actions
    // 執行動畫按鈕
    /*
     UIView的amimate方法，可以操作以下屬性的動畫：
     1.frame:相對於其他位置及大小
     2.bounds:自己的位置及大小
     3.center:中央點座標
     4.transform:旋轉
     5.alpha:透明度(0.0~1.0)
     6.contentStrethc:放大縮小(PS.也可以操作frame寬與高)
     **/
    @IBAction func doAnimation(_ sender: UIButton?)
    {
        //用UIView.animate做簡單的循環一圈的動畫。
        //多個巢狀迴圈雖然難看，但是能達到效果
        let animeDuration = 0.25
        UIView.animate(withDuration: animeDuration)
            {
                // 第一段動畫：水平移動移動到畫面的右方
            self.imgPic.frame.origin.x = self.deviceWidth - self.animeEndX - self.imgPic.frame.size.width
                self.imgPic.alpha = 0.3
            }
            completion:
            {
                (finished)
                in
                // 第二段動畫：垂直移動到畫面的下方
                UIView.animate(withDuration: animeDuration)
                {
                    self.imgPic.frame.origin.y = self.deviceHeight - self.animeEndY - self.imgPic.frame.size.height
                    self.imgPic.alpha = 1
                }
                completion:
                {
                    (finished)
                    in
                    // 第三段動畫：水平移動到畫面的前方
                    UIView.animate(withDuration: animeDuration)
                    {
                        self.imgPic.frame.origin.x = self.animeEndX
                        self.imgPic.alpha = 0.3
                    }
                    completion:
                    {
                        (finished)
                        in
                        // 第四段動畫：垂直移動到畫面的上方
                        UIView.animate(withDuration: animeDuration)
                        {
                            self.imgPic.frame.origin.y = self.animeEndY
                            self.imgPic.alpha = 1
                        }
                    }

                }

            }

    }
    
}
