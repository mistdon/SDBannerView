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

import Foundation
import MapKit

struct VacationSpot {
  let identifier: Int
  let name: String
  let locationName: String
  let thumbnailName: String
  let whyVisit: String
  let whatToSee: String
  let weatherInfo: String
  let userRating: Int
  let wikipediaURL: NSURL
  let coordinate: CLLocationCoordinate2D
}

// MARK: - Support for loading data from plist

extension VacationSpot {

  static func loadAllVacationSpots() -> [VacationSpot] {
    return loadVacationSpotsFromPlistNamed("vacation_spots")
  }

  private static func loadVacationSpotsFromPlistNamed(plistName: String) -> [VacationSpot] {
    guard
      let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist"),
      let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
      else {
        fatalError("An error occurred while reading \(plistName).plist")
    }

    var vacationSpots = [VacationSpot]()

    for dict in dictArray {
      guard
        let identifier    = dict["identifier"]    as? Int,
        let name          = dict["name"]          as? String,
        let locationName  = dict["locationName"]  as? String,
        let thumbnailName = dict["thumbnailName"] as? String,
        let whyVisit      = dict["whyVisit"]      as? String,
        let whatToSee     = dict["whatToSee"]     as? String,
        let weatherInfo   = dict["weatherInfo"]   as? String,
        let userRating    = dict["userRating"]    as? Int,
        let wikipediaLink = dict["wikipediaLink"] as? String,
        let latitude      = dict["latitude"]      as? Double,
        let longitude     = dict["longitude"]     as? Double
        else {
          fatalError("Error parsing dict \(dict)")
      }

      let wikipediaURL = NSURL(string: wikipediaLink)!
      let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
      let vacationSpot = VacationSpot(
        identifier: identifier,
        name: name,
        locationName: locationName,
        thumbnailName: thumbnailName,
        whyVisit: whyVisit,
        whatToSee: whatToSee,
        weatherInfo: weatherInfo,
        userRating: userRating,
        wikipediaURL: wikipediaURL,
        coordinate: coordinate
      )

      vacationSpots.append(vacationSpot)
    }

    return vacationSpots
  }
}
