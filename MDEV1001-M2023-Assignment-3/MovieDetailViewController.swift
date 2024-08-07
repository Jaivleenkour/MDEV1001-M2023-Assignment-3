//
//  MovieDetailViewController.swift
//  MDEV1001-M2023-Assignment-3
//
//  Created by Jaivleen Kour on 2023-07-22.
//

import UIKit

class MovieDetailViewController: UIViewController
{
    // UI References
    
    // Movie Fields
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var studioTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var directorsTextField: UITextField!
    @IBOutlet weak var writersTextField: UITextField!
    @IBOutlet weak var actorsTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    @IBOutlet weak var mpaRatingTextField: UITextField!
    @IBOutlet weak var criticsRatingTextField: UITextField!
    
    @IBOutlet weak var descriptionTextview: UITextView!
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.thumbnailImage.layer.borderColor = UIColor.black.cgColor
        self.thumbnailImage.layer.borderWidth = 2
        self.descriptionTextview.layer.borderColor = UIColor.black.cgColor
        self.descriptionTextview.layer.borderWidth = 1
        
        

    }
    
    @IBAction func BackButton_Pressed(_ sender: UIButton)
    {
        
    }
    
}
