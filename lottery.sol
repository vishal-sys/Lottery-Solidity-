//SPDX-License-Identifier:UNLICENSED
pragma solidity >=0.7.0 < 0.9.0;
contract solidemo{
    address  admin;
    address payable[] public participants;
    constructor(){
        admin=msg.sender;
    }
    receive() external payable {
        require(msg.value==3 ether,"Please enter recommended amount");
        participants.push(payable(msg.sender));
    }
    function getBalance()  public view  returns(uint256)
    {   require(msg.sender==admin,"Only admin can access this function");
        return address(this).balance;
    }
    function random() public view returns(uint256){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
    }
    function getWinner() public  {
        require(msg.sender==admin,"Only admin can access this function");
        require(participants.length>=3);
        address  payable  winner;
        uint r=random();
        uint index=r % participants.length;
        winner=participants[index];
        winner.transfer(getBalance());
        participants =new address payable[](0);
    }
    function length() public view returns(uint256){
        return participants.length;
    }
}