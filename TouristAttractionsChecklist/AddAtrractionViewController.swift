//
//  AddAtrractionViewController.swift
//  TouristAttractionsChecklist
//
//  Created by Student on 2018-01-30.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit


protocol AddAtrractionVCDelegate: class {

    func addAtrractionVCDidCancel()
    func addAtrractionVC( _ control: AddAtrractionViewController,
                          didFinishAdd item: ChecklistItem)
    func addAttractionVC( _ control: AddAtrractionViewController,
                        didFinishEdit item: ChecklistItem)

}

class AddAtrractionViewController: UITableViewController {
    
    @IBOutlet weak var textfield: UITextField!
    
    weak var delegate:AddAtrractionVCDelegate?
      var itemtoEdit:ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let item = itemtoEdit {
//            textfield.text = item.text
//            self.title = "Edit Item"
//        } else
//
//        {
//            title = "Add Item"
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    weak var delegate:AddAtrractionVCDelegate?
//    var itemtoEdit:ChecklistItem?
//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func done(_ sender: UIBarButtonItem) {
         //print("Contents of the text field: \(textfield.text!)")
        //if edit, extract the text, call delegate method FinishedEditing otherwise do add new item
        if let item = itemtoEdit {
            item.text = textfield.text!
            delegate?.addAtrractionVC(self, didFinishAdd: item)
        } else {
            //extract the textfield content
            let text = textfield.text!
            //make a new checklistitem object
            let item = ChecklistItem(text:text, checked:false)
            //send it back to the upper stream VC
            delegate?.addAtrractionVC(self, didFinishAdd: item)
        }
       
        
        //navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
       delegate?.addAtrractionVCDidCancel()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
