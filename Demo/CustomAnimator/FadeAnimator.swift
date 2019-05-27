//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import DismissAnimator

final class FadeAnimator: DismissAnimator {}

extension FadeAnimator
{
    override func handlePresentAnimation(
        context: UIViewControllerContextTransitioning,
        fromView: UIView,
        toView: UIView
    )
    {
        // Don't call super

        toView.alpha = 0.0
        context.containerView.addSubview(toView)

        let animations = {
            toView.alpha = 1.0
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
            fromView.alpha = 0.0
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
