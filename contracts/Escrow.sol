pragma solidity ^0.4.19;

contract Escrow {
  struct caseType {
    address plaintiff;
    address defendant;
    uint balance;
  }
  mapping(uint => caseType) public cases;
  uint public caseIdCounter;

  function initEscrow(address defendant, address plaintiff) public payable returns (uint) {
    cases[caseIdCounter] = caseType({
      plaintiff: plaintiff,
      defendant: defendant,
      balance: msg.value
    });

    return caseIdCounter++;
  }

  function receiveIt (uint caseId) public payable returns (uint) {
    cases[caseId].balance += msg.value;
    return cases[caseId].balance;
  }

  function sendIt (uint caseId) public returns (bool) {
    cases[caseId].plaintiff.transfer(cases[caseId].balance);
    cases[caseId].balance = 0;
    return true;
  }
}
