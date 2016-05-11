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
import MapKit

class SpotsViewController: UITableViewController {

  var vacationSpots = [VacationSpot]()

  // MARK: - Lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()

    vacationSpots = VacationSpot.loadAllVacationSpots()
  }

  // MARK: - UITableViewDataSource

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return vacationSpots.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("VacationSpotCell", forIndexPath: indexPath) as! VacationSpotCell
    let vacationSpot = vacationSpots[indexPath.row]
    cell.nameLabel.text = vacationSpot.name
    cell.locationNameLabel.text = vacationSpot.locationName
    cell.thumbnailImageView.image = UIImage(named: vacationSpot.thumbnailName)

    return cell
  }

  // MARK: - Navigation

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let selectedCell = sender as? UITableViewCell, selectedRowIndex = tableView.indexPathForCell(selectedCell)?.row
      where segue.identifier == "showSpotInfoViewController" else {
        fatalError("sender is not a UITableViewCell or was not found in the tableView, or segue.identifier is incorrect")
    }

    let vacationSpot = vacationSpots[selectedRowIndex]
    let detailViewController = segue.destinationViewController as! SpotInfoViewController
    detailViewController.vacationSpot = vacationSpot
  }
}
