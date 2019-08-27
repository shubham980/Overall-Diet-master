//
//  NotesTableViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 14/04/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

/* This class display the notes saved on the phone in the form of table and the notes can be
 expanded in the notes view controller class, also this class provides an option to add new notes and
 updates accordingly to changes made in the existing notes*/

import UIKit

class NotesTableViewController: UITableViewController , NoteViewDelegate {
    
    @IBOutlet var table: UITableView!
    var homeBarButton = UIBarButtonItem()
    
    override func viewWillAppear(_ animated: Bool) {
        // Defining the left navigation bar item
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    //array to store the notes
    //keys = "title" ,"body"
    var arrNotes = [[String: String]]()
    
    //for locating the index value of the note selected
    var selectedNoteindex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //downcasting
        
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String:String]] {
            
            //set the instsance value to the the new note
            arrNotes = newNotes
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of elements in the table, in this case we have taken the from the array
        return arrNotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get the default cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! UITableViewCell
        
        //set the text
        cell.textLabel!.text = arrNotes[indexPath.row]["title"]
        
        //return the updated/modified cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //set the index of the selected row before transition
        self.selectedNoteindex = indexPath.row
        
        //transition using seque
        performSegue(withIdentifier: "showNotesegue", sender: nil)
    }
    
    @IBAction func newNote(){
        
        //new note
        let newAdd = ["title" : "" , "body" : ""]
        
        //adding the note to the array at the top
        arrNotes.insert(newAdd, at: 0)
        
        //set the index value to the recently updated note
        self.selectedNoteindex = 0
        
        //reload the table with the new note
        self.tableView.reloadData()
        
        //push to the the notes view by seque
        performSegue(withIdentifier: "showNotesegue", sender: nil)
        
        //save notes to device
        saveNoteArrayonDevice()
        
    }
    
    //allows to modify the target view controller before it appears on the screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let editorViewcontroller = segue.destination as! NotesViewController
        
        // Pass the selected object to the new view controller.
        //select the title bar and change the title to currently selected note
        editorViewcontroller.navigationItem.title = arrNotes[self.selectedNoteindex]["title"]
        
        //set the body of the notes view controller to the selected notes index value
        editorViewcontroller.notesBodytext = arrNotes[self.selectedNoteindex]["body"]
        
        //set the delegate value to self
        editorViewcontroller.delegate = self
    }
    
    //protocol
    func didModifyNoteWithTitle(newTitle: String, andNoteBody newBody: String) {
        
        //update the selected values
        self.arrNotes[self.selectedNoteindex]["title"] = newTitle
        self.arrNotes[self.selectedNoteindex]["body"] = newBody
        
        //refresh the view
        self.tableView.reloadData()
        
        //save notes to device
        saveNoteArrayonDevice()
    }
    
    //to save the notes on the phone
    func saveNoteArrayonDevice()  {
        
        //save the updated/modified note
        UserDefaults.standard.set(arrNotes, forKey:"notes")
        UserDefaults.standard.synchronize()
    }
    
    //deleting the notes
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        arrNotes.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .middle)
        saveNoteArrayonDevice()
    }
    
    // MARK: - Target Button Tap
    // Tap on home button action
    
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
    
}
