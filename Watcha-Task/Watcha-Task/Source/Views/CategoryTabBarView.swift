//
//  CategoryTabBarView.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/09.
//

import UIKit

protocol CategoryTabBarDelegate {
    func touchUpTabButton(state: ImageState)
}

class CategoryTabBarView: UIView {
    // MARK:- Layout
    private var gifButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GIFs", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(touchUpGIFButton), for: .touchUpInside)
        return button
    }()
    
    private var stickerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sticker", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(touchUpStickerButton), for: .touchUpInside)
        return button
    }()
    
    private var indicatorBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cyan
        return view
    }()
    
    // MARK:- Member
    public var searchState: ImageState = .gif {
        willSet (newValue) {
            if newValue != searchState {
                moveToIndicatorBar(to: newValue)
                UIView.animate(withDuration: 0.1) {
                    self.layoutIfNeeded()
                }
                
                delegate.touchUpTabButton(state: newValue)
            }
        }
    }
    public var delegate: CategoryTabBarDelegate!
    private var indicatorConstraint: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initLayout()
    }
    
    private func initLayout() {
        self.addSubview(gifButton)
        self.addSubview(stickerButton)
        self.addSubview(indicatorBar)
        
        NSLayoutConstraint.activate([
            gifButton.topAnchor.constraint(equalTo: topAnchor),
            gifButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            gifButton.trailingAnchor.constraint(equalTo: centerXAnchor),
            gifButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stickerButton.topAnchor.constraint(equalTo: topAnchor),
            stickerButton.leadingAnchor.constraint(equalTo: centerXAnchor),
            stickerButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            stickerButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorBar.heightAnchor.constraint(equalToConstant: 5),
            indicatorBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
        
        moveToIndicatorBar(to: .gif)
    }
    
    @objc private func touchUpGIFButton() {
        searchState = .gif
    }
    
    @objc private func touchUpStickerButton() {
        searchState = .sticker
    }
    
    private func moveToIndicatorBar(to state: ImageState) {
        NSLayoutConstraint.deactivate(indicatorConstraint)
        
        if state == .gif {
            indicatorConstraint = [
                indicatorBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                indicatorBar.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20)
            ]
        }
        else {
            indicatorConstraint = [
                indicatorBar.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 20),
                indicatorBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ]
        }
        
        NSLayoutConstraint.activate(indicatorConstraint)
    }
}
