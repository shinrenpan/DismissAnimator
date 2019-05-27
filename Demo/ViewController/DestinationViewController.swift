//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import UIKit

final class DestinationViewController: UIViewController
{
    @IBOutlet private(set) var swipeLabel: UILabel!
    @IBOutlet private(set) var paddingView: UIView!
}

// MARK: - LifeCycle

extension DestinationViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        __startAnimation()
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        __stopAnimation()
    }
}

// MARK: - IBAction

private extension DestinationViewController
{
    @IBAction final func __dismissButtonClicked(_ sender: UIButton)
    {
        dismiss(animated: true)
    }
}

// MARK: - Private

private extension DestinationViewController
{
    final func __startAnimation()
    {
        paddingView.alpha = 1.0
        swipeLabel.frame.origin.x = 40.0

        UIView.animate(
            withDuration: 0.7,
            delay: 0.0,
            options: [.repeat, .autoreverse, .curveEaseInOut],
            animations: {
                self.paddingView.alpha = 0.0
                self.swipeLabel.frame.origin.x = 0.0
            },
            completion: nil
        )
    }

    final func __stopAnimation()
    {
        swipeLabel.layer.removeAllAnimations()
        swipeLabel.frame.origin.x = 0.0
        paddingView.layer.removeAllAnimations()
        paddingView.alpha = 0.0
    }
}
