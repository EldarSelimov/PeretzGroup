//
//  CartItemImagesView.swift
//  PeretzGroupTest
//
//  Created by Eldar on 05.09.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

class CartItemImagesView: UIView {

    var maxItemsCount = 3
    
    private var images: [UIImage] = [] {
        didSet {
            setupImages()
        }
    }
    
    public func setItem(with image: UIImage) {
        images.append(image)
    }
    
    private func setupImages() {
        subviews.forEach { $0.removeFromSuperview() }
        
        let maxIndex = min(maxItemsCount, max(images.count, images.count - maxItemsCount))
        for index in 0..<maxIndex {
            let image = images.count == maxItemsCount
                        ? images.suffix(maxItemsCount)[index]
                        : images[index]
            let imageView = UIImageView(image: image)
            let width = bounds.width / CGFloat(maxItemsCount)
            let xPos = index == 0 ? 0 : width * CGFloat(index) - width / 2
            imageView.frame = CGRect(x: xPos, y: 0, width: width, height: width)
            imageView.layer.cornerRadius = width / 2
            imageView.clipsToBounds = true
            imageView.backgroundColor = .lightGray
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
        }
    }
    
}
