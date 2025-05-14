//
//  RSSParser.swift
//  RSS_Reader
//
//  Created by Trakya7 on 14.05.2025.
//

import Foundation

class RSSParser: NSObject, XMLParserDelegate {
    private var newsItems: [NewsItem] = []
    private var currentElement = ""
    private var currentTitle = ""
    private var currentDescription = ""
    private var currentLink = ""
    private var currentPubDate = ""
    private var completionHandler: (([NewsItem]) -> Void)?

    func parseFeed(url: String, completion: @escaping ([NewsItem]) -> Void) {
        self.completionHandler = completion
        guard let feedURL = URL(string: url) else { return }
        let parser = XMLParser(contentsOf: feedURL)
        parser?.delegate = self
        parser?.parse()
    }

    // MARK: - XMLParserDelegate Methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentLink = ""
            currentPubDate = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if !data.isEmpty {
            switch currentElement {
            case "title": currentTitle += data
            case "description": currentDescription += data
            case "link": currentLink += data
            case "pubDate": currentPubDate += data
            default: break
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let newsItem = NewsItem(title: currentTitle, description: currentDescription, link: currentLink, pubDate: currentPubDate)
            newsItems.append(newsItem)
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        completionHandler?(newsItems)
    }
}
