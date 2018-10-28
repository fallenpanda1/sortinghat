/// SortingHat app-specific action tree setup
struct SHActionTreeSetup {
    /// Declaration of the overall tree structure for the SortingHat app
    static let root: ActionBranchNode = {
        let declareHouseMenu = ActionBranchNode(
            name: "Declare House",
            topNode: declareHouseLeaf(house: .gryffindor),
            leftNode: declareHouseLeaf(house: .hufflepuff),
            bottomNode: declareHouseLeaf(house: .slytherin),
            rightNode: declareHouseLeaf(house: .ravenclaw)
        )

        let thinkMenu = ActionBranchNode(
            name: "Delay Tactics",
            topNode: leafNode(withName: "Random Think", action: ThinkAction())
        )

        let mainMenu = ActionBranchNode(
            name: "The Sorting Hat",
            centerNode: ActionNode.branch(declareHouseMenu),
            topNode: ActionNode.branch(thinkMenu)
        )

        // TODO: add a super menu whose 'tap' action takes us to 'declare house'
        return mainMenu
    }()

    /// Convenience function for a leaf node of declaring a house
    private static func declareHouseLeaf(house: House) -> ActionNode {
        return leafNode(withName: house.name, action: DeclareHouseAction(house: house))
    }

    /// Convenience function to save on a few lines of code when creating
    /// leaf nodes.
    private static func leafNode(withName name: String, action: Action) -> ActionNode {
        return ActionNode.leaf(
            ActionLeafNode(
                name: name,
                action: action
            )
        )
    }
}
