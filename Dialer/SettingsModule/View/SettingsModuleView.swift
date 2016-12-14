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
    func setNameDisplayStyle(_ style : NameDisplayStyle)
}

private struct SettingsModuleViewControllerConstants {
    
    static let sectionHeaderHeight: CGFloat = 35.0
    static let sectionLabelLeading: CGFloat = 10.0
    static let sectionLabelTop: CGFloat = 4.0
    static let sectionFooterLabelTop: CGFloat = 0.0
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
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.moduleDidLoad()
        
        localize()
        tableView.isScrollEnabled = false
        
        firstOnlySwitch.addTarget(self, action: #selector(showNameOnlyDidChanged(sender:)), for: .valueChanged)
        firstThenLastSwitch.addTarget(self, action: #selector(showNameThenSurnameDidChanged(sender:)), for: .valueChanged)
        lastThenFirstSwitch.addTarget(self, action: #selector(showSurnameThenNameDidChanged(sender:)), for: .valueChanged)
    }
    
    func localize() {
        firstThenLastLabel.text = NSLocalizedString("settings_first_name_last_name", comment: "")
        lastThenFirstLabel.text = NSLocalizedString("settings_last_name_first_name", comment: "")
        firstOnlyLabel.text = NSLocalizedString("settings_first_name_only", comment: "")
        seeOnGithubButton.setTitle(NSLocalizedString("settings_see_on_github_title", comment: ""), for: .normal)
        seeOnGithubButton.setTitle(NSLocalizedString("settings_see_on_github_title", comment: ""), for: .highlighted)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTheme()
    }
    
    func setTheme() {
        if blurredEffectView == nil {
            
            backgroundImageView = UIImageView.init(frame: view.frame)
            backgroundImageView?.contentMode = .scaleAspectFill
            
            let blurEffect = UIBlurEffect(style: .light)
            blurredEffectView = UIVisualEffectView(effect: blurEffect)
            blurredEffectView?.frame = view.bounds
            blurredEffectView?.alpha = 0.1
            
            view.addSubview(blurredEffectView!)
            view.sendSubview(toBack: blurredEffectView!)
            
            view.addSubview(backgroundImageView!)
            view.sendSubview(toBack: backgroundImageView!)
        }
        
        let theme = themesDataSource.currentTheme()
        tableView.backgroundColor = theme.collectionBackgroundColor()
        backgroundImageView?.image = theme.settingsBackgroundImage()
        firstThenLastLabel.textColor = theme.mappedTextColor()
        lastThenFirstLabel.textColor = theme.mappedTextColor()
        firstOnlyLabel.textColor = theme.mappedTextColor()
        seeOnGithubButton.setTitleColor(theme.mappedTextColor(), for: .normal)
        seeOnGithubButton.setTitleColor(theme.mappedTextColor(), for: .highlighted)
        
        for uiswitch in switchesArray {
            uiswitch.tintColor = theme.mappedTextColor()
            uiswitch.onTintColor = theme.notMappedTextColor()
        }
        
        self.tableView.reloadData()
    }
    
    func setDefaultSwitchesConfiguration() {
        firstThenLastSwitch.isOn = true
        lastThenFirstSwitch.isOn = false
        firstOnlySwitch.isOn = false
    }
    
    // MARK: Actions
    
    func showNameThenSurnameDidChanged(sender : UISwitch) {
        configureSwitchesWith(sender: sender)
        if sender.isOn {
            output.setNameDisplayStyle(.firstThenLast)
        }
    }
    
    func showSurnameThenNameDidChanged(sender : UISwitch) {
        configureSwitchesWith(sender: sender)
        if sender.isOn {
            output.setNameDisplayStyle(.lastThenFirst)
        }
    }
    
    func showNameOnlyDidChanged(sender : UISwitch) {
        configureSwitchesWith(sender: sender)
        if sender.isOn {
            output.setNameDisplayStyle(.firstNameOnly)
        }
    }
    
    func configureSwitchesWith(sender : UISwitch) {
        
        if sender.isOn {
            for uiswitch in switchesArray {
                if uiswitch != sender {
                    uiswitch.isOn = false
                }
            }
        } else {
            setDefaultSwitchesConfiguration()
        }
        
    }
    
    @IBAction func showGithubCode(_ sender: UIButton) {
        
        let urlString = valueFromPlistForKey(key : "Github") as? String
        
        if let urlAddress = urlString {
            if let url = URL(string: urlAddress), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    // MARK: UITableView

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.1)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: view.frame.size.width,
                                               height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        let label = UILabel(frame: CGRect(x: SettingsModuleViewControllerConstants.sectionLabelLeading,
                                          y: SettingsModuleViewControllerConstants.sectionLabelTop,
                                          width: view.frame.size.width,
                                          height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        label.text = titleForHeaderSection(section : section)
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 12)
        label.textColor = themesDataSource.currentTheme().mappedTextColor()
        sectionView.addSubview(label)
        sectionView.backgroundColor = themesDataSource.currentTheme().tableHeaderColor()
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let sectionView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: view.frame.size.width,
                                               height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        let label = UILabel(frame: CGRect(x: SettingsModuleViewControllerConstants.sectionLabelLeading,
                                          y: SettingsModuleViewControllerConstants.sectionFooterLabelTop,
                                          width: view.frame.size.width,
                                          height: SettingsModuleViewControllerConstants.sectionHeaderHeight))
        
        label.text = section == 1 ? versionString() : ""
        label.font = UIFont.init(name: "HelveticaNeue-Light", size: 13)
        label.textColor = themesDataSource.currentTheme().mappedTextColor()
        sectionView.addSubview(label)
        sectionView.backgroundColor = themesDataSource.currentTheme().tableHeaderColor()
        return sectionView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SettingsModuleViewControllerConstants.sectionHeaderHeight
    }
    
    // MARK: Other
    
    func titleForHeaderSection(section : Int) -> String {
        let title = section == 0 ?
            NSLocalizedString("settings_display_settings_title", comment: "") :
            NSLocalizedString("settings_about_app_title", comment: "")
        return title.uppercased()
    }
    
    func valueFromPlistForKey(key : String) -> Any? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            if let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] {
                if let value = dictionary[key] {
                    return value
                }
            }
        }
        return nil
    }
    
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
