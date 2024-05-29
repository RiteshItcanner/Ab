//
//  MyCustomLabel.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 21/05/24.
//

import Foundation
import UIKit

//MARK: - SubTitle

class MyLabelReg16Black: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.regularSize16
        textColor = UIColor.black
    }
}

class MyLabelMedium16Black: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.mediumSize16
        textColor = UIColor.black
    }
}

class MyLabelMedium16Blue: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.mediumSize16
        textColor = UIColor(displayP3Red: 2.0/255.0, green: 34.0/255.0, blue: 116.0/255.0, alpha: 1.0)
    }
}

class MyLabelReg14Black: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.regularSize14
        textColor = UIColor.black
    }
}

class MyLabelReg14LightBlack: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.regularSize14
        textColor = UIColor(displayP3Red: 90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0)
    }
}

class MyLabelMedium20Black: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.mediumSize20
        textColor = UIColor.black
    }
}

class MyOutfitLabelMedium22ThemeColor: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = UIFont(name:"Outfit-Medium",size:22)
//        textColor = AppColors.header_ThemeColor
    }
}

class MyLabelMedium16White: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.mediumSize16
        textColor = UIColor.white
    }
}

class MyLabelReg14White: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
//        text = text?.localized
        font = FontSize.regularSize14
        textColor = UIColor.white
    }
}
