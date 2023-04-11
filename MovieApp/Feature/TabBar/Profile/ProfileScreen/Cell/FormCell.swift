//
//  FormCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 05.04.23.
//

import UIKit

protocol FormCellDelegate: AnyObject {
    func cellTextFieldDidEndEditing(cell: FormCell, textField: UITextField, text: String)
    func cellTextFieldShouldBeginEditing(cell: FormCell, textField: UITextField)
}

class FormCell: UITableViewCell {
    
    private let offset: CGFloat = 20
    
    weak var delegate: FormCellDelegate?

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Theme.darkGreyToWhite
        return label
    }()
    
    private var datePicker: UIDatePicker?
    
    let textFieldView = TextFieldView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(title)
        contentView.addSubview(textFieldView)
        contentView.backgroundColor = Theme.whiteToBlack
        textFieldView.textField.delegate = self
    }
    
    func configure(title text: String, textFildPlaceholder placeholder: String) {
        setConstraints()
        title.text = text
        textFieldView.configure(style: .border, textFildPlaceholder: placeholder)
    }
    
    func setConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            title.bottomAnchor.constraint(equalTo: textFieldView.topAnchor),
            
            textFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            textFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            textFieldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Content type
extension FormCell {
    
    func activateDatePickerForTextField() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }

        datePicker?.addTarget(self, action: #selector(getDate), for: .valueChanged)
        textFieldView.textField.inputView = datePicker
        // добавляет метод для закрытия туллбара
        let toolBar = UIToolbar().toolBarPicker(#selector(doneButtonPressed))
        textFieldView.textField.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonPressed() {
        textFieldView.textField.resignFirstResponder()
    }
    
    @objc func getDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        let dateString = formatter.string(from: sender.date)
        
        textFieldView.textField.text = dateString
    }
}

// MARK: - TextField Delegate
extension FormCell :UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.cellTextFieldShouldBeginEditing(cell: self, textField: textField)
//        print(#function)
        textField.text = ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text!
        delegate?.cellTextFieldDidEndEditing(cell: self, textField: textField, text: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - extension UIToolbar
extension UIToolbar {
    func toolBarPicker(_ select: Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.barTintColor = Theme.purple
        toolBar.tintColor = .white
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: select)
        toolBar.setItems([doneButton], animated: false)
        
        return toolBar
    }
}
