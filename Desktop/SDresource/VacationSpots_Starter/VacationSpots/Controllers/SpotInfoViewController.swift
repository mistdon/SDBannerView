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
import SafariServices

class SpotInfoViewController: UIViewController {

  var vacationSpot: VacationSpot!

  @IBOutlet var backgroundColoredViews: [UIView]!
  @IBOutlet var headingLabels: [UILabel]!

  @IBOutlet weak var whyVisitLabel: UILabel!
  @IBOutlet weak var whatToSeeLabel: UILabel!
  @IBOutlet weak var weatherInfoLabel: UILabel!
  @IBOutlet weak var userRatingLabel: UILabel!
  @IBOutlet weak var weatherHideOrShowButton: UIButton!
  @IBOutlet weak var submitRatingButton: UIButton!

  var shouldHideWeatherInfoSetting: Bool {
    get {
      return NSUserDefaults.standardUserDefaults().boolForKey("shouldHideWeatherInfo")
    }
    set {
      NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "shouldHideWeatherInfo")
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    // Clear background colors from labels and buttons
    for view in backgroundColoredViews {
      view.backgroundColor = UIColor.clearColor()
    }

    // Set the kerning to 1 to increase spacing between letters
    headingLabels.forEach { $0.attributedText = NSAttributedString(string: $0.text!, attributes: [NSKernAttributeName: 1]) }

    title = vacationSpot.name
    
    whyVisitLabel.text = vacationSpot.whyVisit
    whatToSeeLabel.text = vacationSpot.whatToSee
    weatherInfoLabel.text = vacationSpot.weatherInfo
    userRatingLabel.text = String(count: vacationSpot.userRating, repeatedValue: Character("★"))

    updateWeatherInfoViews(hideWeatherInfo: shouldHideWeatherInfoSetting, animated: false)
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

    let currentUserRating = NSUserDefaults.standardUserDefaults().integerForKey("currentUserRating-\(vacationSpot.identifier)")

    if currentUserRating > 0 {
      submitRatingButton.setTitle("Update Rating (\(currentUserRating))", forState: .Normal)
    } else {
      submitRatingButton.setTitle("Submit Rating", forState: .Normal)
    }
  }

  @IBAction func weatherHideOrShowButtonTapped(sender: UIButton) {
    let shouldHideWeatherInfo = sender.titleLabel!.text! == "Hide"
    updateWeatherInfoViews(hideWeatherInfo: shouldHideWeatherInfo, animated: true)
    shouldHideWeatherInfoSetting = shouldHideWeatherInfo
  }

  func updateWeatherInfoViews(hideWeatherInfo shouldHideWeatherInfo: Bool, animated: Bool) {
    let newButtonTitle = shouldHideWeatherInfo ? "Show" : "Hide"
    weatherHideOrShowButton.setTitle(newButtonTitle, forState: .Normal)

    // TODO: Animate when animated == true
    weatherInfoLabel.hidden = shouldHideWeatherInfo
  }

  @IBAction func wikipediaButtonTapped(sender: UIButton) {
    let safariVC = SFSafariViewController(URL: vacationSpot.wikipediaURL)
    safariVC.delegate = self
    presentViewController(safariVC, animated: true, completion: nil)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    switch segue.identifier! {
    case "presentMapViewController":
      guard let navigationController = segue.destinationViewController as? UINavigationController,
        let mapViewController = navigationController.topViewController as? MapViewController else {
          fatalError("Unexpected view hierarchy")
      }
      mapViewController.locationToShow = vacationSpot.coordinate
      mapViewController.title = vacationSpot.name
    case "presentRatingViewController":
      guard let navigationController = segue.destinationViewController as? UINavigationController,
        let ratingViewController = navigationController.topViewController as? RatingViewController else {
          fatalError("Unexpected view hierarchy")
      }
      ratingViewController.vacationSpot = vacationSpot
    default:
      fatalError("Unhandled Segue: \(segue.identifier!)")
    }
  }
}

// MARK: - SFSafariViewControllerDelegate

extension SpotInfoViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(controller: SFSafariViewController) {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
}
