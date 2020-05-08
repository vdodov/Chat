//
//  RegisterationController.swift
//  Chat
//
//  Created by 차수연 on 2020/05/07.
//  Copyright © 2020 차수연. All rights reserved.
//

import UIKit

class RegisterationController: UIViewController {
  
  // MARK: - Properties
  
  private var viewModel = RegisterationViewModel()
  
  private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    button.clipsToBounds = true
    button.contentMode = .scaleAspectFill
    return button
  }()
  
  private lazy var emailContainerView: UIView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
  }()
  
  private lazy var fullnameContainerView: UIView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullnameTextField)
  }()
  
  private lazy var usernameContainerView: UIView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField)
  }()
  
  private lazy var passwordContainerView: InputContainerView = {
    return InputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
  }()
  
  private let emailTextField = CustomTextField(placeholder: "Email")
  private let fullnameTextField = CustomTextField(placeholder: "Full Name")
  private let usernameTextField = CustomTextField(placeholder: "Username")
  
  private let passwordTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Password")
    tf.isSecureTextEntry = true
    return tf
  }()
  
  private let signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Sign Up", for: .normal)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
    button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    button.setTitleColor(.white, for: .normal)
    button.setHeight(height: 50)
    button.isEnabled = false
    return button
  }()
  
  private let alreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    
    let attributedTitle = NSMutableAttributedString(string: "Already have an acoount? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white])
    
    attributedTitle.append(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white]))
    
    button.setAttributedTitle(attributedTitle, for: .normal)
    button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureNotificationObserves()
  }
  
  // MARK: - Selectors
  
  @objc func textDidChange(sender: UITextField) {
    if sender == emailTextField {
      viewModel.email = sender.text
    } else if sender == passwordTextField {
      viewModel.password = sender.text
    } else if sender == fullnameTextField {
      viewModel.fullname = sender.text
    } else if sender == usernameTextField {
      viewModel.username = sender.text
    }
    
    checkFormStatus()
  }
  
  @objc func handleSelectPhoto() {
    print("DEBUG: Select photo here..")
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
  
  @objc func handleShowLogin() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Helper Functions
  
  func configureUI() {
    configureGradientLayer()
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view)
    plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    plusPhotoButton.setDimensions(height: 200, width: 200)
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                               fullnameContainerView,
                                               usernameContainerView,
                                               passwordContainerView,
                                               signUpButton])
    stack.axis = .vertical
    stack.spacing = 16
    
    view.addSubview(stack)
    stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                 paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
  }
  
  func configureNotificationObserves() {
    emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
  }
}
// MARK: - UIImagePickerControllerDelegate

extension RegisterationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
    plusPhotoButton.layer.borderWidth = 3.0
    plusPhotoButton.layer.cornerRadius = 200 / 2
    
    dismiss(animated: true, completion: nil)
  }
}

extension RegisterationController: AuthenticationControllerProtocol {
  func checkFormStatus() {
    if viewModel.formIsValid {
      signUpButton.isEnabled = true
      signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
    } else {
      signUpButton.isEnabled = false
      signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    }
  }
}
