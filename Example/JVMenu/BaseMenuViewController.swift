import UIKit
import JVMenu

class BaseMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menuTapped))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
    }
    
    private var items: [JVMenuItem] {
        return [JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "First Menu 1"),
                JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Second Menu 2"),
                JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Third Menu 3"),
                JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Forth Menu 4"),
                JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Fifth Menu 5"),
                JVMenuItem(icon: UIImage(named: "icons8-settings")!, title: "Sixth Menu 6")]
    }
    
    @objc func menuTapped() {
        showMenu()
    }
}

extension BaseMenuViewController: JVMenuProtocol {
    func selectedMenuItem(row: Int) {
        print(row)
    }
    
    var data: JVMenuDataModel {
        return JVMenuDataModel(items)
    }
}
