/**
 *  Copyright (C) 2010-2018 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

class SearchStoreViewController: UIViewController, SelectedSearchStoreDataSource {
  
    @IBOutlet weak var SearchStoreTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    private var dataSource: SearchStoreDataSource
    
    var loadingView: LoadingView?
    var shouldHideLoadingView = false
    var programForSegue: StoreProgram?
    var catrobatProject: StoreProgram?
    var loadingViewFlag = false
    var noSearchResultsLabel: UILabel!
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        self.dataSource = SearchStoreDataSource.dataSource()
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        initNoSearchResultsLabel()
        shouldHideLoadingView = false
        dataSource.delegate = self
        SearchStoreTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingViewHandlerAfterFetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueToProgramDetail {
            if let programDetailStoreViewController = segue.destination as? ProgramDetailStoreViewController,
                let catrobatProject = programForSegue {
                programDetailStoreViewController.project = mapStoreProgramToCatrobatProgram(program: catrobatProject)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func mapStoreProgramToCatrobatProgram(program: StoreProgram) -> CatrobatProgram {
        var programDictionary = [String: Any]()
        programDictionary["ProjectName"] = program.projectName
        programDictionary["Author"] =  program.author
        programDictionary["Description"] = program.description ?? ""
        programDictionary["DownloadUrl"] = program.downloadUrl ?? ""
        programDictionary["Downloads"] = program.downloads ?? 0
        programDictionary["ProjectId"] = program.projectId
        programDictionary["ProjectName"] = program.projectName
        programDictionary["ProjectUrl"] = program.projectUrl ?? ""
        programDictionary["ScreenshotBig"] = program.screenshotBig ?? ""
        programDictionary["ScreenshotSmall"] = program.screenshotSmall ?? ""
        programDictionary["FeaturedImage"] = program.featuredImage ?? ""
        programDictionary["Uploaded"] = program.uploaded ?? 0
        programDictionary["Version"] = program.version ?? ""
        programDictionary["Views"] = program.views ?? 0
        programDictionary["FileSize"] = program.fileSize ?? 0.0
        
        return CatrobatProgram(dict: programDictionary, andBaseUrl: kFeaturedImageBaseUrl)
    }
    
    func initNoSearchResultsLabel() {
        noSearchResultsLabel = UILabel(frame: view.frame)
        noSearchResultsLabel.text = kLocalizedNoSearchResults
        noSearchResultsLabel.textAlignment = .center
        noSearchResultsLabel.textColor = UIColor.globalTint()
        noSearchResultsLabel.tintColor = UIColor.globalTint()
        noSearchResultsLabel.isHidden = true
        view.addSubview(noSearchResultsLabel)
    }
    
    private func showConnectionIssueAlertAndDismiss(error: StoreProgramDownloaderError) {
        var title = ""
        var message = ""
        let buttonTitle = kLocalizedOK
        
        switch error {
        case .timeout:
            title = kLocalizedServerTimeoutIssueTitle
            message = kLocalizedServerTimeoutIssueMessage
        default:
            title = kLocalizedFeaturedProgramsLoadFailureTitle
            message = kLocalizedFeaturedProgramsLoadFailureMessage
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(title: buttonTitle, style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        self.SearchStoreTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.SearchStoreTableView.backgroundColor = UIColor.background()
        self.SearchStoreTableView.separatorColor = UIColor.globalTint()
        self.SearchStoreTableView.dataSource = self.dataSource
        self.SearchStoreTableView.delegate = self.dataSource
        self.searchBar.delegate  = self.dataSource
    }
    
    func loadingViewHandlerAfterFetchData() {
        if loadingViewFlag == false {
            self.showLoadingView()
            self.shouldHideLoadingView = true
            self.hideLoadingView()
        }
        else {
            self.shouldHideLoadingView = true
            self.hideLoadingView()
            loadingViewFlag = false
        }
    }
        
    func showLoadingView() {
        if loadingView == nil {
            loadingView = LoadingView()
            view.addSubview(loadingView!)
        }
        loadingView!.show()
        loadingIndicator(true)
    }
    
    func hideLoadingView() {
        if shouldHideLoadingView {
            loadingView!.hide()
            loadingIndicator(false)
            self.shouldHideLoadingView = false
        }
    }
    
    func loadingIndicator(_ value: Bool) {
        let app = UIApplication.shared
        app.isNetworkActivityIndicatorVisible = value
    }
}

extension SearchStoreViewController: SearchStoreCellProtocol {
    func selectedCell(dataSource: SearchStoreDataSource, didSelectCellWith cell: SearchStoreCell) {
        if let program = cell.program {
            self.showLoadingView()
            programForSegue = program
            performSegue(withIdentifier: kSegueToProgramDetail, sender: self)
        }
    }
}

extension SearchStoreViewController {

    func updateTableView() {
        self.SearchStoreTableView.reloadData()
        self.SearchStoreTableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    func searchBarHandler(dataSource: SearchStoreDataSource, searchTerm: String) {
        self.showLoadingView()
        self.dataSource.fetchItems(searchTerm: searchTerm) { error in
            if error != nil {
                self.shouldHideLoadingView = true
                self.hideLoadingView()
                self.showConnectionIssueAlertAndDismiss(error: error!)
                return
            }
            self.SearchStoreTableView.reloadData()
            self.shouldHideLoadingView = true
            self.hideLoadingView()
            self.SearchStoreTableView.separatorStyle = .singleLine
        }
    }
    
    func showNoResultsAlert() {
        self.SearchStoreTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        noSearchResultsLabel.isHidden = false
    }
    
    func hideNoResultsAlert() {
        noSearchResultsLabel.isHidden = true
    }
}