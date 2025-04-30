# decentralized-healthcare-database-using-face-recognition
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FacialAuth {
    struct User {
        string faceDataHash;  // SHA-256 hash of facial data
        uint256 timestamp;    // When the user was registered
        bool exists;          // Check if user exists
    }
    
    // Mapping from user address to User struct
    mapping(address => User) private users;
    
    // Events
    event UserRegistered(address indexed userAddress, string faceDataHash, uint256 timestamp);
    event AuthenticationAttempt(address indexed userAddress, bool success);
    
    // Register a new user with facial data hash
    function registerUser(string memory _faceDataHash) public {
        require(!users[msg.sender].exists, "User already registered");
        
        users[msg.sender] = User({
            faceDataHash: _faceDataHash,
            timestamp: block.timestamp,
            exists: true
        });
        
        emit UserRegistered(msg.sender, _faceDataHash, block.timestamp);
    }
    
    // Update existing user's facial data
    function updateFacialData(string memory _newFaceDataHash) public {
        require(users[msg.sender].exists, "User not registered");
        
        users[msg.sender].faceDataHash = _newFaceDataHash;
        users[msg.sender].timestamp = block.timestamp;
    }
    
    // Get user's facial data hash
    function getUserFaceDataHash() public view returns (string memory) {
        require(users[msg.sender].exists, "User not registered");
        return users[msg.sender].faceDataHash;
    }
    
    // Verify if provided hash matches stored hash
    function verifyUser(string memory _faceDataHash) public returns (bool) {
        require(users[msg.sender].exists, "User not registered");
        
        // Compare hashes
        bool success = keccak256(abi.encodePacked(users[msg.sender].faceDataHash)) == 
                      keccak256(abi.encodePacked(_faceDataHash));
        
        emit AuthenticationAttempt(msg.sender, success);
        
        return success;
    }
    
    // Check if user exists
    function userExists() public view returns (bool) {
        return users[msg.sender].exists;
    }
    
    // Delete user
    function deleteUser() public {
        require(users[msg.sender].exists, "User not registered");
        delete users[msg.sender];
    }
}
