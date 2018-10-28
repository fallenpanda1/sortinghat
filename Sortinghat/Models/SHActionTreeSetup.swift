/// SortingHat app-specific action tree setup
struct SHActionTreeSetup {
    /// Declaration of the overall tree structure for the SortingHat app
    static let root: ActionBranchNode = {
        let declareHouseMenu = ActionBranchNode(
            name: "Declare House",
            topAction: declareHouseLeaf(house: .gryffindor),
            leftAction: declareHouseLeaf(house: .hufflepuff),
            bottomAction: declareHouseLeaf(house: .slytherin),
            rightAction: declareHouseLeaf(house: .ravenclaw)
        )

        // TODO: add a super menu whose 'tap' action takes us to 'declare house'
        return declareHouseMenu
    }()

    private static func declareHouseLeaf(house: House) -> ActionNode {
        return ActionNode.leaf(
            ActionLeafNode(
                name: house.rawValue.capitalized,
                action: DeclareHouseAction(house: house)
            )
        )
    }
}
