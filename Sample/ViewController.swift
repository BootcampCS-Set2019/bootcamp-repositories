//
//  ViewController.swift
//  Sample
//
//  Created by elton.faleta.santana on 11/10/19.
//  Copyright © 2019 BootcampCS-Set2019. All rights reserved.
//

import UIKit
import Repositories
import Entities

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let local = LocalCardRepository()
        local.getAll()
            .then { (card) in
            print(card, "primeiro")
        }
            .catch { (error) in
                print(error, "error")
        }

        let card = Card()

        local.insert(card: card)
        local.getAll()
            .then { (card) in
            print(card, "segundo")
        }
            .catch { (error) in
                print(error, "error")

        }
    }


}

