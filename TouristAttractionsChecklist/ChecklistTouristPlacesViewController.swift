//
//  ChecklistTouristPlacesViewController.swift
//  TouristAttractionsChecklist
//
//  Created by Student on 2018-01-29.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ChecklistTouristPlacesViewController: UITableViewController{

    var checklist : [ChecklistItem] = [ChecklistItem]()
        
//        [ ChecklistItem(text:"canadaplce", checked: false),
//          ChecklistItem(text:"buchar garden",checked: true),
//          ChecklistItem(text:"stanley park", checked: false),
//          ChecklistItem(text:"abc",checked: true)]
//
    override func viewDidLoad() {
        super.viewDidLoad()
       //loadChecklist()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let item = ChecklistItem(text:"stanley Park", checked: false , location:"Vancouver")
        let newRow = checklist.count;
        checklist.append(item)
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checklist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let newchecklist =  checklist[indexPath.row]

        // Configure the cell...
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = newchecklist.text
        
//        if indexPath.row == 0 {
//            label.text = "Walk the dog"
//        } else if indexPath.row == 1 {
//            label.text = "Brush my teeth"
//        } else if indexPath.row == 2 {
//            label.text = "Learn iOS development"
//        } else if indexPath.row == 3 {
//            label.text = "Soccer practice"
//        } else if indexPath.row == 4 {
//            label.text = "Eat ice cream"
//        }
       return cell
  }
    

//    override func tableView(_ tableView: UITableView,
//                            didSelectRowAt indexPath: IndexPath) {
//
//        if let cell = tableView.cellForRow(at: indexPath) {
//            if cell.accessoryType == .none {
//                cell.accessoryType = .checkmark
//            } else {
//                cell.accessoryType = .none
//            }
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            checklist.remove(at: indexPath.row)
            saveChecklist()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let checkmarklabel = cell.viewWithTag(1001) as! UILabel
            if (checkmarklabel.text == "√") {
                checkmarklabel.text = ""
            } else {
                checkmarklabel.text = "√"
            }
        }
    }
    

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //who is my down stream VC
        //I will be its delegate
        if (segue.identifier == "AddItem") {
            let controller = segue.destination as! AddAtrractionViewController
            controller.delegate = self as? AddAtrractionVCDelegate
        } else if (segue.identifier == "EditItem") {
            let controller = segue.destination as! AddAtrractionViewController
            //identify which cell was touched on
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            //extract the data / text
            let item = checklist[indexPath!.row]
            //send the data to ItemDetailsVC
            controller.itemtoEdit = item
        }
    }
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        print(documentDirectory())
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklist() {
        //get an encoder
        let encoder = PropertyListEncoder()
        //encode
        do {
            let data = try encoder.encode(checklist)
            //write the encoded data to the dataFilePath
            try data.write(to: dataFilePath())
        } catch {
            print("Encoding error")
        }
        
    }
    
    func addAtrractionVCDidCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func addAttractionVC(_ control: AddAtrractionViewController, didFinishAdd item: ChecklistItem) {
        //append the item to checklist
        //update the tableview
        let newRow = checklist.count;
        checklist.append(item)
        saveChecklist()
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addAttractionVC(_ control: AddAtrractionViewController, didFinishEdit item: ChecklistItem) {
        //update the data source
        if let index = checklist.index(of: item) {
            checklist[index].text = item.text
            saveChecklist()
            let indexpath = IndexPath(row: index, section: 0)
            //update the table view
            if let cell = tableView.cellForRow(at: indexpath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = item.text
            }
        }
        
   }
}
