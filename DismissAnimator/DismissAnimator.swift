//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import UIKit

open class DismissAnimator: UIPercentDrivenInteractiveTransition
{
    public var animationDuration: TimeInterval
    {
        return _duration
    }

    private weak var _viewController: UIViewController?
    private var _interacting = false
    private var _duration: TimeInterval

    public init(
        root: UIViewController,
        duration: TimeInterval = 0.25
    )
    {
        _duration = duration
        super.init()
        let screenGesture = UIScreenEdgePanGestureRecognizer()
        screenGesture.edges = .left
        screenGesture.addTarget(self, action: #selector(__handelScreenGesture(_:)))
        root.view.addGestureRecognizer(screenGesture)
        root.transitioningDelegate = self
        _viewController = root
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension DismissAnimator: UIViewControllerAnimatedTransitioning
{
    public func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval
    {
        return _duration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let fromView = fromVC.view,
            let toVC = transitionContext.viewController(forKey: .to),
            let toView = toVC.view,
            let viewController = _viewController
        else
        {
            return
        }

        if fromVC === viewController
        {
            handleDismissAnimation(context: transitionContext, fromView: fromView, toView: toView)
        }
        else
        {
            handlePresentAnimation(context: transitionContext, fromView: fromView, toView: toView)
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension DismissAnimator: UIViewControllerTransitioningDelegate
{
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }

    public func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning?
    {
        return self
    }

    public func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning?
    {
        return _interacting ? self : nil
    }
}

// MARK: - Open

extension DismissAnimator
{
    @objc open func handlePresentAnimation(
        context: UIViewControllerContextTransitioning,
        fromView: UIView,
        toView: UIView
    )
    {
        toView.frame.origin.y = toView.frame.height
        context.containerView.addSubview(toView)

        let animations = {
            toView.frame.origin.y = 0
        }

        let completion = { (_: Bool) -> Void in
            context.completeTransition(!context.transitionWasCancelled)
        }

        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseOut,
            animations: animations,
            completion: completion
        )
    }

    @objc open func handleDismissAnimation(
        context: UIViewControllerContextTransitioning,
        fromView: UIView,
        toView: UIView
    )
    {
        context.containerView.insertSubview(toView, belowSubview: fromView)

        let animations = {
            fromView.frame.origin.y = fromView.frame.height
        }

        let completion = { (_: Bool) -> Void in
            context.completeTransition(!context.transitionWasCancelled)
        }

        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseOut,
            animations: animations,
            completion: completion
        )
    }
}

// MARK: - Private

private extension DismissAnimator
{
    @objc final func __handelScreenGesture(_ sender: UIScreenEdgePanGestureRecognizer)
    {
        let view = sender.view!
        let percent = sender.translation(in: view).x / view.bounds.size.width

        switch sender.state
        {
            case .began:
                _interacting = true
                _viewController?.dismiss(animated: true)
            case .changed:
                update(percent)
            case .ended:
                _interacting = false
                percent > 0.5 ? finish() : cancel()
            default:
                _interacting = false
        }
    }
}
