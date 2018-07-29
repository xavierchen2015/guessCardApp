//
//  ViewController.swift
//  guessCardApp
//
//  Created by Xavier Chen [MIGOTP] on 2018/7/27.
//  Copyright © 2018年 Xavier Chen [MIGOTP]. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet var pageView: UIView!
    @IBOutlet weak var levelSelectSegment: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func levelSelectChange(_ sender: UISegmentedControl) {
        let gameLevel = Int(sender.selectedSegmentIndex)
        
        //選新局，所以牌、圖片要從畫面上拿掉，還有 array、猜過的次數 也要清空
        for but in buttonArray {
            but.removeFromSuperview()
        }
        for but in imageArray {
            but.removeFromSuperview()
        }
        buttonArray.removeAll()
        imageArray.removeAll()
        guessTimes = 0
        
        resultLabel.text = "準備開始~"
        startGame(level: gameLevel+1)
        print(sender.selectedSegmentIndex)
        
    }
    //遊戲難度
    var gameLevel = 0
    //還剩下多少牌
    var haveCardCount = 0
    
    var checkCard = [Int]()
    var buttonArray = [mybutton]()
    var imageArray = [UIImageView]()
    //牌的圖片
    var cardImages = ["hearthstone1","hearthstone2","hearthstone3","hearthstone4","hearthstone5","hearthstone6","hearthstone7","hearthstone8"]
    var guessTimes = 0
    
    //var gameView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 39))
    
    //var cardImageView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 39))
    
    //牌按下後的動作
    @objc func buttonAction(sender: mybutton!) {
        
        // button 不能再點，alpha = 0 模擬翻牌
        sender.isEnabled = false
        sender.alpha = 0
        
        //加入index
        checkCard.append(sender.orderId!)
        print(checkCard)
        
        if checkCard.count == 2 {
            //從 array 取值回來
            let card1 = buttonArray[checkCard[0]]
            let card2 = buttonArray[checkCard[1]]
            let pic1 = imageArray[checkCard[0]]
            let pic2 = imageArray[checkCard[1]]
            
            if card1._id == card2._id {
                //延遲 1 秒後動作(翻牌)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    pic1.alpha = 0
                    pic2.alpha = 0
                })
                haveCardCount = haveCardCount - 2
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                    card1.alpha = 1
                    card2.alpha = 1
                    card1.isEnabled = true
                    card2.isEnabled = true
                })
            }
            guessTimes = guessTimes + 1
            checkCard.removeAll()
            
            print("還有幾張 \(haveCardCount)")
        }
        
        print("guess time \(guessTimes)")
        if haveCardCount == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.resultLabel.text = "恭喜你猜完了，一共猜了 \(self.guessTimes) 次"
            })
        } else {
            if guessTimes != 0 {
                resultLabel.text = "你已經猜了 \(guessTimes) 次嘍~"
            }
        }
    }
    
    //自建 button
    func addButton(x:CGFloat, y:CGFloat, w:CGFloat, h: CGFloat, id: Int, oid: Int) {
        let rect = CGRect(x: x, y: y, width: w, height: h)
        let butn = mybutton(frame: rect, id: id, oid: oid)
        let image = UIImage(named: "cardBack")
        
        butn.setBackgroundImage(image, for: UIControl.State.normal)
        butn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        buttonArray.append(butn)
        pageView.addSubview(butn)
        
    }
    
    //自建imageview
    func addImage(x:CGFloat, y:CGFloat, w:CGFloat, h: CGFloat, id: Int) {
        let imageView = UIImageView(frame: CGRect(x: x, y: y, width: w, height: h))
        
        pageView.addSubview(imageView)
        
        imageArray.append(imageView)
        //设置显示的图片
        let imageName = "hearthstone" + String(id)
        let image = UIImage(named: imageName)
        imageView.image = image
    }
    
    //產生牌組值
    func crateFirstRound(level: Int = 2) -> Array<Int> {
        var baseArray = [Int]()
        let cardCount:Int = 4 * level
        let cardArray = Array(1...cardCount/2)
        let cardArray2 = Array(1...cardCount/2)
        baseArray = cardArray + cardArray2
        baseArray.shuffle()
        return baseArray
    }
    
    //開始整理牌，設定位置
    func startGame(level: Int) {
        let arr = crateFirstRound(level: level)
        print(arr)
        haveCardCount = arr.count
        var x:CGFloat = 30
        var y:CGFloat = 50
        for (index, card) in arr.enumerated() {
            //print(index)
            if (index % 4 == 0) && (index != 0) {
                y = (y + 10) + 110
                x = 30
            }
            addImage(x: x, y: y, w: 71.8, h: 107.2, id: card)
            addButton(x: x, y: y, w: 71.8, h: 107.2, id: card, oid: index)
            
            x = (x + 10) + 72
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Card(
        
        resultLabel.text = "要不要換個難度?"
        startGame(level: levelSelectSegment.selectedSegmentIndex+1)
        
    }

}

