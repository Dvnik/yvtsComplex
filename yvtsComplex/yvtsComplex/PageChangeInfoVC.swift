//
//  PageChangeInfoVC.swift
//  yvtsComplex
//
//  Created by Trixie Lulamoon on 2020/10/8.
//

import UIKit

class PageChangeInfoVC: UIViewController
{
    // Values
    var infoMessage: String!
    
    // UI Objects
    @IBOutlet weak var lblMessage: UILabel!
    
    //MARK: my Functions
    func setMessage()
    {
        if let infoStr = infoMessage
        {
            lblMessage.text = infoStr
        }
        else
        {
            lblMessage.text = "Not any message send to here."
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        setMessage()
    }
    


}
