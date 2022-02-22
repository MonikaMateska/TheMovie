//
//  UIKitExtensions.swift
//  TheMovie
//
//  Created by Monika Mateska on 22.2.22.
//

import UIKit

extension UITableView {

    func setEmptyView(message: String) {
        let emptyListView = UIView()
        emptyListView.center = CGPoint(x: self.frame.size.width  / 2,
                                       y: self.frame.size.height / 2)
        
        let image = UIImage(named: "redCarpet")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: emptyListView.center.x - 50,
                                 y: emptyListView.center.y - 100,
                                 width: 100,
                                 height: 100)
        
        emptyListView.addSubview(imageView)
        
        let messageLabel = UILabel(frame: CGRect(x: emptyListView.center.x - 100,
                                                 y: emptyListView.center.y,
                                                 width: self.frame.size.width,
                                                 height: self.frame.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 26)
        messageLabel.sizeToFit()
        emptyListView.addSubview(messageLabel)
        
        self.backgroundView = emptyListView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
}

extension UIImageView {
    
    func imageFromServer(url: URL,
                         placeHolder: UIImage?,
                         completionHandler: @escaping() -> ()) {
        DispatchQueue.main.async { [weak self] in
            self?.image = placeHolder
        }
        
        ImageCache.publicCache.load(url: url as NSURL) { loadedImage in
            if let loadedImage = loadedImage {
                DispatchQueue.main.async { [weak self] in
                    self?.image = loadedImage
                }
            }
            completionHandler()
        }
    }
}
