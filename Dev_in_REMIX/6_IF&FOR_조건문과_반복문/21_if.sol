// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
/*
    조건문 if문 에 대해서 학습 :
    다른 언어에서도 if문은 매우 친숙하게 사용되어진다. 
    이 if를 간단하게 정의하자면
    if안에 특정한 조건을 만들어주고 , 그 특정한 조건에 대한 값(논리)값으로 조건절 내에 있는 단계를 실행 해준다.
    그래서 if를 사용할때 2가지의 특이 나온다.
    1. if/else 문을 사용할때 , 2. if/else if/else 이렇게 사용된다.
    우린 if/else 문을 공부해보자.
    if /else 를 쓰기위해서
    if를 정의해주고 괄호안에 특정한 조건을 써주고, 그 조건에 부합하면 특정 부분이 돌수 있도록
    지정한다.
    만약 if의 특정한 조건이 발동하고 조건을 미충족 시 실행되는 논리에 대한 부분은 else에 써주면된다.
    그래서 우리는 2지 선다로 보고 if 또는 else 이렇게 50/50 식으로 처리할 수 있다.
    그러나 우리가 5지선다, 6지선다 등등 처리되어야할 논리연산들이 많을 경우에는
    if/else if/else 문을 사용해서 복잡한 논리도 if문으로 풀어서 사용할 수 있다.
    특정한 조건들을 더 늘릴 수 있다. 
*/
contract IfElseEx{
    string private outCome = "";
    function isIf5(uint256 num) public returns(string memory){
        if(num ==5){
            outCome = "Yes, It is 5";
            return outCome;
        }
        else{
            outCome = "No, It is not 5";
            return outCome;
        }
        /**
            num을 입력받아서 if문을 통해서 5인지 아닌지 판별하는 로직이다
            5일때는 if문 내의 값을, 아닐경우에는 else 에 도달해서 outCome값을 다루게된다.
            그러나 이때 else{}를 지우고 outCome ="{#값}" return outCome; 을 해도 똑같이된다.
            이 이유는 if문 조건이 맞지 않으면 else문을 돌리는데 현재 else문이 없으니 if문을 빠져나온
            그 이후의 코드를 실행해서 리턴되는것이다.
            그리고 만약 5를 입력한다면, 바로 리턴이 되어서 else문이나, 그 외부 코드는 돌지 않고 빠져나와서 
            값이 동일하게 yes값을 얻는 것이디.

         */
    }
    function WhichNumber(uint256 num) public returns(string memory){
        if(num==5){
            outCome ="It is 5";    
        } else if(num==4){
            outCome ="It is 4";
        } else if(num==3){
            outCome ="It is 3";
        }else if(num==2){
            outCome ="It is 2";
        }else if(num==1){
            outCome ="It is 1";
        }else{
            outCome ="is It not 1,2,3,4,5 right?";
        }
        return outCome;
    }
}



    
