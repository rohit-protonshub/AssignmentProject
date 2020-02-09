//
//  UserCell.swift
//  SDLabsTest
//
//  Created by Lokesh Dudhat on 09/02/20.
//  Copyright © 2020 example. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    let spaceOfView = CGFloat(32)
    let spaceOfImage = CGFloat(16)
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewImages: UIStackView!
    var user: UserModel? {
        didSet {
            if let user = user {
                lblTitle.text = user.name
                imgUser.sd_setImage(with: URL(string: user.image))
                for vw in stackViewImages.arrangedSubviews {
                    stackViewImages.removeArrangedSubview(vw)
                    vw.removeFromSuperview()
                }
                var isHalf = true
                if user.items.count % 2 == 1 {
                    isHalf = false
                    let imgView = getImageView(isHalf: false)
                    let stackView = UIStackView(arrangedSubviews: [imgView])
                    stackView.axis = .horizontal
                    
                    stackView.clipsToBounds = true
                    self.stackViewImages.addArrangedSubview(stackView)
                    imgView.sd_setImage(with: URL(string: user.items[0]))
                    
                    let contraint = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: (UIScreen.main.bounds.size.width - spaceOfView))
                    stackView.addConstraint(contraint)
    
                }
                let rows = (user.items.count - (isHalf ? 0 : 1)) / 2
                for row in 0..<rows {
                    let imgView1 = getImageView(isHalf: true)
                    let imgView2 = getImageView(isHalf: true)

                    let stackView = UIStackView(arrangedSubviews: [imgView1, imgView2])
                    stackView.axis = .horizontal
                    stackView.spacing = spaceOfImage
                    let contraint = NSLayoutConstraint(item: stackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: (UIScreen.main.bounds.size.width - (spaceOfView + spaceOfImage)) / 2)
                    stackView.addConstraint(contraint)
                    stackView.clipsToBounds = true
                    self.stackViewImages.addArrangedSubview(stackView)
                    let count = (row * 2) + (isHalf ? 0 : 1)
                    imgView1.sd_setImage(with: URL(string: user.items[count]))
                    imgView2.sd_setImage(with: URL(string: user.items[count + 1]))
                    
                }
                constraintHeight.constant = CGFloat(rows *  Int((UIScreen.main.bounds.size.width - (spaceOfView + spaceOfImage)) / 2)) + (isHalf ? 0 : (UIScreen.main.bounds.size.width - spaceOfView))
            }
            else {
                imgUser.image = nil
                lblTitle.text = ""
                for vw in stackViewImages.arrangedSubviews {
                    stackViewImages.removeArrangedSubview(vw)
                    vw.removeFromSuperview()
                }
            }
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgUser.image = nil
        lblTitle.text = ""
        for vw in stackViewImages.arrangedSubviews {
            stackViewImages.removeArrangedSubview(vw)
            vw.removeFromSuperview()
        }
    }
    
    func getImageView(isHalf: Bool = true) -> UIImageView {
        let width = isHalf ? (UIScreen.main.bounds.size.width - (spaceOfView + spaceOfImage)) / 2 : (UIScreen.main.bounds.size.width - spaceOfView)
        let imgView = UIImageView()
        imgView.backgroundColor = .lightGray
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        let contraintHeight = NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: width)
        let contraintWidth = NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
        imgView.addConstraints([contraintWidth,contraintHeight])
        return imgView
    }
}
