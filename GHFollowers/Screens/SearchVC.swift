//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Kwaku Dapaah on 1/8/24.
//

import UIKit

class SearchVC: UIViewController {
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")!
        return imageView
    }()
    
    private var usernameTextField: GFTextField = {
        let textField = GFTextField()
        textField.returnKeyType = .go
        return textField
    }()
    
    
    private var calltoActionbutton: GFButton = {
        let btn = GFButton(backGroundColor: .systemGreen, title: "Get Followers")
        btn.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        return btn
    }()
    
    var isUserNameEntered: Bool { return !usernameTextField.text!.isEmpty }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func layout() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(calltoActionbutton)
        
        usernameTextField.delegate = self
        
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            calltoActionbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            calltoActionbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            calltoActionbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            calltoActionbutton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        guard isUserNameEntered  else {
            presentGFAlertOnMainThread(title: "Empty UserName", message: "Please enter a username. We need to know who to look for 😃.", buttonTitle: "Ok")
            return
        }
        let followerListVC = FollowerListVC()
        followerListVC.userName = usernameTextField.text
        followerListVC.title = usernameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}



/*
 Note: viewDidLoad only gets called the FIRST TIME the view appears. we want to remove the navigation bar at the top. if we remove the nav bar functionality in the viewDidLoad for example and we navigate away from the view and come back, the nav bar will still be there. this is because view did load gets called only the FIRST TIME the view appears. to solve this we are going call the nav bar removal in viewWillAppear instead. viewWillAppear gets called everytime the view appears.
 
 */
