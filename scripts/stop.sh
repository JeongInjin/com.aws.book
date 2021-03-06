# 기존 엔진엑스에 연결되오 있진 않지만, 실행중이던 스프링 부트 종료

#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH) # 현재 stop.sh가 속해 있는 경로를 찾습니다.
source ${ABSDIR}/profile.sh # 일종의 import 구문, 해당코드로 인하여 stop.sh 에서도 profile.sh의 여러 function을 사용할 수 있음.

IDLE_PORT=$(find_idle_port)

echo "> $IDLE_PORT 에서 구동중인 애플리케이션 pid 확인"
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  sleep 5
fi