//SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;
 
contract A{
int public x = 10;
int y = 20; // internal by default
 
// public function
function get_y() public view returns(int){
return y;
}
 
 
// private function, can be called only within this contract (not within derived contracts)
function f1() private view returns(int){
return x;
}
 
function f2() public view returns(int){
int a;
a = f1(); // can call f1
return a;
}
 
// can be called only within this contract and derived ones
function f3() internal view returns(int){
return x;
}
 
// can be called only from external contracts and application (more efficient than public)
function f4() external view returns(int){
return x;
}
 
 
function f5() public view returns(int){
int b;
// b = f4(); // ERROR => f4() is external
b = f3(); // OK => f3() is internal
b = f1(); // OK => f1() is private
return b;
}
}
 
 
// B dirives from A
contract B is A{
int public xx = f3(); // can call an internal function
// int public yy = f1(); // ERROR => f1() is private and cannot be called from derived contracts
}
 
 
contract C{
A public contract_a = new A(); // C deploys A
int public xx = contract_a.f4(); // OK => f4() is external
// int public y = contract_a.f1(); // ERROR => f1() is private
// int public yy = contract_a.f3(); // ERROR => f3() is internal
}