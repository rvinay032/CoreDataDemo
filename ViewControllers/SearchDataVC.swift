
import UIKit
import CoreData

class SearchVC: UIViewController {
    
    var filterData = [String]()
    var passData = [String]()
    var conData = [String]()
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
        filterData.removeAll()
        
        // textData.append(searchTextField.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        //// Fetching Data..................
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "email == %@", searchTextField.text!)
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for temp in results as! [NSManagedObject] {
                    
                    if let username = temp.value(forKey: "email") as? String {
                        
                        if username == searchTextField.text {
                            
                            filterData.append(username)
                            
                        }
                    }
                    
                    if let pass = temp.value(forKey: "password") as? String {
                        
                        passData.append(pass)
                        
                    }
                    
                    if let contact = temp.value(forKey: "contactNo") as? String {
                        
                        conData.append(contact)
                        
                    }
                }
            }
            else {
                filterData.append("No User found")
                passData.append("No password is attached")
                conData.append("No Contact number found")
            }
        }
        catch
        {
            print(error)
        }// End...............
        searchTableView.reloadSections([0], with: .automatic )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "CellOfTableView", bundle: nil)
        searchTableView.register(nibCell, forCellReuseIdentifier: "CellOfTableViewId")
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
    }
    
}
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfTableViewId", for: indexPath) as? CellOfTableView
            else {
                fatalError()
        }
        cell.emaillabel.text = filterData[indexPath.row]
        cell.passwordLabel.text = passData[indexPath.row]
        cell.contactNoLabel.text = conData[indexPath.row]
        return cell
    }
    
    
}
