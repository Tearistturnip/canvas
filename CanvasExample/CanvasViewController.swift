//
//  CanvasViewController.swift
//  CanvasExample
//
//  Created by Justin Lee on 3/28/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let trayDownOffSet: CGFloat!
        trayDownOffSet = 185
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffSet)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
        if sender.state == .began{
            trayOriginalCenter = trayView.center
        }
        else if sender.state == .changed{
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended{
            if(velocity.y > 0){
                
                UIView.animate(withDuration:0.4,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }
            else{
                UIView.animate(withDuration:0.4,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
                
            }
            
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began{
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
           newlyCreatedFace.isUserInteractionEnabled = true
            
        view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
           newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
        }
        else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else{
            
        }
    }
    
    func createdPanGestureRecognizer(targetView: UIImageView) {
        var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        targetView.addGestureRecognizer(panGesture)
        
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer){
        let translation = gesture.translation(in: view)
        newlyCreatedFace.isUserInteractionEnabled = true
        if gesture.state == .began {
            
            newlyCreatedFace = gesture.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
        } else if gesture.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if gesture.state == .ended {
            
        }
    }
  

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
