//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import DismissAnimator
import UIKit

final class FromViewController: UIViewController {}

extension FromViewController
{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "presentDestinationViewController"
        {
            let destination = segue.destination
            destination.dismissAnimator = DismissAnimator(root: destination)
        }
    }
}

private extension FromViewController
{
    @IBAction final func __hardCodeButtonClicked(_ sender: UIButton)
    {
        let id = "\(DestinationViewController.self)"
        let toVC = storyboard!.instantiateViewController(withIdentifier: id)
        toVC.dismissAnimator = PushAnimator(root: toVC, duration: 0.3)
        present(toVC, animated: true)
    }
}
