//
//  ViewController.swift
//  MeMeV1.0
//
//  Created by Ohud Alessa on 25/10/2018.
//  Copyright © 2018 OHUD. All rights reserved.
//

import UIKit

class MeMeViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    
    
    //    ------------------------------------------------
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    // image view to show the image
    @IBOutlet weak var imageView: UIImageView!
    
    // Text Fields
    @IBOutlet weak var topTxt: UITextField!
    @IBOutlet weak var bottomTxt: UITextField!
    
    
    
    //
    var textDelegate = CustomTextFieldDelegate()
    // Delegate
    //    let memeDelegate = MeMeDelegates()
    
    // ----------------------------------------------------
    
    // bar buttons
    
    @IBOutlet weak var camBtn: UIBarButtonItem!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var clearBtn: UIBarButtonItem!
    
    //    ------------------------------------------------
    
    func toggleShareAndClear(_ allowed: Bool, _ share: Bool) {
        shareBtn.isEnabled = share
        clearBtn.isEnabled = allowed
        
    }
    //    ------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        
        self.tabBarController?.tabBar.isHidden = true
        
    }
    //    ------------------------------------------------
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    //    ------------------------------------------------
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        toggleShareAndClear(false, false)
        camBtn.isEnabled =  UIImagePickerController.isSourceTypeAvailable(.camera)
        
   
        self.configure(textField: topTxt)
        self.configure(textField: bottomTxt)
        
        textDelegate.viewController = self
        
    }
    //    ------------------------------------------------
    
    
    func configure(textField: UITextField) {
        textDelegate.viewController = self
        textField.delegate = textDelegate
        textField.defaultTextAttributes = textDelegate.memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        
    }

    //    ------------------------------------------------

    
    func saveMeMe(){
        
        
        let meme = MeMe(imageView.image!, topTxt.text!, bottomTxt.text!,generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    //    ------------------------------------------------
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        toolBar.isHidden = true
        // Render view to an image
        if topTxt.text == "TOP" {
            topTxt.text = ""
        }
        if bottomTxt.text == "BOTTOM"{
            bottomTxt.text = ""
        }
        //  “UIGraphicsBeginImageContextWithOptions.” Apple Developer, developer.apple.com/documentation/uikit/1623912-uigraphicsbeginimagecontextwitho?language=objc.
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, true, 0.0 )
        view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        toolBar.isHidden = false
        return memedImage
    }
    
    //    ------------------------------------------------
    
    
    
    // MARK: Keybaord managment funcs ..
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //    ------------------------------------------------
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //    ------------------------------------------------
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        // to make sure that the view will slide up only when we edit the bottom text field :)
        if bottomTxt.isEditing{
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    //    ------------------------------------------------
    
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if view.frame.origin.y != 0
        {
            view.frame.origin.y = 0
            
        }
    }
    //    ------------------------------------------------
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    //    ------------------------------------------------
    
    // action for both photo library button an camera button : we check for tags to specify the source type
    
    @IBAction func pickImage(_ sender: UIButton) {
        
        let ctr  = UIImagePickerController()
        ctr.delegate = self  as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let isPhotoLibrary = sender.tag == 1
        
        ctr.sourceType =  isPhotoLibrary ?  .photoLibrary : .camera
        
        ctr.allowsEditing = false
        present(ctr, animated: true)
        toggleShareAndClear(true, true)
    }
    //    ------------------------------------------------
    
    
    
    
    @IBAction func clearMeme(_ sender: Any) {
        imageView.image = nil
        topTxt.text = "TOP"
        bottomTxt.text = "BOTTOM"
        toggleShareAndClear(false, false)
    }
    
    //    ------------------------------------------------
    
    func success (_ succeed: Bool){
        
        let title: String = succeed ? "Success": "Canceled"
        
        let message: String = succeed ? "MeMe has been shared succesfully.." : "Nothing has been shared..."
        
        // UIAlertController. (n.d.). Retrieved November 1, 2018, from https://developer.apple.com/documentation/uikit/uialertcontroller
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("GOT IT", comment: "Default action"), style: .default, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    //    ------------------------------------------------
    
    
    
    @IBAction func shareMeme(_ sender: Any) {
        
        let ctr = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        ctr.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            
            if !completed {
                self.success(false)
                return
            }
                
            else{
                
                self.saveMeMe()
                self.success(true)
                
            }
        }
        
        
        present(ctr, animated: true, completion: nil)
        
    }
    
    //    ------------------------------------------------
    
    
    @IBAction func doneMeme(_ sender: Any) {
        
        self.navigationController!.popViewController(animated: true)
        
        
    }
    
    //    ------------------------------------------------
    
    
    
    // imagePickerControl Protocol funcs
    // 1
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    // 2
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
}

