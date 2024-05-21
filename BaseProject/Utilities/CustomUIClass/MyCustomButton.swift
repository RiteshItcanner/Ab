//
//  MyCustomButton.swift
//  BaseProject
//
//  Created by Ritesh Sinha on 21/05/24.
//

import Foundation
import UIKit

class MyCustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        titleLabel?.text = titleLabel?.text?.localized
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView() {
        self.titleLabel?.font = FontSize.mediumSize16
        self.titleLabel?.textColor = .white
        self.backgroundColor = UIColor(red: 2/255, green: 34/255, blue: 116/255, alpha: 1.0)
        self.layer.cornerRadius = 8
    }
    
}

class MyNormalButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        titleLabel?.text = titleLabel?.text?.localized
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView() {
        self.titleLabel?.font = FontSize.regularSize14
        self.titleLabel?.textColor = .black
        
    }
    
}
