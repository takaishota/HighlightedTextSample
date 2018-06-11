//
//  CustomTextView.swift
//  HighlightedTextSample
//
//  Created by 高井　翔太 on 2018/06/11.
//  Copyright © 2018年 Medley, inc. All rights reserved.
//

import UIKit

protocol CustomMenuTextViewDelegate: class {
    func didSelectHighlightMenu()
    func didSelectShareMenu()
    func didSelectCopyMenu()
}

class CustomMenuTextView: UITextView {
    override var canBecomeFirstResponder: Bool { return true }
    weak var customMenuDelegate: CustomMenuTextViewDelegate?

    init(frame:CGRect) {
        super.init(frame: frame, textContainer: nil)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupMenuController()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(highlight) || action == #selector(share) || action == #selector(copyText) {
            return true
        }
        return false
    }

    private func setupMenuController() {
        let menuItem_highlight = UIMenuItem(title: "ハイライト", action: #selector(highlight))
        let menuItem_share = UIMenuItem(title: "シェア", action: #selector(share))
        let menuItem_copyText = UIMenuItem(title: "コピー", action: #selector(copyText))

        let menuController = UIMenuController.shared
        menuController.setTargetRect(.zero, in: self)
        menuController.menuItems = [menuItem_highlight, menuItem_share, menuItem_copyText]
    }

    @objc private func highlight() {
        customMenuDelegate?.didSelectHighlightMenu()
    }

    @objc private func share() {
        customMenuDelegate?.didSelectShareMenu()
    }

    @objc private func copyText() {
        customMenuDelegate?.didSelectCopyMenu()
    }
}
