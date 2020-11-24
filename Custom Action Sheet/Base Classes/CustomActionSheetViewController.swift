//
//  CustomActionSheetViewController.swift
//  Custom Action Sheet
//
//  Created by Avinash Dongarwar on 11/19/20.
//  Copyright © 2020 Avinash Dongarwar. All rights reserved.
//

import UIKit

public protocol CustomActionSheetPresentable {
    var cornerRadius: CGFloat { get set }
    var animationTransitionDuration: TimeInterval { get set }
    var backgroundColor: UIColor { get set }
}

public class CustomActionSheetViewController: UIViewController {
    @IBOutlet weak private var contentView: UIView!
    @IBOutlet weak private var contentViewBottomConstraint: NSLayoutConstraint!

    private let viewModel: CustomActionSheetPresentable
    private let childViewController: UIViewController
    private var originBeforeAnimation: CGRect = .zero

    // MARK: - Initialization

    public init(viewModel: CustomActionSheetPresentable, childViewController: UIViewController) {
        self.viewModel = viewModel
        self.childViewController = childViewController
        super.init(
            nibName: String(describing: CustomActionSheetViewController.self),
            bundle: Bundle(for: CustomActionSheetViewController.self)
        )
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        contentView.alpha = 1
        configureChild()

        let gesture = UIPanGestureRecognizer(target: self, action: #selector(CustomActionSheetViewController.panGesture))
        contentView.addGestureRecognizer(gesture)
        gesture.delegate = self

        contentViewBottomConstraint.constant = -childViewController.view.frame.height
        view.layoutIfNeeded()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentViewBottomConstraint.constant = 0
        UIView.animate(withDuration: viewModel.animationTransitionDuration) {
            self.view.backgroundColor = self.viewModel.backgroundColor
            self.view.layoutIfNeeded()
        }
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.roundCorners([.topLeft, .topRight], radius: viewModel.cornerRadius)
        originBeforeAnimation = contentView.frame
    }
}

// MARK: - Public interface

extension CustomActionSheetViewController {
    public func dismissViewController() {
        contentViewBottomConstraint.constant = -childViewController.view.frame.height
        UIView.animate(withDuration: viewModel.animationTransitionDuration, animations: {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = .clear
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
        })
    }
}

// MARK: - Private interface

private extension CustomActionSheetViewController {

    private func configureChild() {
        addChild(childViewController)
        contentView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)

        guard let childSuperView = childViewController.view.superview else { return }

        NSLayoutConstraint.activate([
            childViewController.view.bottomAnchor.constraint(equalTo: childSuperView.bottomAnchor),
            childViewController.view.topAnchor.constraint(equalTo: childSuperView.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: childSuperView.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: childSuperView.rightAnchor)
        ])

        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }

    private func shouldDismissWithGesture(_ recognizer: UIPanGestureRecognizer) -> Bool {
        return recognizer.state == .ended
    }

    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: view)

        if shouldDismissWithGesture(recognizer) {
            dismissViewController()
        } else {
            if point.y <= originBeforeAnimation.origin.y {
                recognizer.isEnabled = false
                recognizer.isEnabled = true
                return
            }
            contentView.frame = CGRect(x: 0, y: point.y, width: view.frame.width, height: view.frame.height)
        }
    }
}

// MARK: - Event handling

extension CustomActionSheetViewController: UIGestureRecognizerDelegate {

    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {

        return false
    }

    @IBAction private func topViewTap(_ sender: Any) {
        dismissViewController()
    }
}
