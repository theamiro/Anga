//
//  AppDelegate.swift
//  Anga
//
//  Created by Michael Amiro on 12/05/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        guard let logo = NSImage(named: NSImage.Name("cloud")) else { return }
        
        let resizedLogo = NSImage(size: NSSize(width: 26, height: 13), flipped: false) { (dstRect) -> Bool in
            logo.draw(in: dstRect)
            return true
        }
        statusItem.button?.image = resizedLogo
        statusItem.button?.imagePosition = .imageLeft
        statusItem.button?.title = "63º"
        
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showApp)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc
    func showApp() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateController(withIdentifier: "homepage") as? ViewController else {
            fatalError("View Controller does not exist")
        }
        guard let menuButton = statusItem.button else {
            fatalError("Menu Button does not exist")
        }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = viewController
        popoverView.behavior = .transient
        popoverView.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .maxY)
    }

}

