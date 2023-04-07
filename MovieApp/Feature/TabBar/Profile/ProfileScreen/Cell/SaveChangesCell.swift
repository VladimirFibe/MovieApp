//
//  SaveChangesCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 05.04.23.
//

import UIKit

protocol SaveChangesCellDelegate: AnyObject {
    func cellButtonPressed(cell: SaveChangesCell, button: UIButton)
}

class SaveChangesCell: UITableViewCell {

    private let offset: CGFloat = 20
    
    weak var delegate: SaveChangesCellDelegate?
    
    let saveChangesButton = MainButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(saveChangesButton)
        configureUI()
        setConstraints()
    }
    
    private func configureUI() {
        saveChangesButton.setButton(style: .fill, title: "Save Changes")
        saveChangesButton.addTarget(self, action: #selector(saveBottonPressed), for: .touchUpInside)
    }
    
    @objc func saveBottonPressed(_ sender: UIButton) {
        delegate?.cellButtonPressed(cell: self, button: sender)
    }
    
    func setConstraints() {
        saveChangesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveChangesButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveChangesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            saveChangesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            saveChangesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

