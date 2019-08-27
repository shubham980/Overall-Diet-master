//
//  NotesViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 14/04/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

/* The class provided the editor view controller displyed in the form of
 text view for user to add or modify their notes and also display the
 existing notes */

import UIKit

//protocol to add the modified selected note
protocol NoteViewDelegate {
    
    //func to implement the changes
    func didModifyNoteWithTitle(newTitle: String , andNoteBody newBody:String)
}


class NotesViewController: UIViewController , UITextViewDelegate {
    
    //variable to link the text view screen to the table view 
    @IBOutlet weak var noteBody : UITextView!
    
    //variable to hold the string while the view is being loaded
    var notesBodytext : String!
    
    //variable to implement the action on the add button
    @IBOutlet weak var noteUpdateDone : UIBarButtonItem!
    
    //implements the actions when the Done button is tapped
    @IBAction func noteBodyUpdate(){
        //hides the keyboard
        self.noteBody.resignFirstResponder()
        
        //button invisible
        self.noteUpdateDone.tintColor = UIColor.clear
        
        //notify the table view controller that the note is modified only if the delegate is not nill
        if self.delegate != nil{
            
            self.delegate!.didModifyNoteWithTitle(newTitle: self.navigationItem.title! , andNoteBody: self.noteBody.text)
        }
    }
    
    //variable to store the delegate
    var delegate : NoteViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the body of the note to the intermitent string
        self.noteBody.text = self.notesBodytext
        
        //keyboard appears immediately
        self.noteBody.becomeFirstResponder()
        
        //allow UITextView To be Called
        self.noteBody.delegate = self
    }
    
    //modify the note 
    func textViewDidBeginEditing(_ textView: UITextView){
        
        //for updating the title of the notes
        //breaking the notes body into small components
        let breakBodyComponent = self.noteBody.text.components(separatedBy: "\n")
        
        //if the components do not contain a valid text then reset the title to blank
        self.navigationItem.title = ""
        
        //loop through each component in the body array
        for item in breakBodyComponent{
            
            //number of letter is greater than zero
            if !item.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                //set the title of the note to the item in the note itself
                self.navigationItem.title = item
                break
            }
        }
        
        
        //set the Colour of the Home button to the default value
        //self.noteUpdateDone.tintColor = UIColor(red: 0.38, green: 0.23, blue: 0.26, alpha: 1.0)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //notify the table view controller that the note is modified only if the delegate is not nill
        if self.delegate != nil{
            
            self.delegate!.didModifyNoteWithTitle(newTitle: self.navigationItem.title! , andNoteBody: self.noteBody.text)
        }
        
    }
    
}
