//
//  ViewController.swift
//  HW1
//
//  Created by user165563 on 4/20/20.
//  Copyright © 2020 hodgohasi. All rights reserved.
//

import UIKit


class GameController: UIViewController {

    @IBOutlet weak var game_LBL_counter: UILabel!
    
    @IBOutlet weak var game_LBL_stopper: UILabel!
    
    @IBOutlet weak var game_STACKVIEW_basketsHolder: UIStackView!
    
    private var clickedButtons:[Int] = []
    private var score:Int = 0
    private var moves:Int = 0
    private var flag : Bool = true
    private var allImages : [UIImage] = []
    private var shuffleImages : [UIImage] = []
    private var stopper:Timer?
    private var counter = 0.0
    private var firstClickToStartStopper:Bool = true
    private var shuffled : Bool = false
    var numberOfRows : Int!
    var numberOfCols : Int!
    private var numberOfCells :Int = 0
    private var baskets : [UIButton] = []
    var location : MyLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndShuffleGameCard()
        initBaskets(numOfRows: numberOfRows,numOfCols: numberOfCols)
    }
    
    
    
    func createAndShuffleGameCard(){
              

              if(numberOfRows == 4){
                  allImages = [#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96"),#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96")]
              }
              else if(numberOfRows == 5){
                  allImages = [#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96"),#imageLiteral(resourceName: "icons8-kiwi-fruit-100"),#imageLiteral(resourceName: "icons8-citrus-100"),#imageLiteral(resourceName: "icons8-pear-100"),#imageLiteral(resourceName: "icons8-watermelon-100"),#imageLiteral(resourceName: "icons8-raspberry-100"),#imageLiteral(resourceName: "icons8-orange-100"),#imageLiteral(resourceName: "icons8-melon-96"),#imageLiteral(resourceName: "icons8-banana-96"),#imageLiteral(resourceName: "icons8-pineapple-100"),#imageLiteral(resourceName: "icons8-pineapple-100"),#imageLiteral(resourceName: "icons8-plum-100"),#imageLiteral(resourceName: "icons8-plum-100")]
              }
              
              shuffleImages = allImages.shuffled()
         
    }
    
    
    @IBAction func buttonClick(_ sender: UIButton) {
          if(firstClickToStartStopper){
              stopper = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(stopperFunc), userInfo: nil, repeats: true)
              firstClickToStartStopper = false
          }
          
          if(flag){
              click(num: sender.tag)
          }
         
      }
    
    
      func click(num:Int){
          baskets[num].setImage(shuffleImages[num], for: .normal)
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
        counter += 1
        let flooredCounter = Int(floor(counter))
        let minute = (flooredCounter % 3600) / 60
        var minuteString = "\(minute)"
        if(minute < 10){
            minuteString = "0\(minute)"
        }
        
        let second = (flooredCounter % 3600) % 60
        var secondString = "\(second)"
        if(second < 10){
            secondString = "0\(second)"
        }
        
        self.game_LBL_stopper.text = "\(minuteString):\(secondString)"
    }
  
    
    func resetImage(){
        if(!(shuffleImages[clickedButtons[0]] == shuffleImages[clickedButtons[1]])){
            baskets[clickedButtons[0]].setImage(#imageLiteral(resourceName: "icons8-wicker-basket-100"), for: .normal)
            baskets[clickedButtons[1]].setImage(#imageLiteral(resourceName: "icons8-wicker-basket-100"), for: .normal)
        }else{
            score += 1
            if (score == numberOfCells/2){
                stopper?.invalidate()
                //add result to static array!!!
                self.performSegue(withIdentifier: "goToGameOver", sender: self)
            }
        }
        clickedButtons = []
        
    }
    
    
    
    
    func initBaskets(numOfRows : Int, numOfCols : Int){
        
        numberOfCells = numOfRows * numOfCols;
        for i in 0 ..< numOfRows {
            let row : UIStackView = createRow();
            for j in 0 ..< numOfCols {
                let newBasket : UIButton = createBasket()
                newBasket.setImage(#imageLiteral(resourceName: "icons8-wicker-basket-100"), for: .normal)
                newBasket.tag = i * numberOfCols + j
                //Adding newCard to row Stackview
                row.addArrangedSubview(newBasket);
                //Adding newCard to cards Array ref
                baskets.append(newBasket);
            }
            game_STACKVIEW_basketsHolder.addArrangedSubview(row);
        }
        
    }
    
    func createBasket () -> UIButton {
        
        let newBasket : UIButton = UIButton();
        newBasket.addTarget(self, action: #selector(buttonClick), for: .touchUpInside);
        
        return newBasket;
    }
    
    func createRow () -> UIStackView {
        
        let SPACING: CGFloat = 10;
        let row = UIStackView();
        
        row.axis = .horizontal;
        row.alignment = .fill;
        row.distribution = .fillEqually;
        row.spacing = SPACING;
        row.contentMode = .scaleToFill;
        row.translatesAutoresizingMaskIntoConstraints = false
        
        return row;
    }
    
    

    
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
           if(segue.identifier == "goToGameOver"){
               let gameOverView = segue.destination as! GameOverViewController
            if(numberOfRows == 4){
                gameOverView.fromMode = numberOfRows
                gameOverView.time = self.game_LBL_stopper.text
                gameOverView.location = self.location
            }else if(numberOfRows == 5){
                gameOverView.fromMode = numberOfRows
                gameOverView.time = self.game_LBL_stopper.text
                gameOverView.location = self.location
            }
               
           
       }
    }
        
    
    
}







