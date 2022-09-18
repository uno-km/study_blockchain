// SPDX-License-Identifier: GPL-30
pragma solidity >= 0.7.0 < 0.9.0; 
/*
    Enum 에 대해 학습
    Enum : 0~255까지의 상수셋트이다.
    각 번호 마다 특정한 이름을 넣어줄수 있다.
    enum 이름{

        } 
    이렇게 사용한다.   
    enum의 명을 쓰고 
    그안에 특정한 이름들과 값들을 넣어준다.
    여기에 이름을 넣어주는것은 특정한 상태조건을 나타내 주기 위해서이다.
    이 특정한 상태조건을 require와 같이 사용해서 특정한 함수만을 실행 시키게 할수 있다.
    일단 예제를 통해 학습해보자.

*/
contract EnumEx{

    enum CarStatus{
        TURN_OFF
        , TURN_ON
        ,  DRIVING
        , STOP
        , NEUTRAL
    }
    /*
        순서대로 총 4가지의 이넘이 있는데
        순서대로 번호가 매겨져서 TURN_OFF는 0번, TURN_ON은 1번, DRIVING은 2번, STOP은 3번 이렇게 된다.
        그리고 자동차의 상태에 따라서 특정한 함수들을 작동시켜주려고한다. require를 통해서.
    */
    CarStatus public carStatus;
    /*
        이제 이넘을 만들었으니 변수로 선언해준다.
        현재 상태조건이 어떤지 알아해서 이다.
        그래서 변수를 만들어주고 생성자를 통해서 carStatus에 CarStatus.TURN_OFF라고 만들어준다.
        즉 이 스마트컨트랙이 배포될때 자동차의 상태는 TURN_OFF가 되는것이다.
        그래서 맨처음 자동차의 상태는 TURN _OFF이다.
        그리고 이넘을 써줄때는 반드시 이넘의 이름 + . + 그리고 그 이넘의 이름을 써주면된다.
    */
    constructor(){
        carStatus =  CarStatus.TURN_OFF;
    }
    event carCurrentStatus(CarStatus inCarsatus, uint256 carStatusInt);

    function turnOnCar() public{
        require(carStatus == CarStatus.TURN_OFF, "To Turn on, Your car must be Turn off");
        carStatus = CarStatus.TURN_ON;
        emit carCurrentStatus(carStatus, uint256(carStatus));
    }
    function drivingCar() public{
        require(carStatus == CarStatus.TURN_ON, "To drive a car, Your car must be Turn on");
        carStatus = CarStatus.DRIVING;
        emit carCurrentStatus(carStatus, uint256(carStatus));
    }
    function stopCar() public{
        require(carStatus == CarStatus.DRIVING, "To stop a car, Your car must be Turn on");
        carStatus = CarStatus.STOP;
        emit carCurrentStatus(carStatus, uint256(carStatus));
    }
    function turnOffCar() public{
        require(carStatus == CarStatus.TURN_ON, "To Turn off a car, Your car must be Turn on");
        carStatus = CarStatus.TURN_OFF;
        emit carCurrentStatus(carStatus, uint256(carStatus));
    }
    /*
        그리고 꼭 carStatus + ' . ' enum  이렇게 붙여서 쓰지않고
        carStatus(0) : carStatus.TURN_OFF 와 같은 값
        이렇게 사용해도된다. 아래를 보자
    */
    function turnOnCarCarUint() public{
        require(carStatus == CarStatus(0), "To Turn on, Your car must be Turn off");
        carStatus = CarStatus(1);
        emit carCurrentStatus(carStatus, uint256(carStatus));
    }
}

