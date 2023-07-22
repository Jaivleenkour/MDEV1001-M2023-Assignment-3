//
//  MovieViewController.swift
//  MDEV1001-M2023-Assignment-3
//
//  Created by Jaivleen Kour on 2023-07-22.
//

import UIKit

class MovieViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
   // var movies: [Movie] = []
    var index = Int()
    var selectedPosterImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        //let movie = movies[indexPath.row]
        index = indexPath.row
        cell.titleLabel?.text = "DDLJ"
        cell.studioLabel?.text = "Fox Studio"
        cell.yearLabel?.text = "Releasing Year: 2001"
        
        cell.ratingLabel?.text = "7.9"
        // Set the background color of criticsRatingLabel based on the rating
//        let rating = "7.9"
//
//        if rating > 7
//        {
//            cell.ratingLabel.backgroundColor = UIColor.green
//            cell.ratingLabel.textColor = UIColor.black
//        } else if rating > 5 {
//            cell.ratingLabel.backgroundColor = UIColor.yellow
//            cell.ratingLabel.textColor = UIColor.black
//        } else {
//            cell.ratingLabel.backgroundColor = UIColor.red
//            cell.ratingLabel.textColor = UIColor.white
//        }
        //            let imgData = movie.thumbnail != nil ? UIImage(data: movie.thumbnail!) : nil
        //            cell.thumbnailImage?.image = imgData ?? selectedPosterImage
        return cell
        
        
    }
    
    
    // Tap on particular cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier: "MovieDetailSegue", sender: indexPath)
    }
   /*
    // Swipe Left Gesture
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let movie = movies[indexPath.row]
            ShowDeleteConfirmationAlert(for: movie) { confirmed in
                if confirmed
                {
                    self.deleteMovie(at: indexPath)
                }
            }
        }
    }
    */
    
    @IBAction func AddButton_Pressed(_ sender: UIButton)
    {
       
    }
}
