// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Voting 投票合约
 * @dev 一个简单的投票系统，包含基础功能和进阶功能
 */
contract Voting {
    
    // ==================== 基础版本 ====================
    
    // 存储候选人得票数的mapping
    // string是候选人名字，uint256是得票数
    mapping(string => uint256) public votes;
    
    // 记录所有候选人名单（方便查询）
    string[] public candidates;
    
    // 检查候选人是否存在的mapping
    mapping(string => bool) public candidateExists;
    
    // 合约拥有者（部署者）
    address public owner;
    
    // 总投票数
    uint256 public totalVotes;
    
    // 事件：当有人投票时触发
    event VoteCast(string candidate, uint256 newVoteCount, address voter);
    
    // 事件：当重置投票时触发
    event VotesReset(address resetBy);
    
    // 事件：当添加候选人时触发
    event CandidateAdded(string candidate);
    
    // 构造函数：部署合约时执行
    constructor() {
        owner = msg.sender; // 设置合约拥有者为部署者
    }
    
    // 修饰符：只有合约拥有者可以执行
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    /**
     * @dev 添加候选人
     * @param candidate 候选人名字
     */
    function addCandidate(string memory candidate) public onlyOwner {
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        require(!candidateExists[candidate], "Candidate already exists");
        
        candidates.push(candidate);
        candidateExists[candidate] = true;
        votes[candidate] = 0; // 初始化得票数为0
        
        emit CandidateAdded(candidate);
    }
    
    /**
     * @dev 投票函数 - 基础版本
     * @param candidate 候选人名字
     */
    function vote(string memory candidate) public {
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        require(candidateExists[candidate], "Candidate does not exist");
        
        // 增加该候选人的得票数
        votes[candidate]++;
        totalVotes++;
        
        // 触发事件
        emit VoteCast(candidate, votes[candidate], msg.sender);
    }
    
    /**
     * @dev 获取候选人得票数
     * @param candidate 候选人名字
     * @return 该候选人的得票数
     */
    function getVotes(string memory candidate) public view returns (uint256) {
        require(candidateExists[candidate], "Candidate does not exist");
        return votes[candidate];
    }
    
    /**
     * @dev 重置所有候选人的得票数
     */
    function resetVotes() public onlyOwner {
        // 遍历所有候选人，将得票数重置为0
        for (uint256 i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
        totalVotes = 0;
        
        emit VotesReset(msg.sender);
    }
}