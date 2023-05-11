//
//  UIView+Extension.swift
//  Ray
//
//  Created by mac on 10.05.2023.
//

import UIKit

public func uiViewBatch(_ views: [UIView], _ operation: (UIView) -> Void) {
  for view in views {
    operation(view)
  }
}

extension UIView {
  public func addSubviews(_ subviews: UIView...) {
    subviews.forEach { self.addSubview($0) }
  }
}
