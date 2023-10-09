# Open API로 get public wifi

</br>

## 필요한 파일
`main/java/com.example.publicWifi` 디렉토리 안에  
**secret** 패키지 생성


## secret 패키지 안에 **Secret class** 생성
> Secret.java
```java
package com.example.publicwifi.secret;

public class Secret {
    public static String WIFI_KEY = "공공사이트에서 받아온 인증키";
}
```
