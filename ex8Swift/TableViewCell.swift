//
//  TableViewCell.swift
//  ex8Swift
//
//  Created by VuHongSon on 7/28/17.
//  Copyright © 2017 VuHongSon. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var imgArtWork: UIImageView!
    @IBOutlet weak var lblMusicName: UILabel!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblGenreName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
