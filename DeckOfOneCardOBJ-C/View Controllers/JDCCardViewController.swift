//
//  JDCCardViewController.swift
//  DeckOfOneCardOBJ-C
//
//  Created by jdcorn on 12/3/19.
//  Copyright © 2019 jdcorn. All rights reserved.
//

import UIKit

class JDCCardViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var drawCardButton: UIButton!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCards()
    }
    
    // MARK: - Actions
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        fetchCards()
    }
    
    // MARK: - Functions
    
    func fetchCards() {
        JDCCardController.drawNewCard(1) { (cards)  in
            if let cards = cards {
                JDCCardController.fetchCardImage(cards[0]) { (cardImage) in
                    DispatchQueue.main.async {
                        if let cardImage = cardImage {
                            self.updateViews(card: cards[0], image: cardImage)
                        }
                    }
                }
            }
        }
    }
    
    func updateViews(card: JDCCard, image: UIImage) {
        self.cardImageView.image = image
        self.suitLabel.text = card.suit
    }
    
}
