//
//  TableController.swift
//  MyAlbum
//
//  Created by nju on 2021/12/21.
//

import UIKit

class TableController: UITableViewController {
    var tagGroups: [TagGroup] = []
    var otherGroup: TagGroup = TagGroup(name: "Others", include: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagGroups.append(TagGroup(name: "Fruits", include: ["apple", "banana", "grape", "orange", "pineapple", "strawberry", "watermelon"]))
        tagGroups.append(TagGroup(name: "Vegtables", include: ["carrot"]))
        tagGroups.append(TagGroup(name: "Snacks", include: ["cake", "candy", "cookie", "doughnut", "hot dog", "ice cream", "juice", "popcorn", "pretzel", "salad", "waffle"]))
        
        tagGroups[0].tags.append(Tag(name: "apple"))
        tagGroups[0].tags[0].photoList.append(UIImage())
        
        tagGroups[1].tags.append(Tag(name: "carrot"))
        tagGroups[1].tags[0].photoList.append(UIImage())
        
        tagGroups[2].tags.append(Tag(name: "cake"))
        tagGroups[2].tags[0].photoList.append(UIImage())
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        tagGroups.sort(by: {$0.name < $1.name})
        return tagGroups.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section){
        case 0 ..< tagGroups.count:
            tagGroups[section].tags.sort(by: {$0.name < $1.name})
            return tagGroups[section].tags.count
        case tagGroups.count:
            otherGroup.tags.sort(by: {$0.name < $1.name})
            return otherGroup.tags.count
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell", for: indexPath)

        let section = indexPath.section
        let row = indexPath.row
        
        switch(section){
        case 0 ..< tagGroups.count:
            let tag = tagGroups[section].tags[row]
            cell.textLabel?.text = tag.name
            cell.detailTextLabel?.text = String(tag.photoList.count)
        case tagGroups.count:
            let tag = otherGroup.tags[row]
            cell.textLabel?.text = tag.name
            cell.detailTextLabel?.text = String(tag.photoList.count)
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0 ..< tagGroups.count:
            return tagGroups[section].name
        case tagGroups.count:
            return otherGroup.name
        default:
            return ""
        }
    }
    
    @IBAction func unwindWithConfirm(unwindSegue: UIStoryboardSegue){
        if let addController = unwindSegue.source as? AddPhotoController,
           let tag = addController.tag,
            let image = addController.image{
            for i in 0..<tagGroups.count{
                if tagGroups[i].include.contains(tag){
                   
                    addToGroup(tagGroup: &tagGroups[i], image: image, tag: tag)
                    tableView.reloadSections([i], with: .fade)
                    return
                }
            }
            
            addToGroup(tagGroup: &otherGroup, image: image, tag: tag)
            tableView.reloadSections([tagGroups.count], with: .fade)
        }
        
    }

    @IBAction func unwindWithCancel(unwindSegue: UIStoryboardSegue){
        
    }
                    
    func addToGroup(tagGroup: inout TagGroup, image: UIImage, tag: String){
        for i in 0..<tagGroup.tags.count{
            if(tagGroup.tags[i].name == tag){
                tagGroup.tags[i].photoList.append(image)
                return
            }
        }
        var newTag = Tag(name: tag)
        newTag.photoList.append(image)
        tagGroup.tags.append(newTag)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
