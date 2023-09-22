function getMyLocation(props) {
    var options = {
        // 가능한 경우, 높은 정확도의 위치(예를 들어, GPS 등) 를 읽어오려면 true로 설정
        // 그러나 이 기능은 배터리 지속 시간에 영향을 미친다.
        enableHighAccuracy: false, // 대략적인 값이라도 상관 없음: 기본값

        // 위치 정보가 충분히 캐시되었으면, 이 프로퍼티를 설정하자,
        // 위치 정보를 강제로 재확인하기 위해 사용하기도 하는 이 값의 기본 값은 0이다.
        maximumAge: 30000,     // 5분이 지나기 전까지는 수정되지 않아도 됨

        // 위치 정보를 받기 위해 얼마나 오랫동안 대기할 것인가?
        // 기본값은 Infinity이므로 getCurrentPosition()은 무한정 대기한다.
        timeout: 15000    // 15초 이상 기다리지 않는다.
    }

    function error(e) {
        // 오류 객체에는 수치 코드와 텍스트 메시지가 존재한다.
        // 코드 값은 다음과 같다.
        // 1: 사용자가 위치 정보를 공유 권한을 제공하지 않음.
        // 2: 브라우저가 위치를 가져올 수 없음.
        // 3: 타임아웃이 발생됨.
        props.innerHTML = "Geolocation 오류 "+e.code +": " + e.message;
    }

    function success(pos) {
        console.log(pos); // [디버깅] Position 객체 내용 확인

        document.getElementById("myLatitude").value = pos.coords.latitude;
        document.getElementById("myLongitude").value = pos.coords.longitude;
    }

    if(navigator.geolocation) // geolocation 을 지원한다면 위치를 요청한다.
        navigator.geolocation.getCurrentPosition(success, error, options);
    else
        props.innerHTML = "이 브라우저에서는 Geolocation이 지원되지 않습니다.";

}