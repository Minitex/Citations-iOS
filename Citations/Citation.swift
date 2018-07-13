//
//  Citation.swift
//  Citations
//
//  Created by Vui Nguyen on 6/2/17.
//  Copyright © 2017 Minitex. All rights reserved.
//

import Foundation

class Citation {

  var metadata: [String: AnyObject]?

  init(metadata: [String: AnyObject]) {
    self.metadata = metadata
  }

  lazy var publisher: String = {
    var publisher = ""

    for key in (self.metadata?.keys)! {
      if key == "publisher" {

        if self.metadata?[key] is String {
          publisher = "Published by \(self.metadata?[key] as! String)"
        }

        break
      }
    }

    return publisher
  }()

  lazy var publicationYear: String =  {
    var publicationYear = ""

    for key in (self.metadata?.keys)! {
      if (key == "published") {

        if self.metadata?[key] is String {
          let RFC339Formatter = DateFormatter()
          RFC339Formatter.locale = Locale(identifier: "en_US_POSIX")
          RFC339Formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
          RFC339Formatter.timeZone = TimeZone(secondsFromGMT: 0)

          let date = RFC339Formatter.date(from: (self.metadata?[key])! as! String)
          let calendar = Calendar.current
          publicationYear = String(calendar.component(.year, from: date!))
        }

        break
      }
    }

    return publicationYear
  }()

  lazy var distributor: String = {
    var distributor = ""

    for key in (self.metadata?.keys)! {
      if (key == "distributor") {

        if self.metadata?[key] is String {
          distributor = "Distributed by \(self.metadata?[key] as! String)"
        }

        break
      }
    }

    return distributor
  }()

  lazy var authors: String = {
    var authors = ""

    for key in (self.metadata?.keys)! {
      if (key == "authors") {

        if self.metadata?[key] is [String] {
          let allAuthors = self.metadata?[key] as! [String]

          for anAuthor in allAuthors {
            authors = authors.appending(anAuthor)
          }
        }

        break
      }
    }

    return authors
  }()

  lazy var title: String = {
    var title = ""

    for key in (self.metadata?.keys)! {
      if (key == "title") {

        if self.metadata?[key] is String {
          title = self.metadata?[key] as! String
        }

        break
      }
    }

    return title
  }()

  var accessedBy = "Accessed by SimplyE http://www.librarysimplified.org"

  // currentDate is not lazy computed because it must be re-computed each time to get the current date
  var currentDate: String {
    get {
      let date = Date()
      let calendar = Calendar.current
      let formatter = DateFormatter()
      let months = formatter.shortMonthSymbols
      let monthName = months?[calendar.component(.month, from: date) - 1]
      return "\(calendar.component(.day, from: date)) \(monthName ?? "January") \(calendar.component(.year, from: date))"
    }
  }

  func APAFormat() -> String
  {
    var citation = "Could not Create Citation in APA format"

    if (self.metadata != nil) {
      let elements = [authors, publicationYear, title, publisher, distributor, accessedBy]
      citation = ""

      for element in elements {

        if element != "" {
          if element == publicationYear {
            citation += "(\(element)) "
          } else {
            citation += "\(element). "
          }
        }

      }

    }
    return citation
  }
  
  func MLAFormat() -> (fullCitation: String, textToItalicize: String, positionToStartItalics: Int)
  {
    var citation = "Could not Create Citation in MLA format"
    var charactersToTitle = 0
    
    if (self.metadata != nil) {
      let elements = [authors, title, publisher, distributor, accessedBy, currentDate]
      citation = ""

      for element in elements {

        if element != "" {
          citation += "\(element). "

          if element == authors {
            charactersToTitle = citation.count
          }
        }

      }

    }
    return (citation, title, charactersToTitle)
  }
  
  func ChicagoFormat() -> (fullCitation: String, textToItalicize: String, positionToStartItalics: Int)
  {
    var citation = "Could not Create Citation in Chicago format"
    var charactersToTitle = 0

    if (self.metadata != nil) {
      let elements = [authors, title, publicationYear, publisher, distributor, accessedBy]
      citation = ""

      for element in elements {

        if element != "" {
          citation += "\(element). "

          if element == authors {
            charactersToTitle = citation.count
          }
        }

      }

    }
    return (citation, title, charactersToTitle)
  }

}

