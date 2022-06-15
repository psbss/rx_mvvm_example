//
//  ViewController.swift
//  app-playground
//
//  Created by uehara yuki on 2022/05/19.
//

import UIKit
import RxSwift
import RxCocoa

class View: UIViewController {
    private let disposeBag = DisposeBag()
    let tapGesture = UITapGestureRecognizer()

    lazy var textField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = "text me"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var button: UIView = {
        let button = UIView()
        button.backgroundColor = .blue
        button.addGestureRecognizer(tapGesture)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var viewModel = ViewModel(
        tapActionObservable: tapGesture.rx.event.asObservable(),
        textInputObservable: textField1.rx.text.asObservable()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        event()
    }

    func event() {
        viewModel.labelText
            .debug()
            .subscribe(onNext: { [weak self] string in
                self?.textLabel.text = string
            })
            .disposed(by: disposeBag)
        viewModel.text
            .debug()
            .subscribe(onNext: { [weak self] string in
                self?.textLabel.text = string
            })
            .disposed(by: disposeBag)
    }

    func initView() {
        view.backgroundColor = .white

        self.view.addSubview(textField1)
        self.view.addSubview(textLabel)
        self.view.addSubview(button)

        NSLayoutConstraint.activate([
            self.textField1.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7),
            self.textField1.heightAnchor.constraint(equalToConstant: 20.0),
            self.textField1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textField1.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: 20.0),

            self.textLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            self.textLabel.heightAnchor.constraint(equalToConstant: 20.0),
            self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            self.button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            self.button.heightAnchor.constraint(equalToConstant: 30.0),
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0),
        ])
    }
}
