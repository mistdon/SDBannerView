require('JPViewController');
defineClass('JPTableViewController', {
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            NSLog("indexPath.row = %ld", (long) indexPath.row());
            if (self.dataSource().count() > indexPath.row()) {
            var content = self.dataSource[indexPath().row()]; //可能会超出数组范围导致crash
            var ctrl = JPViewController.alloc().initWithContent(content);
            self.navigationController().pushViewController_animated(ctrl, YES);
            }
            },
            });
