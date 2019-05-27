//
//  Copyright (c) 2019 shinren.pan@gmail.com All rights reserved.
//

import UIKit

final class FadeSegue: UIStoryboardSegue
{
    override func perform()
    {
        destination.dismissAnimator = FadeAnimator(root: destination)
        source.present(destination, animated: true)
    }
}
