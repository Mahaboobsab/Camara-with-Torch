//
//  ViewController.swift
//  camera
//
//  Created by Meheboob MacBook on 10/6/18.
//  Copyright © 2018 Namsha Tech. All rights reserved.
//

import UIKit
import AVKit


class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func changePic(_ sender: Any) {
        
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheetControllerIOS8.popoverPresentationController?.sourceView = self.view
        actionSheetControllerIOS8.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        
        
        
        
        let OpenGalleryButton: UIAlertAction = UIAlertAction(title: "Open Gallary", style: .default)
        { action -> Void in
            
            DispatchQueue.main.async() {
                // self.myCourseImage.image = UIImage(data: data)
                // }
                
                self.choosePhotoFromExistingImages()
                
            }
            
            
            
        }
        
        
        
        
        let TakeAPic: UIAlertAction = UIAlertAction(title: "Take a Picture", style: .default)
        { action -> Void in
            print("Take a Pic")
            
            
            
            self.takeNewPhotoFromCamara()
            
            
            
        }
        
        
        
        
        let DeletePic: UIAlertAction = UIAlertAction(title: "Remove Picture", style: .destructive)
        { action -> Void in
            print("Remove Picture")
            
            
            self.toggleFlash()
            
        }
        
        
        
        
        
        
        
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        
        actionSheetControllerIOS8.addAction(OpenGalleryButton)
        actionSheetControllerIOS8.addAction(TakeAPic)
        actionSheetControllerIOS8.addAction(DeletePic)
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: CAMARA METHODS
    func choosePhotoFromExistingImages() {
        //Checks whether PhotoGallary is available to Display an Image
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            //Allocates and initializes UIImagePickerController
            let controller = UIImagePickerController()
            //Sets Device Photo Gallary as Source to Display an Image
            controller.sourceType = .photoLibrary
            //Not allows Editing of an Image
            controller.allowsEditing = false
            //Sets the Media type as PhotoGallary
            if let aLibrary = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
                controller.mediaTypes = aLibrary
            }
            //Calls the Delegates methods from this Class
            controller.delegate = self
            //Shows navigationController to Dispaly an Image
            present(controller, animated: true) {() -> Void in }
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        self.myImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func takeNewPhotoFromCamara() {
        //Checks whether Camara is Available for the Device
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //Allocates and initializes UIImagePickerController
            let controller = UIImagePickerController()
            //Sets the Source type as Camara
            controller.sourceType = .camera
            //Not allows Editing of Image
            controller.allowsEditing = false
            //Sets the Media Type source as Camara loke Image or Video
            if let aCamera = UIImagePickerController.availableMediaTypes(for: .camera) {
                controller.mediaTypes = aCamera
            }
            //Call the Delegates methods from this Class
            controller.delegate = self
            //Presents navigationController to show Image
            present(controller, animated: true) {() -> Void in }
        }
    }
    
    func toggleFlash() {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        
        if (device != nil) {
            if (device!.hasTorch) {
                do {
                    try device!.lockForConfiguration()
                    if (device!.torchMode == AVCaptureDevice.TorchMode.on) {
                        device!.torchMode = AVCaptureDevice.TorchMode.off
                    } else {
                        do {
                            try device!.setTorchModeOn(level: 1.0)
                        } catch {
                            print(error)
                        }
                    }
                    
                    device!.unlockForConfiguration()
                } catch {
                    print(error)
                }
            }
        }
    }
}

