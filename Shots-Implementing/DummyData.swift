//
//  DummyData.swift
//  Shots-Implementing
//
//  Created by Jorge Luiz on 27/11/17.
//  Copyright © 2017 Jorge Luiz. All rights reserved.
//

import UIKit

func getData() -> Array<Dictionary<String,String>> {
    let data = [["title":"Bug", "author": "Mike | Creative Mints", "image": "image", "avatar": "avatar", "desc": "You guys, the new \"How To Draw: drawing and sketching objects and environments from your imagination\" book by S. Robertson is just amazing! I spent the whole weekend gobbling it up and of course I couldn't help but take the watercolors myself! :)"],
        ["title":"Title2", "author": "Author2", "image": "image2", "avatar": "avatar2", "desc": "This is my new project"],
        ["title":"Title3", "author": "Author3", "image": "image3", "avatar": "avatar3", "desc": "This is my new project 3"],
        ["title":"Title4", "author": "Author4", "image": "image4", "avatar": "avatar4", "desc": "This is my new project 4"]
    ]
    
    return data
}
