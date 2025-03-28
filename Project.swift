import ProjectDescription

let project = Project(
    name: "Nizo-Viper",
    organizationName: "com.nizo",
    targets: [
        .target(
            name: "Nizo-Viper",
            destinations: .iOS,
            product: .app,
            productName: "Nizo-Viper",
            bundleId: "com.nizo.Nizo-Viper",
            deploymentTargets: .iOS("18.0"),
            infoPlist: .default,
            sources: "Nizo-Viper/**.swift",
            resources: .resources(
                [
                    .folderReference(path: "Nizo-Viper/Assets.xcassets")
                ]
            )
        )
    ]
)
