//
//  TableViewController.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var tableView: UITableView()
    
    let viewModel: MainViewModelInterface
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        func setupView() {
            title = "Notes"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
            tableView = UITableView(frame: view.bounds, style: .plain)
            tableView.delegate = self
            tableView.dataSource = self
            viewModel.getSession()
            viewModel.updateView()
        }
    }
    required init(container: Container) {
        viewModel = container.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    private func addNewNote() {
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.reuseId, for: indexPath) as? MainViewCell else {
            return UITableViewCell()
            }
        cell = MainViewCell(style: .subtitle, reuseIdentifier: MainViewCell.reuseId)
        
        if let note = 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension MainViewController {
    struct Container {
        let viewModel: MainViewModelInterface
    }
}
