//
//  FullNoteViewController.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 07.09.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

class FullNoteViewController: UIViewController {
    
    let viewModel: FullNoteViewModelInterface

    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.text = self.viewModel.configure().body
        textView.font = .systemFont(ofSize: 16)
        textView.isEditable = false
        
        return textView
    }()
    
    lazy var constraint: [NSLayoutConstraint] = [
        textView.topAnchor.constraint(equalTo: view.topAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
    ]
    
    func setupView() {
        view.backgroundColor = .white
        setupBarItem()
        setupSubview()
    }
    
    func setupBarItem() {
        title = self.viewModel.dataCreating()
        let backButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backTap))
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    func setupSubview() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(constraint)
        
    }
    
    required init(container: Container) {
        viewModel = container.viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func backTap() {
        viewModel.backTap()
    }
}

extension FullNoteViewController {
    struct Container {
        let viewModel: FullNoteViewModelInterface
    }
}
