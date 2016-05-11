defineClass("XRTableViewController",{ 
   tableView_didSelectRowAtIndexPath:funtion(tableView, indexPath){
   var row = indexPath.row()
   if(self.dataSource().length > row){
	var content = self.dataArr()[row];
	var controller = XRViewController.alloc().initWithContent(content);
	self.navagationController().pushViewController(controller);
    }
  }
})
