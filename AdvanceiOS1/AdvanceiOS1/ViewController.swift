//
//  ViewController.swift
//  AdvanceiOS1
//
//  Created by user203962 on 9/16/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = persons[indexPath.row]
            let cell = tableview.dequeueReusableCell(withIdentifier: "persons",
                for: indexPath) as!DetailsTableViewCell
            cell.tbllblname?.text = (person.value(forKey: "name") ?? "-") as? String
            cell.tbllblage?.text = (person.value(forKey: "age") ?? "-") as? String
            cell.tbllbltution?.text = (person.value(forKey: "tution") ?? "-") as? String
        cell.tbllblstartdate?.text = (person.value(forKey: "startdate") ?? "-") as? String
            return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let person = persons[indexPath.row]
            if editingStyle == .delete {
                managedContext.delete(person as NSManagedObject)
                persons.remove(at: indexPath.row)
                do {
                    try managedContext.save()
                } catch
                let error as NSError {
                    print("Could not save. \(error),\(error.userInfo)")
                }
                self.tableview.deleteRows(at: [indexPath], with: .fade)
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = persons[indexPath.row]
            let alert = UIAlertController(title: "Update Details", message: "Update Name, Age , Tution , Start Date", preferredStyle: .alert)
            // Enter button
        let updateAction = UIAlertAction(title: "Update", style: .default,handler: {
            (action) ->Void in
                // Get TextFields text
                guard
                let newUsernameTxt = alert.textFields?.first,
                    let newUsername = newUsernameTxt.text
                else {
                    return
                }
                guard
                let newAgeTxt = alert.textFields? [1],
                    let newAge = newAgeTxt.text
                else {
                    return
                }
                guard
                let newTutionTxt = alert.textFields? [2],
                    let newTution = newTutionTxt.text
                else {
                    return
                }
            guard
            let newStartDateTxt = alert.textFields? [2],
                let newStartDate = newStartDateTxt.text
            else {
                return
            }
            self.updateData(newName: newUsername, newAge: newAge, newTution: newTution, newStartDate: newStartDate, person: person as! Person)
                self.tableview.reloadData()
            })
            // Add 1 textField (for name)
            alert.addTextField {
                (textField: UITextField) in textField.placeholder = "Update Name"
            }
            // Add 2 textField (for age)
            alert.addTextField {
                (textField: UITextField) in textField.placeholder = "Update Age"
            }
            // Add 3 textField (for phone no)
            alert.addTextField {
                (textField: UITextField) in textField.placeholder = "Update Tution Name"
            }
        alert.addTextField {
            (textField: UITextField) in textField.placeholder = "Update Start Date"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
            alert.addAction(updateAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
    }
    func updateData(newName: String, newAge: String, newTution: String,newStartDate: String ,person: Person) {
        guard
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        do {
            person.setValue(newName, forKey: "name")
            person.setValue(newAge, forKey: "age")
            person.setValue(newTution, forKey: "tution")
            person.setValue(newStartDate, forKey: "startdate")
            do {
                try context.save()
                print("Details Updated!")
            } catch
            let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            } catch {}
        } catch {
            print("Error with request: \(error)")
        }
    }
    var persons:[NSManagedObject] = []
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtstartdate: UITextField!
    @IBOutlet weak var txttution: UITextField!
    @IBOutlet weak var txtage: UITextField!
    @IBOutlet weak var txtname: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "persons")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1
        guard
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let fetchRequest = NSFetchRequest < NSManagedObject > (entityName: "Person")
        //3
        do {
            persons =
                try managedContext.fetch(fetchRequest)
        } catch
        let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    @IBAction func addbtn(_ sender: Any) {
        //1
                guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                else {
                    return
                }
                let managedContext = appDelegate.persistentContainer.viewContext
                //2
                let entity = NSEntityDescription.entity(forEntityName: "Person", in : managedContext)!
                    //3
                    let record = NSManagedObject(entity: entity, insertInto: managedContext)
                //4
                record.setValue(txtname.text, forKey: "name")
                record.setValue(txtage.text, forKey: "age")
                record.setValue(txttution.text, forKey: "tution")
                record.setValue(txtstartdate.text, forKey: "startdate")
                do {
                    try managedContext.save()
                    persons.append(record)
                    print("Record Added!")
                    //To display an alert box
                    let alertController = UIAlertController(title: "Message", message: "Record Added!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) {
                        (action: UIAlertAction!) in
                    }
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true, completion: nil)
                } catch
                let error as NSError {
                    print("Could not save. \(error),\(error.userInfo)")
                }
    }
    
}

