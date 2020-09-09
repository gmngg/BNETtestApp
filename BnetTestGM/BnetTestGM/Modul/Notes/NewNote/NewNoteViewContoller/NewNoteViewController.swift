//
//  NewNotesViewController.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 05.09.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var viewModel: NewNoteViewModelInterfase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        
        textView.font = .systemFont(ofSize: 16)
        
        return textView
    }()
    
    lazy var constraint: [NSLayoutConstraint] = [
        textView.topAnchor.constraint(equalTo: view.topAnchor),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]
    
    func setupView() {
        view.backgroundColor = .white
        setupBarItem()
        setupSubview()
        textView.becomeFirstResponder()
    }
    
    func setupBarItem() {
        title = "Введите запись"
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(tapSavaButton))
        navigationItem.rightBarButtonItem = saveButton
        let backButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backTap))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupSubview() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(constraint)
    }
    
    @objc
    private func tapSavaButton() {
        viewModel.tapSaveNote(text: textView.text)
    }
    
    @objc
    func backTap() {
        viewModel.backTap()
    }
    
    required init(container: Container) {
        viewModel = container.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewNoteViewController {
    struct Container {
        let viewModel: NewNoteViewModelInterfase
    }
}
