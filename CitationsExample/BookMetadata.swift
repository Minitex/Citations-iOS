//
//  BookMetadata.swift
//  CitationsExample
//
//  Created by Vui Nguyen on 5/31/17.
//  Copyright © 2017 Minitex. All rights reserved.
//

import Foundation

class BookMetadata {

  static func dictionary() -> [String: AnyObject] {
    var dictionary = [String: AnyObject]()

    dictionary["publisher"]   = "Random House Publishing Group" as AnyObject
    dictionary["published"]   = "2014-09-09T10:33:34UTC" as AnyObject
    dictionary["distributor"] = "Overdrive" as AnyObject
    dictionary["authors"]     = ["Linda Babcock, ", "Sara Laschever"] as AnyObject
    dictionary["title"]       = "Ask For It" as AnyObject

    return dictionary
  }

}
