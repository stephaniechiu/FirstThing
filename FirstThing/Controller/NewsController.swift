//
//  NewsController.swift
//  FirstThing
//
//  Created by Stephanie on 8/4/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import SafariServices
import UserNotifications

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {

// MARK: - Properties
    let newsView = NewsView()
    let newsTableView = UITableView()
    let currentTime = Date()
    let titleCellID = "TitleCell"
    let detailsCellID = "DetailsCell"
    let sectionHeaderID = "SectionHeader"
    let categoryHeaders = ["Top Headlines", "Fashion", "Tech"]
    let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=e2f0b28b0f0146dcb2b9c2ce5c3142a7"
    var articles = [Articles]()
    var tableViewData = [[Articles]]()
    var titleHeader = ""
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
// MARK: - Init
    
    //Initialize onboarding view controllers (OnboardingCategoryController)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if Onboarding.shared.isNewUser() {
            let onboardingCategoryController = OnboardingCategoryController()
            onboardingCategoryController.modalPresentationStyle = .fullScreen
            present(onboardingCategoryController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = newsView
        
        setupNavigationController()
        setupLayout()
        setupDateFormatter()
        setupTableView()
        getLatestNewsArticles()
        
        userNotificationCenter.delegate = self
        requestNotificationAuthorization()
        sendNotification()
    }

// MARK: - Helper Functions
    func setupNavigationController() {
        navigationController?.navigationBar.tintColor = .clear
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupLayout() {
        newsView.gradientBackground.frame = view.bounds
        view.layer.insertSublayer(newsView.gradientBackground, at: 0)
        
        view.addSubview(newsTableView)
        newsTableView.anchor(top: newsView.firstThingTitle.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 50)
    }
    
    func setupDateFormatter() {
        let formatter = ISO8601DateFormatter()
        let datetime = formatter.string(from: currentTime)
        print("-------Current Time: \(datetime)--------")
    }
    
    func setupTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(NewsTitleTableViewCell.self, forCellReuseIdentifier: titleCellID)
        newsTableView.register(NewsDetailsTableViewCell.self, forCellReuseIdentifier: detailsCellID)
        newsTableView.estimatedRowHeight = 50
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.separatorStyle = .none
        
        //Pull to refresh
        newsTableView.refreshControl = UIRefreshControl()
        newsTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
      
// MARK: - API Call
    
    func getLatestNewsArticles() {
        // Remove all articles before fetching data from API when pulling to refresh
        articles.removeAll()
        
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
                
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    self.newsTableView.refreshControl?.endRefreshing()
                }
                
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
//            print(jsonResult!)
            
            // Parse JSON data
            let jsonArticles = jsonResult?["articles"] as! [AnyObject]
            
            for jsonArticle in jsonArticles {
                var article = Articles()
                article.title = jsonArticle["title"] as? String ?? ""
                article.description = jsonArticle["description"] as? String ?? ""
                article.url = jsonArticle["url"] as? String ?? ""
                article.publishedAt  = jsonArticle["publishedAt"] as? String ?? ""

                articles.append(article)
            }
            tableViewData.append(articles)
            print(tableViewData)
        } catch {
            print("Error: \(error)")
        }
        return articles
    }
    
// MARK: - Local Notification
    
    func requestNotificationAuthorization() {
            let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
            
            //Ask for user permission to send notifications
            self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
                if let error = error {
                    print("Error: ", error)
                }
            }
        }

        func sendNotification() {
            let notificationContent = UNMutableNotificationContent()

            notificationContent.title = "Good morning!"
            notificationContent.body = "Here's what you missed out on last night..."
    //        notificationContent.badge = NSNumber(value: 3)
            
            var dateComponents = DateComponents()
            dateComponents.hour = 19
            dateComponents.minute = 27
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
            
            userNotificationCenter.add(request) { (error) in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .badge, .sound])
        }

// MARK: - Selectors
    
    @objc func pullToRefresh() {
        getLatestNewsArticles()
    }
    
// MARK: - TableView Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return categoryHeaders[section]
//    }
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: titleCellID) as? NewsTitleTableViewCell else { return UITableViewCell() }
            let section = articles[indexPath.section]
            cell.newsTitleLabel.text = section.title
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: detailsCellID) as? NewsDetailsTableViewCell else { return UITableViewCell() }
            let section = articles[indexPath.section]
            
            //Article description
            cell.descriptionLabel.text = section.description
        
            //Time since article was published
            let formatter = ISO8601DateFormatter()
            let publishedTime = formatter.date(from: section.publishedAt) ?? currentTime
            let timeSincePublished = Calendar.current.dateComponents([.minute, .hour], from: publishedTime, to: currentTime)
            let minutes = timeSincePublished.minute
            let hours = timeSincePublished.hour
            
            if minutes == 1  && hours ?? 0 < 1 {
                cell.lastUpdatedLabel.text = "\(minutes ?? 0) minute ago"
            } else if minutes ?? 0 < 60 && hours ?? 0 < 1 {
                cell.lastUpdatedLabel.text = "\(minutes ?? 0) minutes ago"
            } else if minutes ?? 1 == 60 || hours ?? 1 == 1 {
                cell.lastUpdatedLabel.text = "\(hours ?? 0) hour ago"
            } else if minutes! < 60 && hours ?? 1 > 1 {
                cell.lastUpdatedLabel.text = "\(hours ?? 0) hours ago"
            }
            
            //When user taps on "Read More", the full article will open within the app
            cell.readMoreAction = { sender in
                let articleURL = URL(string: section.url)
                let articleVC = SFSafariViewController(url: articleURL!)
                self.present(articleVC, animated: true, completion: nil)
            }

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
        
        tableView.deselectRow(at: indexPath, animated: true)
        titleHeader = categoryHeaders[indexPath.section]
        if titleHeader == "Top Headlines" {
            print("top headlines")
        }
    }
    
}

class Onboarding {
    static let shared = Onboarding()
    
    func isNewUser() -> Bool {
        //Returns true when app first launches
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
