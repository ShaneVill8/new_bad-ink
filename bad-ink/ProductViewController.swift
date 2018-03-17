//
//  ProductViewController.swift
//  bad-ink
//
//  Created by David Twyman on 3/16/18.
//  Copyright © 2018 bad-ink. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    var dataFromPrev : product!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var cartButton: UIButton!
    @IBOutlet var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picture.image = dataFromPrev.image
        name.text = dataFromPrev.name
        price.text = "$" + String(dataFromPrev.cost)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "newBackground.png")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addToCart(_ sender: Any) {
        shoppingCart.append(dataFromPrev)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
