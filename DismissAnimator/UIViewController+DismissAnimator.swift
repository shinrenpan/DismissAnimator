//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import UIKit

public extension UIViewController
{
    private struct AssociatedKey
    {
        static var DismissAnimator = "DismissAnimator"
    }

    var dismissAnimator: DismissAnimator?
    {
        get
        {
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.DismissAnimator
            ) as? DismissAnimator
        }
        set
        {
            objc_setAssociatedObject(
                self,
                &AssociatedKey.DismissAnimator,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
