/// Tree structure for navigating through actions
enum ActionNode {
    case branch(ActionBranchNode)
    case leaf(ActionLeafNode)

    var name: String {
        switch self {
        case .branch(let branchNode):
            return branchNode.name
        case .leaf(let leafNode):
            return leafNode.name
        }
    }
}

/// A node that has subnodes
class ActionBranchNode {
    let name: String
    let centerAction: ActionNode?
    let topAction: ActionNode?
    let leftAction: ActionNode?
    let bottomAction: ActionNode?
    let rightAction: ActionNode?

    init(name: String,
         centerAction: ActionNode? = nil,
         topAction: ActionNode? = nil,
         leftAction: ActionNode? = nil,
         bottomAction: ActionNode? = nil,
         rightAction: ActionNode? = nil) {
        self.name = name
        self.centerAction = centerAction
        self.topAction = topAction
        self.leftAction = leftAction
        self.bottomAction = bottomAction
        self.rightAction = rightAction
    }

    /// Convenience empty branch
    static func empty() -> ActionBranchNode {
        return ActionBranchNode(name: "")
    }
}

struct ActionLeafNode {
    let name: String
    let action: Action
}
