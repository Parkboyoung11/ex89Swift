//
//  ViewController.swift
//  ex8Swift
//
//  Created by VuHongSon on 7/28/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

struct music {
    var musicName : String = ""
    var artist : String = ""
    var genreName : String = ""
    var date : String = ""
    var price : Double = 0.0
    var imageURL : String = ""
}

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblShow: UITableView!
    var musicList = [music]()

    override func viewDidLoad() {
        super.viewDidLoad()
        btnSearch.layer.borderWidth = 1.5
        btnSearch.layer.borderColor = UIColor.blue.cgColor
        tblShow.rowHeight = 91
        tblShow.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        cell.lblMusicName.text = musicList[indexPath.row].musicName
        cell.lblArtist.text = musicList[indexPath.row].artist
        cell.lblGenreName.text = musicList[indexPath.row].genreName
        cell.lblTime.text = musicList[indexPath.row].date
        cell.lblPrice.text = "\(musicList[indexPath.row].price)"
        let urlStr = musicList[indexPath.row].imageURL
        let url : URL = URL(string: urlStr)!
        do {
             let data : Data = try Data(contentsOf: url)
            cell.imgArtWork.image = UIImage(data: data)
        } catch {
            print("Image load error!")
        }
        return cell
    }

    func searchMusic(key : String){
        var musicListClone = [music]()
        let keyDidEncode = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(keyDidEncode)")
        let task = URLSession.shared.dataTask(with: url!) { (data, respone, error) in
            if error == nil {
                do{
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    let arrResult = result["results"] as! [[String: Any]]
                    for i in 0..<arrResult.count {
                        let musicInfor = arrResult[i]
                        var musicEx = music()
                        musicEx.musicName = musicInfor["trackName"] as! String
                        musicEx.artist = musicInfor["artistName"] as! String
                        musicEx.genreName = musicInfor["primaryGenreName"] as! String
                        musicEx.date = musicInfor["releaseDate"] as! String
                        musicEx.price = musicInfor["trackPrice"] as! Double
                        musicEx.imageURL = musicInfor["artworkUrl100"] as! String
                        musicListClone.append(musicEx)
                    }
                    
                    DispatchQueue.main.async {
                        self.musicList = musicListClone
                        self.tblShow.reloadData()
                    }
                } catch {}
            }
            
        }
        task.resume()
    }
    
    @IBAction func btnSearchDid(_ sender: Any) {
        if let key = txtSearch.text {
            searchMusic(key: key)
        }
    }

}
