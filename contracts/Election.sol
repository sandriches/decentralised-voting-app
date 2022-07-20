// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Election {
    // Candidate model
    struct Candidate {
        uint id;
        string name;
        uint votes;
    }

    // List of candidates
    mapping (uint => Candidate) public candidates;

    // List of voters
    mapping(address => bool) public voters;

    // This is necessary because in solidity, mappings don't have a length
    uint public numberOfCandidates;

    // Trigger an event when a vote has occurred
    event votedEvent (
        uint indexed _candidateId
    );

    function add_to_candidates(string memory _newCandidateName) private {
        numberOfCandidates ++;
        candidates[numberOfCandidates] = Candidate(numberOfCandidates, _newCandidateName, 0);
    }

        function vote (uint _candidateId) public {
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= numberOfCandidates);
        voters[msg.sender] = true;
        candidates[_candidateId].votes ++;
        emit votedEvent(_candidateId);
    }

    constructor() {
        add_to_candidates("First Candidate");
        add_to_candidates("Second Candidate");
    }
}
