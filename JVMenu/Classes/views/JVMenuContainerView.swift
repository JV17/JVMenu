import UIKit

protocol JVMenuContainerViewDelegate: class {
    func selectedItemAt(row: Int)
}

class JVMenuContainerView: UIView {
    
    private let cellIdentifier: String = "JVMenuViewCellIdentifier"
    private let padding: CGFloat = 6.0
    private let dashWidth: CGFloat = 30.0
    private let dashHeight: CGFloat = 4.0

    private var data: JVMenuDataModel!
    private var showFrame: CGRect!
    private var hiddenFrame: CGRect!
    
    weak var delegate: JVMenuContainerViewDelegate?
    
    private lazy var tableView: UITableView = {
        let table: UITableView = UITableView(frame: tableViewFrame)
        table.backgroundColor = data?.backgroundColor ?? UIColor.darkGray
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = data?.rowHeight ?? 50
        table.bounces = false
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.separatorColor = data?.separatorColor ?? UIColor.gray
        table.tableFooterView = UIView()
        return table
    }()
    
    private var tableViewFrame: CGRect {
        return CGRect(x: 0, y: dashViewFrame.maxY+padding, width: frame.size.width, height: frame.size.height-padding)
    }
    
    private lazy var dashView: JVMenuDashView = {
        let view: JVMenuDashView = JVMenuDashView(frame: dashViewFrame)
        return view
    }()
    
    private var dashViewFrame: CGRect {
        return CGRect(x: frame.size.width/2-(dashWidth/2), y: padding, width: dashWidth, height: dashHeight)
    }
    
    private var selectedBackgroundView: UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return view
    }
    
    init(frame: CGRect, data: JVMenuDataModel) {
        self.data = data
        super.init(frame: frame)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = data?.backgroundColor ?? UIColor.darkGray
        addSubview(dashView)
        addSubview(tableView)
    }
}

extension JVMenuContainerView: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.items.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.textColor = data?.textColor ?? UIColor.white
        cell.textLabel?.font = data?.font ?? UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        cell.backgroundColor = data?.backgroundColor ?? UIColor.darkGray
        cell.selectedBackgroundView = selectedBackgroundView

        guard let _data = data else { return cell }
            
        if indexPath.row < _data.items.count {
            cell.imageView?.image = _data.items[indexPath.row].icon
            cell.textLabel?.text = _data.items[indexPath.row].title
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if delegate != nil {
            delegate?.selectedItemAt(row: indexPath.row)
        }
    }
}
