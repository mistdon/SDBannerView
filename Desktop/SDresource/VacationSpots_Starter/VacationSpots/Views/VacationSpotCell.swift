/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class VacationSpotCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationNameLabel: UILabel!
  @IBOutlet weak var thumbnailImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()

    // 1
    let layoutGuide = UILayoutGuide()
    contentView.addLayoutGuide(layoutGuide)

    // 2
    let topConstraint = layoutGuide.topAnchor
      .constraintEqualToAnchor(nameLabel.topAnchor)

    // 3
    let bottomConstraint = layoutGuide.bottomAnchor
      .constraintEqualToAnchor(locationNameLabel.bottomAnchor)

    // 4
    let centeringConstraint = layoutGuide.centerYAnchor
      .constraintEqualToAnchor(contentView.centerYAnchor)

    // 5
    NSLayoutConstraint.activateConstraints(
      [topConstraint, bottomConstraint, centeringConstraint])
  }
}
