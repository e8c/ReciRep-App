//
//  RatingControl.swift
//  ReciRep
//
//  Created by Emily Chou on 10/7/16.
//  Copyright © 2016 Emily Chou. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    //MARK: Properties
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        for _ in 0..<starCount{
        let button = UIButton()
        button.setImage(emptyStarImage, for: .normal)
        button.setImage(filledStarImage, for: .selected)
        button.setImage(filledStarImage, for: [.highlighted, .selected])
        //button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
        ratingButtons += [button]
        addSubview(button)
        }
    }
    
    override func layoutSubviews(){
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing
        for(index, button) in ratingButtons.enumerated(){
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    /*override func intrinsicContentSize() -> CGSize{
        return CGSize(width: 240, height: 44)
    }*/
    
    //MARK: Button Action 
    func ratingButtonTapped(button: UIButton){
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerated(){
            // If the index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating
        }
    }

}
