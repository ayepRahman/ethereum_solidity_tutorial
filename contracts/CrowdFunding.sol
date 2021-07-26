// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;


/**
 * The Crowd Funding Contract - Planning and Design
 * 
 * - The Admin will start a campaign for CrowdFunding with a specific monetary goal and deadline.
 * - Contributors will contribute to that project by sending ETH.
 * - The admin has to create a Spending Request to spend money for the campaign.
 * - Once the spending request was created, the Contributors can start voting for that specific Spending Request.
 * - If more than 50% of the total contributors voted for that request, than the admin would have the permission to spend the amount specified on the spending request.
 * - The power is moved from the campaign's admin to those that donated money.
 * - The contributors can request a refund if the monetary goal was not reached within the deadline.
 */
 
 contract CrowdFunding {
     mapping(address => uint) public contributors;
     address public admin;
     uint public noOfContributors;
     uint public minContributors;
     uint public deadline; // timestamp in seconds
     uint public goal;
     uint public raisedAmount;
     struct Request {
         string description;
         address payable recipient;
         uint value;
         bool completed;
         uint noOfVoters;
         mapping(address => bool) votes;
     }
     
     mapping(uint => Request) public requests;
     uint public numRequests;
     
     constructor(uint _goal, uint _deadline) {
         goal = _goal;
         deadline = block.timestamp + _deadline;
         minContributors = 0.01 ether;
         admin = msg.sender;
     }
     
     event ContributeEvent(address _sender, uint _value);
     event CreateRequestEvent(string _description, address _recipient, uint _value);
     event MakePaymentEvent(address _recipient, uint _value);
     
     function contribute() public payable {
         require(block.timestamp < deadline, 'Crowd Funding Dealine has passed!');
         require(msg.value >= minContributors, 'Minimum Contributoon is not met!');
         
         // we checking if user already contribute hence we increase the no. of 'noOfContributors'
         if (contributors[msg.sender] == 0) {
             noOfContributors++;
         }
         
         contributors[msg.sender] += msg.value;
         raisedAmount += msg.value;
         
         emit ContributeEvent(msg.sender, msg.value);
     }
     
     receive() payable external {
         contribute();
     }
     
     // check th contract address balance.
     function getBalance() public view returns(uint){
         return address(this).balance;
     }
     
     function getRefund() public {
         // check if deadline is passed and the raised amount is is not met!
         require(block.timestamp > deadline && raisedAmount < goal);
         // user can only get refund if they are part of a contributor.
         require(contributors[msg.sender] > 0);
         
         payable(msg.sender).transfer(contributors[msg.sender]);
         
        //  address payable recipient = payable(msg.sender);
        //  uint value = contributors[msg.sender];
        //  recipient.transfer(value);
         
        contributors[msg.sender] = 0;
     }
     
     modifier onlyAdmin() {
         require(msg.sender == admin, 'Only Admin can call this function!');
         _;
     }
     
     function createRequest(string memory _description, address payable _recipient, uint _value) public onlyAdmin {
         // new request used the numRequests as an index.
         Request storage newRequest = requests[numRequests];
         numRequests++;
         
         newRequest.description = _description;
         newRequest.recipient = _recipient;
         newRequest.value  = _value;
         newRequest.completed = false;
         newRequest.noOfVoters = 0;
         
         emit CreateRequestEvent(_description, _recipient, _value);
     }
     
     function voteRequest(uint _requestNo) public {
         require(contributors[msg.sender] > 0, "You must be a contributor to vote!");
         Request storage thisRequest = requests[_requestNo];
         
         // require the contributor to have note voted!
         require(thisRequest.votes[msg.sender] == false, 'You have already voted!');
         thisRequest.votes[msg.sender] = true;
         thisRequest.noOfVoters++;
     }
     
     function makePayment(uint _requestNo) public onlyAdmin {
         require(raisedAmount >= goal);
         Request storage thisRequest = requests[_requestNo];
         require(thisRequest.completed == false, "The request for payment has been completed!");
         require(thisRequest.noOfVoters > noOfContributors / 2); // 50% voted for this request!.
         
         thisRequest.recipient.transfer(thisRequest.value);
         thisRequest.completed = true;
         
         emit MakePaymentEvent(thisRequest.recipient, thisRequest.value);
     }   
 }