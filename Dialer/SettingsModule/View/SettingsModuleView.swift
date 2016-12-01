//
//  SettingsModuleView.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit


// MARK: - Interface
protocol SettingsModuleViewInput: class {
    func update(withData data: SettingsDomainModel)
    func update(withError error: String)
}

protocol SettingsModuleViewOutput: class {
    func moduleDidLoad()
}

private struct SettingsModuleViewControllerConstants {
    
    static let sectionHeaderHeight: CGFloat = 35.0

}

// MARK: - View Controller
final class SettingsModuleViewController: UITableViewController {
    
    var output: SettingsModuleViewOutput!
    
    @IBOutlet weak var firstThenLastLabel: UILabel!
    @IBOutlet weak var lastThenFirstLabel: UILabel!
    @IBOutlet weak var firstOnlyLabel: UILabel!
    
    @IBOutlet weak var firstThenLastSwitch: UISwitch!
    @IBOutlet weak var lastThenFirstSwitch: UISwitch!
    @IBOutlet weak var firstOnlySwitch: UISwitch!
    
    @IBOutlet weak var seeOnGithubButton: UIButton!
    
    @IBOutlet var switchesArray: [UISwitch]!
    
    var backgroundImageView : UIImageView?
    var blurredEffectView  : UIVisualEffectView?
    var themesDataSource = ThemesDataSource()
    var arrayOfSelections : [Bool]?
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.moduleDidLoad()
        
        localize()
        setTheme()
        
        tableView.isScrollEnabled = false
        
        arrayOfSelections?.append(firstThenLastSwitch.isOn)
        arrayOfSelections?.append(lastThenFirstSwitch.isOn)
        arrayOfSelections?.append(firstOnlySwitch.isOn)
    }
    
    func localize() {
        firstThenLastLabel.text = NSLocalizedString("settings_first_name_last_name", comment: "")
        lastThenFirstLabel.text = NSLocalizedString("settings_last_name_first_name", comment: "")
        firstOnlyLabel.text = NSLocalizedString("settings_first_name_only", comment: "")
        seeOnGithubButton.setTitle(NSLocalizedString("settings_see_on_github_title", comment: ""), for: .normal)
        seeOnGithubButton.setTitle(NSLocalizedString("settings_see_on_github_title", comment: ""), for: .highlighted)
    }
    
    func setTheme() {
        if blurredEffectView == nil {
            
            backgroundImageView = UIImageView.init(frame: view.frame)
            backgroundImageView?.contentMode = .scaleAspectFill
            backgroundImageView?.alpha = 0.9
            
            let blurEffect = UIBlurEffect(style: .light)
            blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView?.frame = view.bounds
            
            view.addSubview(blurredEffectView!)
            view.sendSubview(toBack: blurredEffectView!)
            
            view.addSubview(backgroundImageView!)
            view.sendSubview(toBack: backgroundImageView!)
        }
        
        let theme = themesDataSource.currentTheme()
        tableView.backgroundColor = theme.collectionBackgroundColor()
        backgroundImageView?.image = theme.settingsBackgroundImage()
        //navigationController?.navigationBar.barStyle = theme.barStyle()
        firstThenLastLabel.textColor = theme.mappedTextColor()
        lastThenFirstLabel.textColor = theme.mappedTextColor()
        firstOnlyLabel.textColor = theme.mappedTextColor()
        seeOnGithubButton.setTitleColor(theme.mappedTextColor(), for: .normal)
        seeOnGithubButton.setTitleColor(theme.mappedTextColor(), for: .highlighted)
        
        for uiswitch in switchesArray {
            uiswitch.tintColor = theme.mappedTextColor()
        }
    }
    
    // MARK: Actions
    
    
    // MARK: UITableViewDataSource
    /*
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return versionString()
        }
        return ""
    }*/

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("settings_display_settings_title", comment: "").uppercased()
        }
        return NSLocalizedString("settings_about_app_title", comment: "").uppercased()
    }*/
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var title = ""
        
        if section == 0 {
            title = NSLocalizedString("settings_display_settings_title", comment: "").uppercased()
        }
        else {
            title = NSLocalizedString("settings_about_app_title", comment: "").uppercased()
        }
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0,
                                               width: view.frame.size.width,
                                               height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        let label = UILabel(frame: CGRect(x: 10, y: 4,
                                          width: view.frame.size.width,
                                          height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        label.text = title
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 11)
        label.textColor = UIColor.white
        sectionView.addSubview(label)
        sectionView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0,
                                               width: view.frame.size.width,
                                               height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        let label = UILabel(frame: CGRect(x: 10, y: 0,
                                          width: view.frame.size.width,
                                          height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        label.text = section == 1 ? versionString() : ""
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        label.textColor = UIColor.white
        sectionView.addSubview(label)
        sectionView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SettingsModuleViewControllerConstants.sectionHeaderHeight
    }
    
    // MARK: Other
    
    func versionString() -> String {
        
        var versionString = ""
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionString = versionString + "\(version)"
        }
        if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            versionString = versionString + "(\(build))"
        }
        
        return "v\(versionString)"
    }
}




// MARK: - View Input
extension SettingsModuleViewController: SettingsModuleViewInput {
    
    func update(withData data: SettingsDomainModel) {
        
    }
    
    func update(withError error: String) {
        
    }
}
