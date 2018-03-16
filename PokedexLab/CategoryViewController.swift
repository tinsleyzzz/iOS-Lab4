//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var pokedexViewController: UITableView!
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokedexViewController.delegate = self
        pokedexViewController.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (pokemonArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podexTableCell") as! podexTableViewCell
        if let p = pokemonArray?[indexPath.row] {
            cell.pokemonName.text = p.name
            cell.pokemonIndex.text = String(describing:p.number!)
            cell.pokemonKeyStats.text = String(format: "%d/%d/%d", p.attack, p.defense, p.health)
        
            if let image = cachedImages[indexPath.row] {
                cell.pokemonImage.image = image
            } else {
                let url = URL(string: p.imageUrl)!
                let session = URLSession(configuration: .default)
                
                let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                    if let e = error {
                        print("Error downloading picture: \(e)")
                    } else {
                        if let _ = response as? HTTPURLResponse {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                self.cachedImages[indexPath.row] = image
                                cell.pokemonImage.image = UIImage(data: imageData)
                            
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code")
                        }
                    }
                }
                downloadPicTask.resume()
            }
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "categoryToInfo" {
                if let dest = segue.destination as? PokemonInfoViewController {
                    if let pokemon = pokemonArray?[(selectedIndexPath?.row)!] {
                        if let image = cachedImages[(selectedIndexPath?.row)!] {
                            dest.image = image
                            dest.pokemon = pokemon
                        }
                    }
                    
            }
        }
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "categoryToInfo", sender: self)
    }
    
}
