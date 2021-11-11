# 엔진엑스가 바라보는 스프링 부트를 최신 버전으로 변경

#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

function switch_proxy() {
    IDLE_PORT=$(find_idle_port)

    echo "> 전환할 Port: $IDLE_PORT"
    echo "> Port 전환"
    # 하나의 문장을 만들어 파이프라인(|) 으로 넘겨주기 위해 echo를 사용합니다. echo "set \$service_url http://127.0.0.1:${IDLE_PORT};"
    # ㄴ 엔진엑스가 변경할 프록시 주소를 생성, 쌍따옴표를 사용해야 하며, 사용하지 않드면 $service_url을 그대로 인식하지 못하고 변수를 찾게 됨.
    # sudo tee /etc/nginx/conf.d/service-url.inc => 앞에서 넘겨준 문장을 service-url에 덮어씁니다.
    echo "set \$service_url http://127.0.0.1:${IDLE_PORT};" | sudo tee /etc/nginx/conf.d/service-url.inc

    echo "> 엔진엑스 Reload"
    sudo service nginx reload
}
