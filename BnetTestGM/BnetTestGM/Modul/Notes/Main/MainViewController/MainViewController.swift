//
//  TableViewController.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var tableView = UITableView()
    
    var viewModel: MainViewModelInterface
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.getSession()
    }
    
    func setupView() {
        title = "Notes"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(addNewNote))
        viewModel.getSession()
        setupTableView()
        configureView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "noteCell")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureView() {
        viewModel.showMassege = {
            let alert = UIAlertController(title: "Ошибка", message: "Обновите данныу ", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Обновить", style: .default, handler: { [weak self] action in
                self?.tableView.reloadData()
                self?.viewModel.getSession()
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        viewModel.updateNote = {
            self.tableView.reloadData()
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
        viewModel.addNewNote()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.reuseId, for: indexPath) as? MainViewCell else {
            return UITableViewCell()
            }
        
        cell = MainViewCell(style: .subtitle, reuseIdentifier: MainViewCell.reuseId)
        
        if let note = viewModel.noteList?[indexPath.row] {
            let dataCreated = viewModel.dataConfigure(note: note)
            cell.configure(note: note, data: dataCreated)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noteList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = viewModel.noteList?[indexPath.row]
        viewModel.fullNote(note: note)
    }
    
}

extension MainViewController {
    struct Container {
        let viewModel: MainViewModelInterface
    }
}
