//
//  ViewController.swift
//  RealmDog
//
//  Created by 김종현 on 28/05/2019.
//  Copyright © 2019 김종현. All rights reserved.
//

import UIKit
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    var dogArray : Results<Dog>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        
//        let myDog = Dog()
//
//        myDog.name = "Rex"
//        myDog.age = 3
//
//        let realm = try! Realm()
//
//        let puppies = realm.objects(Dog.self).filter("age < 2")
//        print(puppies.count)
//
//        try! realm.write {
//            realm.add(myDog)
//        }
        
        print(NSHomeDirectory())
        loadData()
    }

    @IBAction func dataSave(_ sender: Any) {
        let myDog = Dog()
        myDog.name = nameTxtField.text!
        nameTxtField.text = ""
        
        let tmpAge = ageTxtField.text!
        print("tmpAge = \(String(describing: tmpAge))")
        myDog.age = Int(tmpAge) ?? 100000
        ageTxtField.text = ""
        
        let realm = try! Realm()
        
        let puppies = realm.objects(Dog.self).filter("age < 2")
        print(puppies.count)
        
        try! realm.write {
            realm.add(myDog)
        }
        self.myTableView.reloadData()
    }
    
    func loadData() {
        //let realm = try! Realm()
        //dogArray = realm.objects(Dog.self)
        
        let realm = try! Realm()
        dogArray = realm.objects(Dog.self)
        //print(realm.objects(Dog.self))
        
        for item in dogArray! {
            print("dogArray = \(item)")
        }
        
        self.myTableView.reloadData()
    }
    
    
    @IBAction func deleteData(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        self.myTableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        cell.textLabel?.text = dogArray?[indexPath.row].name ?? "no data"
        
        let dogAge: Int = (dogArray?[indexPath.row].age)!
        
        cell.detailTextLabel?.text = String(dogAge)
        return cell
    }
    
}

