//
//  BarButton.swift
//  IAlbums
//
//  Created by Сергей Даровских on 11.02.2022.
//

import UIKit

extension UIViewController {
    func createBarButton(imageSystemName: String, selector: Selector) -> UIBarButtonItem  {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageSystemName), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
