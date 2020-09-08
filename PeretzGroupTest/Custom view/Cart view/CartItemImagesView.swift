//
//  CartItemImagesView.swift
//  PeretzGroupTest
//
//  Created by Eldar on 05.09.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit
import Kingfisher

class CartItemImagesView: UIView {

    var maxItemsCount = 3
    
    private var images: [RetrieveImageResult] = [] {
        didSet {
            setupImages()
        }
    }
    
    public func setItem(with order: MenuModel) {
        guard let url = URL(string: order.image) else { return }
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] (result) in
            switch result {
            case .success(let imageResult):
                self?.images.append(imageResult)
                
            case .failure(_): break
            }
        }
    }
    
    public func dropItem(_ order: MenuModel) {
        if let index = images.firstIndex(where: { $0.originalSource.url == URL(string: order.image )}) {
            images.remove(at: index)
        }
    }
    
    private func setupImages() {
        subviews.forEach { $0.removeFromSuperview() }
        
        let maxIndex = min(maxItemsCount, max(images.count, images.count - maxItemsCount))
        for index in 0..<maxIndex {
            let imageResult = images.count >= maxItemsCount
                        ? Array(images.suffix(maxItemsCount))[index]
                        : images[index]
            let imageView = UIImageView(image: imageResult.image)
            let width = bounds.width / CGFloat(maxItemsCount)
            let xPos = index == 0 ? 0 : width / 3 * CGFloat(index)
            imageView.frame = CGRect(x: xPos, y: 0, width: width, height: width)
            imageView.layer.cornerRadius = width / 2
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 0.5
            imageView.layer.borderColor = UIColor(hexString: "#686868").cgColor
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
        }
    }
    
}
