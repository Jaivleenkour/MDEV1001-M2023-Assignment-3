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
    @IBOutlet weak var AddEditTitleLabel: UILabel!
    @IBOutlet weak var UpdateButton: UIButton!
    
    // Movie Fields
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var studioTextField: UITextField!
    @IBOutlet weak var criticsRatingTextField: UITextField!
    
//    var movie: Movie?
//    var dataViewController: DataViewController?
    var selectedPosterImage: UIImage?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.thumbnailImage.layer.borderColor = UIColor.black.cgColor
        self.thumbnailImage.layer.borderWidth = 2
        
//        if let movie = movie
//        {
//            // Editing existing movie
//            titleTextField.text = movie.title
//            studioTextField.text = movie.studio
//            criticsRatingTextField.text = "\(movie.criticsrating)"
//            if let imageData = movie.thumbnail, let image = UIImage(data: imageData) {
//                thumbnailImage.image = image
//                }
//        }
//        else
//        {
//            AddEditTitleLabel.text = "Add Movie"
//            UpdateButton.setTitle("Add", for: .normal)
//        }
    }
    
    @IBAction func CancelButton_Pressed(_ sender: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
