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

    let lineHeight: CGFloat = 1.5

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

    func setHighlight(_ text: NSAttributedString, range: NSRange) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight

        if range.length > 0 {
            let attributedString = NSMutableAttributedString(attributedString: text)
            attributedString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.yellow, range: range)
            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
            selectedRange = NSRange()
        }
    }

    func clearHighlight() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight

        let attributedString = NSMutableAttributedString(attributedString: attributedText)
        attributedString.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.clear, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
        selectedRange = NSRange()
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(highlight) || action == #selector(share) || action == #selector(copyText) {
            return true
        }
        return false
    }
}
