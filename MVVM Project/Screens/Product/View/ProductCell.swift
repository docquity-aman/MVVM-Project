//
//  ProductCell.swift
//  MVVM Project
//
//  Created by Aman Verma on 08/02/23.
//

import UIKit

class ProductCell: UITableViewCell {

//    @IBOutlet weak var productBackgroundView: ProductCell!
    @IBOutlet weak var productBackGroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productDecriptionLabel: UILabel!
    @IBOutlet weak var productBuyButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    var product:Product?{
        didSet{
            productDetailConfiguration()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func productDetailConfiguration(){
        guard let product else{return}
        productTitleLabel.text=product.title
        productCategoryLabel.text=product.category
        productDecriptionLabel.text=product.description
        productPriceLabel.text="$\(product.price)"
        rateButton.setTitle("\(product.rating.rate)", for: .normal)
        productImageView.setImage(with: product.image)
    }
    
}
