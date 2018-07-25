pragma solidity ^0.4.11;

contract XO {

    address moderator;
    address playerX;
    address playerO;

    bytes8[3][3] board;

     constructor(address _playerX,address _playerO) public {
        moderator = msg.sender;
        playerX = _playerX;
        playerO = _playerO;
    }

    function () payable {
        revert();
    }

    function DoWeHaveAWinner(bytes8 symbol) constant private returns (bool) {
        if(board[0][0] == symbol && board[0][1] == symbol && board[0][2] == symbol) return true;

        if(board[1][0] == symbol && board[1][1] == symbol && board[1][2] == symbol) return true;

        if(board[2][0] == symbol && board[2][1] == symbol && board[2][2] == symbol) return true;

        if(board[0][0] == symbol && board[1][1] == symbol && board[2][2] == symbol) return true;

        if(board[0][2] == symbol && board[1][1] == symbol && board[2][0] == symbol) return true;


        return false;
    }

    modifier validChoice(uint8 x,uint8 y){
        require (x<=2 && y <= 2);
        _;
    }

    function play (uint8 x,uint8 y) validChoice(x,y) public returns (bool weHaveWinner, address winner) {
        bytes8 symbol;
        if(msg.sender == playerX){
            symbol = "X";
            board[x][y] = symbol;
        }
        else{
            symbol = "O";
            board[x][y] = symbol;
        }

        weHaveWinner = DoWeHaveAWinner(symbol);
        if(weHaveWinner){
                return (true,msg.sender);
        }
    }

}