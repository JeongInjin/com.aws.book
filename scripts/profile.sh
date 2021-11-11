# 앞선 4개 스크립트 파일에서 공용으로 사용할 "profile"과 포트 체크 로직

#!/usr/bin/env bash

# bash는 return value가 안되니 *제일 마지막줄에 echo로 해서 결과 출력*후, 클라이언트에서 값을 사용한다

# 쉬고 있는 profile 찾기: real1이 사용중이면 real2가 쉬고 있고, 반대면 real1이 쉬고 있음
function find_idle_profile()
{
    RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile) # 현재 엔진엑스가 바라보고 있는 스프링 부트가 정상적으로 수행 중인지 확인.응닫값 HttpStatus로 받음.

    if [ ${RESPONSE_CODE} -ge 400 ] # 400 보다 크면 (즉, 40x/50x 에러 모두 포함)
    then
        CURRENT_PROFILE=real2
    else
        CURRENT_PROFILE=$(curl -s http://localhost/profile)
    fi

    if [ ${CURRENT_PROFILE} == real1 ]
    then
      IDLE_PROFILE=real2 # 앤진엑스와 연결되지 않은 prpfile 입니다. 스프링 부트 프로젝트를 이 profile로 연결하기 위해 반환합니다.
    else
      IDLE_PROFILE=real1
    fi

    echo "${IDLE_PROFILE}" # bash 스크립트는 반환값이 기능이 없어 제일 마지막 줄에 echo로 결과를 출력 후, 클라이언트에서 그 값을 잡아서 find_idle_port 에서 사용 중간에 each 사용 안됨.
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port()
{
    IDLE_PROFILE=$(find_idle_profile)

    if [ ${IDLE_PROFILE} == real1 ]
    then
      echo "8081"
    else
      echo "8082"
    fi
}