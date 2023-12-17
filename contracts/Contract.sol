// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract ProjectFunding {
    struct Project {
        uint256 id;
        string name;
        string description;
        address creator;
        uint256 creationDate;
        string status;
        string documentsHash;
    } 

    mapping(uint256 => Project) public projects;
    uint256 public numberOfProjects = 0;

    function createProject(address _creator, string memory _name, string memory _description, string memory _documentHash) public returns (uint256) {
        Project storage project = projects[numberOfProjects];
        project.id = numberOfProjects;
        project.name = _name;
        project.description = _description;
        project.creator = _creator;
        project.creationDate = block.timestamp;
        project.status = "pending";
        project.documentsHash = _documentHash;

        numberOfProjects++;

        return numberOfProjects - 1;

    }

    function fundTheProject(uint256 _id) public payable {   
        uint256 amount = msg.value;

        Project storage project = projects[_id];

        (bool sent, ) = payable(project.creator).call{value: amount}("");
    }

    function getProjects() public view returns (Project[] memory) {
        Project[] memory allProjects = new Project[](numberOfProjects);

        for (uint i = 0; i < numberOfProjects; i++) {
            Project storage item = projects[i];

            allProjects[i] = item;
        }

        return allProjects;

    }

}