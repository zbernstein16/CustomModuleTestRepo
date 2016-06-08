//
//  ViewController.swift
//  CustomModuleTestProject
//
//  Created by Zachary Bernstein on 5/24/16.
//  Copyright © 2016 Zachary Bernstein. All rights reserved.
//

import UIKit
import ResearchKit
class ViewController: UIViewController, ORKTaskViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let task = ORKOrderedTask.painTaskWithIdentifier("pain")
    
        let taskVC = ORKTaskViewController(task: task, taskRunUUID: nil)
        taskVC.delegate = self
        
        presentViewController(taskVC, animated: true, completion: nil)
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        dismissViewControllerAnimated(true)
        {
            print("Dismissed");
        }
        guard reason == .Completed else { return }
        let taskResult = taskViewController.result
        let stepResult = taskResult.results!.first as! ORKStepResult
        let painResult = stepResult.firstResult as! ORKPainResult
        print(String(painResult.answer()))
    }


}

