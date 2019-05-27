//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import DismissAnimator

final class PushAnimator: DismissAnimator {}

extension PushAnimator
{
    override func handlePresentAnimation(
        context: UIViewControllerContextTransitioning,
        fromView: UIView,
        toView: UIView
    )
    {
        // Don't call super

        toView.frame.origin.x = toView.frame.width
        context.containerView.addSubview(toView)

        let animations = {
            fromView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            toView.frame.origin.x = 0.0
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

    override func handleDismissAnimation(
        context: UIViewControllerContextTransitioning,
        fromView: UIView,
        toView: UIView
    )
    {
        // Don't call super

        context.containerView.insertSubview(toView, belowSubview: fromView)

        let animations = {
            toView.transform = CGAffineTransform.identity
            fromView.frame.origin.x = fromView.frame.width
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
