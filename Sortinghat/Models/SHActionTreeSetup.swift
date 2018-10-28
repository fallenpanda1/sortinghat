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

        let mainMenu = ActionBranchNode(
            name: "The Sorting Hat",
            centerNode: ActionNode.branch(declareHouseMenu)
        )

        // TODO: add a super menu whose 'tap' action takes us to 'declare house'
        return mainMenu
    }()

    private static func declareHouseLeaf(house: House) -> ActionNode {
        return ActionNode.leaf(
            ActionLeafNode(
                name: house.name,
                action: DeclareHouseAction(house: house)
            )
        )
    }
}
