//
//  CardDetailViewController.swift
//  HighOrderFunctions
//
//  Created by Jim Campagno on 3/4/17.
//  Copyright © 2017 Jim Campagno. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var cards: [Card] = []
    private var scores: [Suit : Int] = [
        .hearts : 0,
        .spades : 0,
        .diamonds : 0,
        .clubs : 0
    ]
    
    // card piles
    private var diamonds: [Card] = []
    private var hearts: [Card] = []
    private var clubs: [Card] = []
    private var spades: [Card] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerView.layer.cornerRadius = 15.0
        containerView.layer.masksToBounds = true
        setupDismissButton()
        flipAllCardsFaceUp()
        separateIntoPiles()
        orderAllCards()
        calculateScores()
        printAllPiles()
    }
    
    func flipAllCardsFaceUp() {
        // TODO: Go through each card in the cards array, making sure each one is face up. If it's not, flip it! (there's a flipCard method available to Cards). Do not use a for-in lool, use forEach only. --> DONE
        cards.forEach({
            if !$0.isFaceUp { $0.isFaceUp = false  }
        })
    }
    
    func separateIntoPiles() {
        // TODO: Separate all of the cards into separate piles (using the diamonds, hearts, clubs and spades stored properties). Use filter. Also, use filter four times in a row (yes I know it's not efficient). Don't look to solve this problem using a for-in statement. -->DONE
        diamonds = divideSet(cards, .diamonds)
        hearts = divideSet(cards, .hearts)
        clubs = divideSet(cards, .clubs)
        spades = divideSet(cards, .spades)
    }
    
    func orderAllCards() {
        // TODO: All cards in the diamonds, hearts, clubs and spades stored properties should be sorted. As in, [Ace, 2, 3, 4...Q, K]. Note that you won't always have to deal with all 52 cards to sort considering that it's dependent on what cards the user played (at random) from the prior View Controller. Navigate to the Card.swift file and scroll to the bottom to find an extention on an Array. There's a method called sortCards() which you should implement. After implementing that function, you should go through and call sortCards() on all four arrays representing our different piles.-->DONE
        diamonds.sortCards()
        hearts.sortCards()
        clubs.sortCards()
        spades.sortCards()
    }
    
    func calculateScores() {
        // TODO: Create a constant called allPiles, assigning it a value being an Array containing diamonds, hearts, clubs, spades (which are stored properties available on the View Controller. You should then look to go through each pile to then figure out what the total score is for each pile and properly update within the scores dictionary the total score pertaining to that particular suit (as the piles are separated by suit). -->DONE ++ See Card.Swift for getScore implementation on [Card]
        let allPiles = [diamonds, hearts, clubs, spades]
        allPiles.forEach({
            guard let mySuit = $0.first?.suit else {return}
            scores[mySuit] = $0.getScore()
        })
        // TODO: In your implementation of this function, you should only have to use forEach and reduce. You are not allowed to use a for-in loop.-->DONE
    }
    
    func printAllPiles() {
        print("Diamonds: \(diamonds)")
        print("Hearts: \(hearts)")
        print("Spades: \(spades)")
        print("Clubs: \(clubs)")
        print("Scores: \(scores)")
        print("--------------------\n")
    }
}

// MARK: - Helper Methods
extension CardDetailViewController {
    
    func setupDismissButton() {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        button.frame = view.frame
        view.insertSubview(button, belowSubview: containerView)
        
    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    func divideSet(_ cardsToFilter: [Card], _ suit: Suit) -> [Card] {
        return cardsToFilter.filter({$0.suit == suit})
    }
}
