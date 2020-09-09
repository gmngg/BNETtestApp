//
//  Router.swift
//  BnetTestGM
//
//  Created by Malygin Georgii on 19.08.2020.
//  Copyright © 2020 Malygin Georgii. All rights reserved.
//

import UIKit

import AuthenticationServices

protocol RouterInput {
    func routeToRoot()
    func routeNewNotes(session: String)
    func routeViewNotes(note: Note)
    func popToRoot()
}

class Router: NSObject {
    
    var navigaton: UINavigationController?
    private var assembly: Assembly
    var context: UIWindow?
    
    init(assembly: Assembly) {
        self.assembly = assembly
    }
}

extension Router: RouterInput {
    
    func routeToRoot() {
        let viewController = assembly.mainViewController()
        let navi = UINavigationController(rootViewController: viewController)
        
        navigaton = navi
        
        context?.rootViewController = navi
        context?.makeKeyAndVisible()
    }
    
    func routeNewNotes(session: String) {
        let viewController = assembly.newNoteViewController(sessionId: session)
        
        navigaton?.pushViewController(viewController, animated: true)
    }
    
    func routeViewNotes(note: Note) {
        let viewController = assembly.fullNoteViewController(note: note)
        
        navigaton?.pushViewController(viewController, animated: true)
    }
    
    func popToRoot() {
        navigaton?.popToRootViewController(animated: true)
    }
}

extension Router: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = context else {
            return ASPresentationAnchor(frame: UIScreen.main.bounds)
        }
        return window
    }
}
