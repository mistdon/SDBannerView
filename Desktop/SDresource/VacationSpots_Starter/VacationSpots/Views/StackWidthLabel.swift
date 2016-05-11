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

class StackWidthLabel: UILabel {

  override func layoutSubviews() {
    super.layoutSubviews()

    // UILabel's preferredMaxLayoutWidth currently does not update automatically if the label is contained within a UIStackView
    // It instead adopts the width of the label from its frame in the storyboard which can lead to an incorrect number of lines

    // Uncomment the following line to observe the preferredMaxLayoutWidth be equal to the label's frame from the storyboard
    // print("Updating preferredMaxLayoutWidth from: \(preferredMaxLayoutWidth) to: \(bounds.width) for label with text: \(text!.substringToIndex(advance(text!.startIndex, 30)))...")

    preferredMaxLayoutWidth = bounds.width
  }
}
