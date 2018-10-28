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

/// Lists out all possible branch children for our purposes
enum ActionBranchChildPosition {
    case center
    case top
    case left
    case bottom
    case right
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

    func childNode(forPosition position: ActionBranchChildPosition) -> ActionNode? {
        switch position {
        case .center:
            return centerAction
        case .top:
            return topAction
        case .left:
            return leftAction
        case .bottom:
            return bottomAction
        case .right:
            return rightAction
        }
    }
}

struct ActionLeafNode {
    let name: String
    let action: Action
}
