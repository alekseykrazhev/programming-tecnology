//
//  ViewController.swift
//  example6
//
//  Created by Кражевский Алексей И. on 6/7/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell")! as UITableViewCell
        let student = students[indexPath.row]; cell.textLabel?.text = student.value(forKey: "name") as? String //Заполняем текст ячейки таблицы значением ключа "name"
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var studentNameTextField: UITextField!
    var students = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addStudentButton(_ sender: Any) {
        if studentNameTextField.text == "" || studentNameTextField.text == "Введите данные!"
        {
            studentNameTextField.text = "Введите данные!"
        }
        else
        {
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newObject = NSEntityDescription.insertNewObject(forEntityName: "Students", into: managedObjectContext) as NSManagedObject
            newObject.setValue(studentNameTextField.text!, forKey: "name")
        do
        {
            try managedObjectContext.save()
            students.append(newObject)
            studentNameTextField.text! = ""
            self.tableView.reloadData()
            self.view.endEditing(true)
        }
            catch let error as NSError {
            print("Data saving error: \(error)")
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            _ = UIApplication.shared.delegate as! AppDelegate //Создаем ссылку на класс AppDelegate из файла AppDelegate.swift
            let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //Создаем ссылку на метод managedObjectContext из класса AppDelegate в файле AppDelegate.swift
            managedObjectContext.delete(students[indexPath.row] as NSManagedObject) //Выбираем метод удаления объекта из модели данных students
            do
            {
                try managedObjectContext.save() //Пробуем сохранить изменения в базе данных
                students.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with:.left)
            }
            catch let error as NSError {
                print("Data removing error: \(error)") //В случае возникновения ошибки, выводим ее в консоль
            }   }
        }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        _ = UIApplication.shared.delegate as! AppDelegate //Создаем ссылку на класс AppDelegate из файла AppDelegate.swift
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //Создаем ссылку на объект managedObjectContext из класса AppDelegate
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Students") //Создаем запрос из сущности "Students"
        do
        {
            students = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject] //Пробуем загрузить запрошенные данные в модель students
        }
        catch let error as NSError {
            print("Data loading error: \(error)") }
    
        self.tableView.reloadData() //Обновляем содержимое таблицы
        
    }
    
}

