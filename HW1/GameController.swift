//
//  ViewController.swift
//  HW1
//
//  Created by user165563 on 4/20/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var game_BTN_00: UIButton!
    @IBOutlet weak var game_BTN_01: UIButton!
    @IBOutlet weak var game_BTN_02: UIButton!
    @IBOutlet weak var game_BTN_03: UIButton!
    @IBOutlet weak var game_BTN_10: UIButton!
    @IBOutlet weak var game_BTN_11: UIButton!
    @IBOutlet weak var game_BTN_12: UIButton!
    @IBOutlet weak var game_BTN_13: UIButton!
    @IBOutlet weak var game_BTN_20: UIButton!
    @IBOutlet weak var game_BTN_21: UIButton!
    @IBOutlet weak var game_BTN_22: UIButton!
    @IBOutlet weak var game_BTN_23: UIButton!
    @IBOutlet weak var game_BTN_30: UIButton!
    @IBOutlet weak var game_BTN_31: UIButton!
    @IBOutlet weak var game_BTN_32: UIButton!
    @IBOutlet weak var game_BTN_33: UIButton!
    @IBOutlet weak var game_BTN_40: UIButton!
    @IBOutlet weak var game_BTN_41: UIButton!
    @IBOutlet weak var game_BTN_42: UIButton!
    @IBOutlet weak var game_BTN_43: UIButton!
    @IBOutlet weak var game_LBL_GoodJob: UILabel!
    @IBOutlet weak var game_BTN_restart: UIButton!
    @IBOutlet weak var game_LBL_counter: UILabel!
    
    @IBOutlet weak var game_LBL_stopper: UILabel!
    
    private var arrBtn:[UIButton] = []
    private var clickedButtons:[Int] = []
    private var score:Int = 0
    private var moves:Int = 0
    private var flag : Bool = true
    private var allImages : [UIImage] = []
    private var shuffleImages : [UIImage] = []
    private var stopper:Timer?
    private var milisec:Float = 0
    private var firstClickToStartStopper:Bool = true
    var mode : Int?
    private var shuffled : Bool = false
    final var MATRIX4X4 = 44
    final var MATRIX4X5 = 45
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
    
    func createAndShuffleGameCard(){
              
              if(mode == MATRIX4X4){
                  arrBtn = [game_BTN_00,game_BTN_01,game_BTN_02,game_BTN_03,game_BTN_10,game_BTN_11,game_BTN_12,game_BTN_13,game_BTN_20,game_BTN_21,game_BTN_22,game_BTN_23,game_BTN_30,game_BTN_31,game_BTN_32,game_BTN_33]
                  allImages = [#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96"),#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96")]
              }
              else if(mode == MATRIX4X5){
                  arrBtn = [game_BTN_00,game_BTN_01,game_BTN_02,game_BTN_03,game_BTN_10,game_BTN_11,game_BTN_12,game_BTN_13,game_BTN_20,game_BTN_21,game_BTN_22,game_BTN_23,game_BTN_30,game_BTN_31,game_BTN_32,game_BTN_33
                      ,game_BTN_40,game_BTN_41,game_BTN_42,game_BTN_43]
                  allImages = [#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96"),#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96"),#imageLiteral(resourceName: "icons8-pineapple-100"),#imageLiteral(resourceName: "icons8-pineapple-100"),#imageLiteral(resourceName: "icons8-plum-100"),#imageLiteral(resourceName: "icons8-plum-100")]
              }
              
              shuffleImages = allImages.shuffled()
    }
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
        if(shuffled == false){
            createAndShuffleGameCard()
            shuffled = true
        }
          if(firstClickToStartStopper){
              stopper = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(stopperFunc), userInfo: nil, repeats: true)
              firstClickToStartStopper = false
          }
          
          if(flag){
              click(num: sender.tag)
          }
         
      }
    
    
      func click(num:Int){
          arrBtn[num].setImage(shuffleImages[num], for: .normal)
          if (!(clickedButtons.contains(num))){
              clickedButtons.append(num)
          }
          if(clickedButtons.count == 2){
              moves += 1
              self.game_LBL_counter.text = String(moves)
              flag = false
              DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                  self.resetImage()
                  self.flag = true
              }
              
              
          }
      }
    
    
    @objc func stopperFunc() {
        milisec += 1
        let second = String(format: "%.2f", milisec/1000)
        self.game_LBL_stopper.text = "Your time is : \(second)"
    }
  
    
    func resetImage(){
        if(!(shuffleImages[clickedButtons[0]] == shuffleImages[clickedButtons[1]])){
            arrBtn[clickedButtons[0]].setImage(#imageLiteral(resourceName: "icons8-wicker-basket-100"), for: .normal)
            arrBtn[clickedButtons[1]].setImage(#imageLiteral(resourceName: "icons8-wicker-basket-100"), for: .normal)
        }else{
            score += 1
            if (score == allImages.count/2){
                game_LBL_GoodJob.isHidden = false
                stopper?.invalidate()
            }
        }
        clickedButtons = []
        
    }
    
    
    @IBAction func buttonRestartGame(_ sender: Any) {
        for btn in arrBtn {
            btn.setImage(#imageLiteral(resourceName: "icons8-wicker-basket-100"), for: .normal)
        }
        shuffleImages = allImages.shuffled()
        score = 0
        moves = 0
        self.game_LBL_counter.text = "00"
        game_LBL_GoodJob.isHidden = true
        self.game_LBL_stopper.text = "Your time is :"
        milisec = 0
        stopper?.invalidate()
        firstClickToStartStopper = true
    }
    
}


