//
//  NewsController.swift
//  FirstThing
//
//  Created by Stephanie on 8/4/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

// MARK: - Properties
    let newsView = NewsView()
    let newsTableView = UITableView()
    let titleCellID = "TitleCell"
    let detailsCellID = "DetailsCell"
    private let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e2f0b28b0f0146dcb2b9c2ce5c3142a7"
    private var articles = [Articles]()

// MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view = newsView
        
        setupNavigationController()
        setupLayout()
        setupTableView()
        getLatestNewsArticles()
    }

// MARK: - Helper Functions
    func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupLayout() {
        view.addSubview(newsTableView)
        newsTableView.anchor(top: newsView.firstThingTitle.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50)
    }
    
    func setupTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsTitleTableViewCell.self, forCellReuseIdentifier: titleCellID)
        newsTableView.register(NewsDetailsTableViewCell.self, forCellReuseIdentifier: detailsCellID)
        newsTableView.estimatedRowHeight = 50
        newsTableView.rowHeight = UITableView.automaticDimension
    }
    
    func getLatestNewsArticles() {
        guard let newsURL = URL(string: newsURL) else {
            return
        }
        
        let request = URLRequest(url: newsURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.articles = self.parseJSONData(data: data)
                
                // Reload newsTableView on main thread
                OperationQueue.main.addOperation {
                    self.newsTableView.reloadData()
                }
            }
            
        })
        task.resume()
    }
    
    func parseJSONData(data: Data) -> [Articles] {
        var articles = [Articles]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:AnyObject]
            print(jsonResult!)
            
            // Parse JSON data
            let jsonArticles = jsonResult?["articles"] as! [AnyObject]
            
            for jsonArticle in jsonArticles {
                var article = Articles()
                article.title = jsonArticle["title"] as? String ?? ""
                article.description = jsonArticle["description"] as? String ?? ""
                article.url = jsonArticle["url"] as? String ?? ""
                article.publishedAt  = jsonArticle["publishedAt"] as? String ?? ""

                articles.append(article)
                print(articles)
            }
        } catch {
            print("Error: \(error)")
        }
        
        return articles
    }

// MARK: - Selectors
    
    @objc func handleExpandClose(button: UIButton) {
        print(button.tag)
    }
    
// MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articles[section].opened == true {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    enum CellType {
        case titleCell, detailsCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: titleCellID) as? NewsTitleTableViewCell else { return UITableViewCell() }
            let section = articles[indexPath.section]
            cell.newsTitleLabel.text = section.title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: detailsCellID) as? NewsDetailsTableViewCell else { return UITableViewCell() }
            let section = articles[indexPath.section]
            cell.descriptionLabel.text = section.description
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = IndexSet.init(integer: indexPath.section)

        if articles[indexPath.section].opened == true {
            articles[indexPath.section].opened = false
            tableView.reloadSections(section, with: .none)
        } else {
            articles[indexPath.section].opened = true
            tableView.reloadSections(section, with: .none)
        }
    }
    
}
