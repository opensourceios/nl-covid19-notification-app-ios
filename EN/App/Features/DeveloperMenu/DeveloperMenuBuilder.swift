/*
* Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
*  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
*
*  SPDX-License-Identifier: EUPL-1.2
*/

import Foundation

protocol DeveloperMenuListener: AnyObject {
    func developerMenuRequestsOnboardingFlow()
}

/// @mockable
protocol DeveloperMenuBuildable {
    /// Builds DeveloperMenu
    ///
    /// - Parameter listener: Listener of created DeveloperMenuViewController
    func build(listener: DeveloperMenuListener) -> ViewControllable
}

protocol DeveloperMenuDependency {
    var mutableExposureStateStream: MutableExposureStateStreaming { get }
}

private final class DeveloperMenuDependencyProvider: DependencyProvider<DeveloperMenuDependency> {
    var mutableExposureStateStream: MutableExposureStateStreaming {
        return dependency.mutableExposureStateStream
    }
}

final class DeveloperMenuBuilder: Builder<DeveloperMenuDependency>, DeveloperMenuBuildable {
    func build(listener: DeveloperMenuListener) -> ViewControllable {
        let dependencyProvider = DeveloperMenuDependencyProvider(dependency: dependency)
        
        return DeveloperMenuViewController(listener: listener,
                                           mutableExposureStateStream: dependencyProvider.mutableExposureStateStream)
    }
}
