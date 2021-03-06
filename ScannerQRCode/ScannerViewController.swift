//
//  ScannerViewController.swift
//  ScannerQRCode
//
//  Created by Inaldo Ramos Ribeiro on 10/06/2019.
//  Copyright © 2019 Bibimoney. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // Variable to connect MainViewController to MainView
    var mainView: ScannerView!
    
    var captureSession:AVCaptureSession?
    
    var captureDevice:AVCaptureDevice?
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    //override func loadView() {
    //    setupView()
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        captureInput()
        
    }
    
    func setupView() {
        
        //let defaultView = ScannerView(frame: self.view.frame)
        //self.mainView = defaultView
        
        //mainView.backgroundColor = .red
        //self.view.addSubview(mainView)
        
    }
    
    func captureInput() {
        
        captureDevice = AVCaptureDevice.default(for: .video)
        
        // Check if captureDevice returns a value and unwrap it
        
        if let captureDevice = captureDevice {
        
            do {
            
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                let captureSession = AVCaptureSession()
                captureSession.addInput(input)
                
                let captureMetaDataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetaDataOutput)
                
                captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
                captureMetaDataOutput.metadataObjectTypes = [.code128, .qr, .ean8, .code39] //AVMetadataObject.ObjectType
                
                captureSession.startRunning()
                
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
            
            } catch {
                print("Error Device Input")
            }
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0 {
            print("No Input Detected")
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        guard let stringCodeValue = metadataObject.stringValue else { return }
        // Create some Label and assign returned string value to it
        //    codeLabel.text = stringCodeValue
        
        print(stringCodeValue)
    }
}

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
