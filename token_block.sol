//SPDX-License-Identifier: UNLICENSED

pragma solidity  ^0.8.6;

interface ERC20Interface
{ 
    function totalSupply() external view returns (uint); function balanceOf(address tokenOwner) external view returns (uint balance); function transfer(address to, uint tokens) external returns (bool success);
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract Block is ERC20Interface
{
    string public name="Block";
    string public symbol="BLK";

    string public decimal="0";
    uint public override totalSupply;
    address public founder;
    mapping(address=>uint) public balance;
    mapping(address=>mapping(address=>uint)) allowed;


    constructor()
    {
        totalSupply=1000000000;
        founder=msg.sender;
        balance[founder]=totalSupply;
    }


    function balanceOf(address tokenOwner) public view override returns(uint balances)
    {
        return balance[tokenOwner];
    }
    
    function transfer(address to,uint tokens) public override returns(bool success)
    {
    require(balance[msg.sender]>=tokens);
    balance[to]+=tokens;
    balance[msg.sender]-=tokens;
    emit Transfer(msg.sender,to,tokens);
    return true;

    }

    function approve(address spender,uint tokens) public override returns(bool success)
    {
    require(balance[msg.sender]>=tokens);
    require(tokens>0);
    allowed[msg.sender][spender]=tokens;
    emit Approval(msg.sender,spender,tokens);
    return true;
    }

    function allowance(address tokenOwner,address spender) public view override returns(uint noOfTokens)
    {
    return allowed[tokenOwner][spender];
    }

    function transferFrom(address from,address to,uint tokens) public override returns(bool success)
    {
    require(allowed[from][to]>=tokens);
    require(balance[from]>=tokens);
    balance[from]-=tokens;
    balance[to]+=tokens;
    return true;
    }

}
