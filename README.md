<a id="readme-top"></a>


<!-- 프로젝트 로고 -->
<br />
<div align="center">
  <img src="src/main/resources/static/images/logo.png" alt="Logo" width="160" height="70">
  <h3 align="center">지역 기반 의료 서비스 매칭 플랫폼</h3>
  <p align="center">
    지금 바로 닥터뷰를 시작해보세요!
    <br />
    <a href="http://ec2-3-35-52-107.ap-northeast-2.compute.amazonaws.com:8586/"><strong>웹사이트 바로가기 »</strong></a>
  </p>
</div>


<!-- 목차 -->
<details>
  <summary>목차</summary>
  <ol>
    <li>
      <a href="#1">프로젝트 정보</a>
      <ul>
        <li><a href="#1-1">프로젝트 개요</a></li>
        <li><a href="#1-2">소속 단체 및 개발 기간</a></li>
        <li><a href="#1-3">팀원 구성 및 역할</a></li>
      </ul>
    </li>
    <li><a href="#2">사용 가이드</a></li>
    <li><a href="#3">기술 스택</a></li>
    <li><a href="#4">주요 기능</a></li>
    <li>
      <a href="#5">아키텍처</a>
      <ul>
        <li><a href="#5-1">아키텍처</a></li>
        <li><a href="#5-2">프로젝트 구조</a></li>
      </ul>
    </li>
        <li>
      <a href="#6">기타</a>
      <ul>
        <li><a href="#6-1">개발 문서</a></li>
        <li><a href="#6-2">이슈 및 문제해결</a></li>
        <li><a href="#6-3">개선 사항</a></li>
        <li><a href="#6-4">프로젝트에서 배운 점</a></li>
        <li><a href="#6-5">결과 및 확장성</a></li>
      </ul>
    </li>
  </ol>
</details>

<br/>

# <span id="1">01. 프로젝트 정보</span>

## <span id="1-1">프로젝트 개요</span>

<b>닥터뷰는 지역 기반 의료 서비스 매칭 플랫폼입니다.</b>

닥터뷰는 병원 정보의 부족, 만족스러운 의료진 선택의 어려움, 긴급 상황에서 병원 찾기의 불편함, 번거로운 예약 과정 등 환자들이 겪는 문제를 해결하고자 하는 의도에서부터 출발하였습니다. 닥터뷰는 다양한 검색 방식과 조건을 통해 개인에게 적합한 병원을 찾고 예약할 수 있는 서비스를 제공합니다. 병원 방문 전후에는 채팅 기능을 통해 병원과 소통할 수 있으며, 게시판을 통해 건강 정보를 공유하는 커뮤니티를 형성하여 기존의 의료 시스템에 새로운 알고리즘을 도입합니다.

<b>닥터뷰는 웹과 모바일 앱을 모두 지원합니다.</b> <a href="https://github.com/jhrchicken/DoctorViewApp">닥터뷰 앱에 대한 내용은 여기에서 확인하세요.</a>

이 웹사이트는 다음과 같은 기능들을 제공합니다.

1. 다양한 검색 방식으로 검색 조건에 일치하는 병원과 의료진의 정보을 찾아 예약하고 리뷰를 남길 수 있습니다.
2. 환자들이 병원 방문 전후에 의료진과 간편하게 소통할 수 있도록 채팅 기능을 제공합니다.
3. 게시판을 통해 건강 정보를 공유하고 커뮤니티 내에서 자유롭게 상호작용할 수 있습니다.

<b>이제 </b><a href="http://ec2-3-35-52-107.ap-northeast-2.compute.amazonaws.com:8586/">여기를 클릭하여</a><b> 지역 기반 의료 시스템 매칭 플랫폼 닥터뷰를 시작해보세요!</b>

<div align="right">
 
 [(back to top)](#readme-top)
 
</div>

<br/>

## <span id="1-2">소속 단체 및 개발 기간</span>

<ul>
  <li>더조은아카데미 클라우드(AWS) 환경에서 개발하는 풀스택(프론트엔드&백엔드) 자바(JAVA)웹&앱 4기</li>
  <li>프로젝트 개발 기간: 2024.09.19 - 2024.10.23</li>
  <li>프로젝트 보완 기간: 2025.01.10 - 2025.01.30</li>
</ul>

<div align="right">
 
 [(back to top)](#readme-top)

</div>

<br/>

## <span id="1-3">팀원 구성 및 역할</span>

닥터뷰 프로젝트는 <b>백엔드 개발자 2명과 프론트엔드 개발자 1명</b>으로 구성된 팀이 개발하였습니다.

|정하림|부다영|이회리|
|:---:|:---:|:---:|
|<img src="src/main/resources/static/images/jhrchicken.jpeg" width="120" height="120">|<img src="src/main/resources/static/images/budayeong.jpeg" width="120" height="120">|<img src="src/main/resources/static/images/leehr.jpeg" width="120" height="120">|
|백엔드 및 팀장|백엔드|프론트엔드|

#### 닥터뷰 프로젝트에서 정하림([@jhrchicken](https://github.com/jhrchicken))의 주요 역할은 다음과 같습니다.

<ul>
  <li>
    <b>프로젝트 설계</b>
    <ul>
      <li>데이터베이스 설계</li>
      <li>요구사항 정의서 작성, 앱 기능 정의서 작성, 데이터베이스 정의서 작성, 개발 일정 작성, 릴리즈 노트 작성 등 일부 <b>개발 문서 작성</b></li>
    </ul>
  </li>
  <br/>
  <li>
    <b>UI 구현</b>
    <ul>
      <li>홈, 헤더, 푸터 등 모든 <b>메인 관련 페이지</b></li>
      <li>게시판 목록, 게시판 작성, 게시판 수정, 게시판 상세 등 모든 <b>게시판 관련 페이지</b></li>
      <li>이모지 상점, 나의 이모지 등 모든 <b>이모지 관련 페이지</b></li>
      <li>예약 내역, 찜한 의사, 찜한 병원 등 일부 <b>마이페이지 관련 페이지</b></li>
    </ul>
  </li>
  <br/>
  <li>
    <b>기능 개발</b>
    <ul>
      <li>병원 키워드로 검색, 병원 조건 필터링 검색, 병원 지도로 찾기, 진료시간에 따른 병원 필터링 후 지도에 표시 등 모든 <b>병원 찾기 기능</b></li>
      <li>병원 기본정보와 추가정보 표시, 병원 찜 표시 등 <b>병원 상세정보 확인 기능</b></li>
      <li>의사 키워드로 검색, 의사 기본정보와 추가정보 표시, 의사 찜 표시 등 모든 <b>의사 찾기 및 상세정보 확인 기능</b></li>
      <li>별점과 해시태그를 통한 리뷰 작성과 수정과 삭제, 리뷰 답변 작성과 수정과 삭제, 리뷰 수정 여부 표시 등 모든 <b>리뷰 기능</b></li>
      <li>React와 Firebase 연동, 채팅 목록, 채팅방, 채팅 이력과 이전 대화 조회, 채팅 날짜와 시간 표시 등 모든 <b>실시간 채팅 기능</b></li>
      <li>게시글 작성과 수정과 삭제, 댓글 작성과 수정과 삭제, 게시글 좋아요 및 신고, 게시판 활동 내역 확인 등 모든 <b>게시판 기능</b></li>
    </ul>
  </li>
</ul>

#### 다른 팀원에 대한 자세한 정보는 부다영([@budayeong](https://github.com/Budayeong))과 이회리([@leeeeeeeeeeeehr](https://github.com/leeeeeeeeeeeehr))에서 확인하세요.

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="2">02. 사용 가이드</span>

### 배포 URL

<ul>
  <li>배포 URL: http://ec2-3-35-52-107.ap-northeast-2.compute.amazonaws.com:8586/</li>
  <li>관리자 URL: http://ec2-3-35-52-107.ap-northeast-2.compute.amazonaws.com:8586/admin/index.do</li>
</ul>

### Test ID/PW

<ul>
  <li>일반사용자: user1 / 1234</li>
  <li>병원사용자: hospital1 / 1234</li>
  <li>관리자: admin / 1234</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="3">03. 기술 스택</span>

|분류|기술 스택|
|:---:|---|
|**프론트엔드**|<img src="https://img.shields.io/badge/HTML5-%23E34F26?style=for-the-badge"> <img src="https://img.shields.io/badge/CSS3-%231572B6?style=for-the-badge&logo=css3"> <img src="https://img.shields.io/badge/JavaScript%20ES6-%23F7DF1E?style=for-the-badge&logo=javascript&logoColor=%23000"> <img src="https://img.shields.io/badge/React%2018.3.1-%2361DAFB?style=for-the-badge&logo=react&logoColor=%23000">|
|**백엔드**|<img src="https://img.shields.io/badge/Java%2021-%23000000?style=for-the-badge&logo=openjdk"> <img src="https://img.shields.io/badge/Spring%20Boot%203.0.3-%236DB33F?style=for-the-badge&logo=spring%20boot&logoColor=%23fff"> <img src="https://img.shields.io/badge/MyBatis%203.0.3-%234479A1?style=for-the-badge">|
|**데이터베이스**|<img src="https://img.shields.io/badge/Oracle%2021c-%23F80000?style=for-the-badge&logo=oracle"> <img src="https://img.shields.io/badge/Firebase%20realtime%2010.13.2-%23EB844E?style=for-the-badge&logo=firebase">|
|**서버**|<img src="https://img.shields.io/badge/Linux-%23FCC624?style=for-the-badge&logo=linux&logoColor=%23000000"> <img src="https://img.shields.io/badge/Apache%20Tomcat%2010.1.26-%23F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=%23000"> <img src="https://img.shields.io/badge/AWS%20ec2-%23232F3E?style=for-the-badge&logo=amazonwebservices">|
|**개발 환경 및 도구**|<img src="https://img.shields.io/badge/visual%20studio%20code-%230082FC?style=for-the-badge"> <img src="https://img.shields.io/badge/sts%204-%236DB33F?style=for-the-badge&logo=spring&logoColor=%23fff"> <img src="https://img.shields.io/badge/sqldeveloper-%23575757?style=for-the-badge"> <img src="https://img.shields.io/badge/termius-%23000000?style=for-the-badge&logo=termius">|
|**라이브러리 및 API**|<img src="https://img.shields.io/badge/KakaoMap-%23FFCD00?style=for-the-badge&logo=kakao&logoColor=%23000"> <img src="https://img.shields.io/badge/Bootstrap%205.3.3-%237952B3?style=for-the-badge&logo=bootstrap&logoColor=%23fff"> <img src="https://img.shields.io/badge/jQuery%20%26%20Ajax-%230769AD?style=for-the-badge&logo=jquery">|
|**협업**|<img src="https://img.shields.io/badge/github-%23181717?style=for-the-badge&logo=github"> <img src="https://img.shields.io/badge/figma-%23F24E1E?style=for-the-badge&logo=figma&logoColor=%23fff"> <img src="https://img.shields.io/badge/staruml-%23FFE200?style=for-the-badge"> <img src="https://img.shields.io/badge/notion-%23000000?style=for-the-badge&logo=notion"> <img src="https://img.shields.io/badge/google%20drive-%234285F4?style=for-the-badge&logo=googledrive&logoColor=%23fff">|

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="4">04. 주요 기능</span>

### 로그인 및 회원가입
<ul>
  <li>SMTP로 이메일 전송을 통한 비밀번호 찾기 기능</li>
  <li>AJAX 비동기 방식으로 사용자 닉네임 랜덤 추천</li>
  <li>회원가입 시 AJAX를 이용하여 입력창 하단에 실시간으로 폼값 검증 결과를 표시</li>
</ul>

<br/>

### 병원 검색 및 상세정보 확인

#### 병원 찾기
<ul>
  <li>지역, 병원명, 전공, 해시태그로 키워드 검색</li>
  <li>AJAX를 이용한 비동기식 조건 필터링 검색</li>
</ul>

#### 의사 찾기
<ul>
  <li>진료 과목, 의사명으로 키워드 검색</li>
</ul>

#### 지도로 찾기
<ul>
  <li>KakaoMap으로 병원 위치를 지도에 표시</li>
  <li>야간진료, 주말진료, 진료중 병원 필터링 후 지도에 표시</li>
  <li>지도 확대/축소 및 교통정보 확인</li>
</ul>

#### 병원 상세정보 확인
<ul>
  <li>진료 시간, 진료 과목, 주소, 소속된 의료진 등 병원 기본 정보 표시</li>
  <li>교통편, 주차 가능 여부, 해시태그 등 병원 추가 정보 표시</li>
  <li>병원 찜 기능</li>
  <li>별점과 해시태그를 추가하여 리뷰 작성, 수정, 삭제</li>
  <li>일반 사용자가 작성한 리뷰에 병원 사용자의 답변 작성, 수정, 삭제</li>
  <li>수정된 리뷰와 답변에 수정 여부 표시</li>
</ul>

#### 의사 상세정보 확인
<ul>
  <li>진료 시간, 진료 과목, 소속 병원 등 병원 기본 정보 제공</li>
  <li>의사 찜 기능</li>
  <li>별점과 해시태그를 추가하여 리뷰 작성, 수정, 삭제</li>
  <li>일반 사용자가 작성한 리뷰에 병원 사용자의 답변 작성, 수정, 삭제</li>
  <li>수정된 리뷰와 답변에 수정 여부 표시</li>
</ul>

<br/>

### 예약

#### 일반 사용자의 예약 기능
<ul>
  <li>일반 사용자가 날짜와 시간을 선택하여 병원 진료 예약</li>
  <li>병원 진료시간 데이터를 JSON으로 변환하여 예약 가능 시간을 JS로 동적으로 표시</li>
  <li>예약 내역에서 완료된 예약, 진행 중인 예약, 취소된 예약 확인 가능</li>
  <li>예약 내역에서 예약 취소, 예약 내역 숨기기, 예약 메모 작성 가능</li>
  <li>예약 시 기본적으로 일반 사용자의 정보가 조회되고 대리 예약의 경우 새롭게 정보 입력 가능</li>
</ul>

#### 병원 사용자의 예약 기능
<ul>
  <li>예약 목록을 확인하고, 예약 요일과 시간을 설정하여 손쉽게 예약을 관리</li>
  <li>JSON과 JS로 화면의 깜빡임 없이 진료가 불가능한 특정 시간 예약 닫기 기능</li>
  <li>예약 취소 상황 발생 시 취소 요청을 보내면 관리자가 확인한 후 승인/반려</li>
</ul>

<br/>

### 채팅

<ul>
  <li>React와 Firebase를 이용한 일반 사용자와 병원 사용자 간의 실시간 채팅 기능</li>
  <li>대화 내용을 Firebase Realtime Database에 저장하여 채팅 목록과 이전 대화 조회</li>
  <li>날짜와 시간을 적절히 표시하여 사용자 편의 제공</li>
</ul>

<br/>

### 게시판

<ul>
  <li>게시글 작성, 수정, 삭제</li>
  <li>새로고침 없이 AJAX로 댓글 작성, 수정, 삭제</li>
  <li>AJAX를 이용한 비동기 방식으로 게시글 좋아요 및 신고 기능</li>
  <li>내가 작성한 글, 좋아요한 글 등 게시판 활동 내역 확인</li>
  <li>비방, 욕설 등이 포함된 부적절한 게시글은 관리자에 의해 삭제</li>
</ul>

<br/>

### 이모지

<ul>
  <li>출석체크를 통해 얻은 포인트를 시용해 이모지 구매</li>
  <li>보유 이모지 목록 확인 후 이모지 변경 및 해제 가능</li>
</ul>

<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="5">05. 아키텍처</span>

## <span id="5-1">아키텍쳐</span>

<img width="740" height="600" alt="architecture-gray" src="https://github.com/user-attachments/assets/5432c383-764e-47a8-875d-a596f93423c4" />

<div align="right">
  
[(back to top)](#readme-top)

</div>

## <span id="5-2">프로젝트 구조</span>

<b>닥터뷰 프로젝트는 도메인형 구조를 도입하여 비즈니스 로직과 도메인 모델 중심으로 개발되었습니다.</b>

도메인형 구조를 도입한 이유는 다음과 같습니다.

1. 도메인의 역할을 명확히 구분하여 시스템 이해도 향상
2. 도메인별 독립 작업으로 개발 속도와 협업 효율성 증대

자세한 프로젝트 구조는 아래에서 확인할 수 있습니다.

```properties
DoctorViewWeb
├── README.md
├── build.gradle # Gradle 빌드 스크립트
├── gradle
├── gradlew
├── gradlew.bat
├── settings.gradle # Gradle 설정 파일
└── src
    ├── test
    └── main
        ├── java
        │    ├── com
        │    │    └── edu
        │    │        └── springboot
        │    │            ├── DoctorViewProjectApplication.java
        │    │            ├── MainController.java # 메인 컨트롤러
        │    │            ├── ServletInitializer.java
        │    │            ├── WebCorsConfig.java # CORS 설정 클래스
        │    │            ├── admin    # 기능(도메인) 별 패키지
        │    │            ├── ...      # ...
        │    │            └── doctor   # 기능(도메인) 별 패키지
        │    │                ├── DoctorController.java # 컨트롤러
        │    │                ├── DoctorDTO.java # DTO 객체
        │    │                ├── DoctorPropertyConfig.java # 설정 클래스
        │    │                └── IDoctorService.java # 서비스 인터페이스
        │    └── utils # 유틸리티 클래스 패키지
        │        ├── CookieManager.java
        │        ├── FileUtil.java
        │        ├── JSFunction.java
        │        └── PagingUtil.java
        ├── resources
        │    ├── application.properties      # 기능(도메인) 별 설정 파일
        │    ├── ...                         # ...
        │    ├── hospital_config.properties  # 기능(도메인) 별 설정 파일
        │    ├── mappers # MyBatis 매퍼 XML 파일 디렉터리
        │    │    ├── BoardDAO.xml
        │    │    ├── ...
        │    │    └── ReserveDAO.xml
        │    ├── static # 정적 리소스 파일
        │    │    ├── assets
        │    │    ├── chat
        │    │    ├── css
        │    │    ├── fonts
        │    │    ├── images
        │    │    ├── js
        │    │    └── uploads
        │    └── templates
        └── webapp
            └── WEB-INF
                └── views # JSP 뷰 디렉터리
                    ├── admin    # 기능(도메인) 별 디렉터리
                    ├── ...      # ...
                    └── reserve  # 기능(도메인) 별 디렉터리
```

<div align="right">

[(back to top)](#readme-top)

</div>

<br/><br/>

# <span id="6">06. 기타</span>

## <span id="6-1">개발 문서</span>

#### 정의서

<ul>
  <li><a href="https://docs.google.com/spreadsheets/d/1-RER7R7QFNXRE4CgOUqKGith9Wt0Z91SCN1672EbLW0/edit?usp=drive_link">요구사항 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/1tJxRiuc-6t-qtbx3ukJuy4CSat0CVpaDYTXexVlGvks/edit?usp=drive_link">웹 기능 정의서</a></li>
  <li><a href="https://docs.google.com/spreadsheets/d/1hxAeG9cIlK2gOKKzilhP28s8gkanK2O-k3BdpuAEieQ/edit?usp=drive_link">데이터베이스 정의서</a></li>
</ul>

#### 설계 및 다이어그램

<ul>
  <li><a href="https://drive.google.com/file/d/1iUhCqF1Ph4BOKmYuSbZTkatNYMCXlg0_/view?usp=drive_link">ERD</a></li>
  <li><a href="https://drive.google.com/file/d/1w8A9AkabNHy3rTe__uZzndIpN9P8St-U/view?usp=drive_link">Usecase</a></li>
</ul>

#### 기타

<ul>
  <li><a href="https://docs.google.com/spreadsheets/d/1zC_YDl9BHkNTQ4XoS8nbUvrYFBoN5bXuEljF49YOYT0/edit?usp=drive_link">개발 일정</a></li>
  <li><a href="http://ec2-3-35-52-107.ap-northeast-2.compute.amazonaws.com:8586/release.do">릴리즈 노트</a></li>
</ul>

<div align="right">
  
  [(back to top)](#readme-top)

</div>

<br/>

## <span id="6-2">이슈 및 문제해결</span>

#### 1. 병원 목록에서 페이징과 필터링 방식의 충돌 문제 발생 및 해결

병원 목록 구현 과정에서 기존의 요청 기반의 페이징 방식과 AJAX 기반의 필터링 방식 간의 충돌이 발생했습니다. 이로 인해 필터링된 목록에서 페이지 이동 시 전체 병원을 기준으로 페이징이 적용되는 문제가 발생했습니다. 이 경우 페이징 기능을 제거하면 필터링 조건을 해제할 때 약 25,000건의 병원 데이터를 한 번에 조회해야 하여 성능이 크게 저하되었습니다.

이를 해결하기 위해 필터링 기능은 AJAX 방식으로 유지하고 페이징 방식을 기존 요청 기반에서 AJAX 기반으로 변경하였습니다. 초기에는 10개의 항목만 표시하고 더보기 버튼을 통해 추가 데이터를 불러오는 방식으로 개선하여 데이터 로드량을 줄이고 문제를 해결하였습니다.

<br/>

#### 2. 예약 기능에서 사용자 선택에 따른 백엔드 데이터 출력 문제 발생 및 해결

예약 기능 구현 과정에서 JS로 제작한 달력에서 진료가 불가능한 시간은 선택할 수 없도록 표시해야 했습니다. 이를 위해 사용자가 선택한 값과 DB에 저장된 병원의 예약 불가 날짜를 비교하여 동일한 경우 선택을 제한해야 했습니다.

초기에는 AJAX를 사용해 사용자가 선택한 날짜 데이터를 비동기로 백엔드에 전송하고 결과를 반환받는 방식으로 구현하였습니다. 그러나 이 방식은 값 전송을 위한 버튼 클릭 등의 이벤트를 필요로 해서 매번 사용자가 예약 시간을 선택한 후 별도의 버튼을 누르는 불필요한 행동을 유발했습니다.

이를 해결하기 위해 예약 요청이 들어왔을 때 모든 예약 가능/불가능 데이터를 한 번에 프론트엔드로 전송하고 이를 바탕으로 달력을 구성하는 방식을 선택했습니다. 사용자가 선택한 데이터를 백엔드로 전송해 값을 반환받는 것이 아닌 프론트엔드에서 JS를 통해 사용자 선택에 따라 동적으로 데이터를 표시하였습니다. 결과적으로 사용자에게 불필요한 행위 없이 더 나은 경험을 제공하도록 개선하였습니다.

<div align="right">
  
  [(back to top)](#readme-top)

</div>

<br/>

## <span id="6-3">개선 사항</span>


<ul>
  <li>
    <b>병원 회원 가입 데이터 삽입 롤백 처리</b>
    <ul>
      <li>현재 병원 회원 가입 시 세 개의 테이블에 데이터 삽입 과정에서 오류가 발생하면 JavaScript로 데이터 전송만 제한됨</li>
      <li>오류 발생 시 전체 가입 과정이 롤백되도록 DB 트랜잭션을 활용하여 데이터 삽입을 하나의 작업 단위로 처리하도록 개선 필요</li>
    </ul>
  </li>
</ul>
<ul>
  <li>
    <b>예약 가능한 수 설정 개선</b>
    <ul>
      <li>현재 특정 시간에 예약이 한 건 들어오면 자동으로 마감 상태가 됨</li>
      <li>병원으로부터 각 타임 당 예약 가능한 수를 입력받아 예약 가능한 건수를 설정할 수 있도록 개선 필요</li>
    </ul>
  </li>
</ul>

<div align="right">

[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-4">프로젝트에서 배운 점</span>

#### 1. 여정 자체가 보상이다

프로젝트를 시작할 때는 제 부족함과 실력에 대한 막연한 두려움이 있었습니다. 하지만 프로젝트를 진행하면서, 배우려는 자세와 의지만 있다면 결과에 상관없이 저를 더 단단하게 만들어주는 실력과 경험을 얻을 수 있다는 것을 깨달았습니다. 앞으로 백엔드 개발자로 나아가면서 제가 모르는 기술들은 끝없이 쏟아져 나올 것입니다. 그 사실이 두렵고 때로는 자신감을 잃기도 하겠지만 그럼에도 불구하고 차근차근 공부하다 보면 꾸준히 성장하게 될 것입니다. 결국 이 여정 자체가 저에게 가장 큰 보상이 될 것이라고 믿습니다.

<br/>

#### 2. 팀의 목표달성을 위한 길잡이, 문서화

팀 프로젝트를 진행하며 팀원 간의 의사소통이 개발 결과에 큰 영향을 미친다는 점을 깨달았습니다. 
같이 프로젝트를 논의하더라도 각 팀원이 상상하는 이미지와 방향은 서로 다를 수 있습니다.
이를 방지하기 위해 요구사항 정의서와 같은 문서화 작업을 진행한 후 개발을 시작했습니다.
그러나 시간 부족으로 인해 웹/앱 디자인에 대한 문서화를 완벽히 마치지 못한 채 개발이 시작되었고, 팀원들 간의 이해 차이가 생겨 수정 과정을 반복하는 경험을 하게 되었습니다.
이 경험을 통해 팀원 모두가 동일한 이해를 공유하는 것이 프로젝트의 진행과정에서 얼마나 중요한지를 깨달았습니다.
효율적이고 정확한 개발을 위해 문서화를 통한 명확한 의사소통의 중요성을 다시 한번 배우게 되었고,
앞으로는 이 점을 적극적으로 활용해 팀의 협업을 강화하고 프로젝트의 완성도를 높일 수 있도록 노력하고자 합니다.



<div align="right">
  
[(back to top)](#readme-top)

</div>

<br/>

## <span id="6-5">결과 및 확장성</span>

<b>닥터뷰 프로젝트는 기업초청 발표에서 다음과 같은 총괄 평가를 받았습니다.</b>

|심사항목|심사 세부내용|평가점수|
|:---:|:---:|--:|
|협동심|팀원 간의 협동|17 / 20|
|창의성|창의성과 기획력|16.5 / 20|
|실용성|명확한 목표 및 비전과 실용성|17.5 / 20|
|개발능력|개발 프로그래밍 능력|17.5 / 20|
|발표|발표력|9 / 10|
|가산점|기타 추가 가산점|5.5 / 10|
|-|-|82|

<ol>
  <li>짧은 시간 내에 굉장히 안정적으로 많은 기능을 구현하였음</li>
  <li>최근 의료 서비스 이슈에 따라 서비스를 제공하는 기획 의도가 좋았음</li>
  <li>실제 서비스가 가능한 수준으로 보이며, 런칭 후 사용자 피드백을 받아 개선하는 단계로 나아가기를 기대함</li>
</ol>

이러한 평가를 통해 닥터뷰 프로젝트는 안정적인 기능과 사용자 맞춤형 서비스를 제공하고 사용자 피드백을 반영해 개선할 가능성을 갖추게 되었습니다.

<b>이를 바탕으로 닥터뷰 프로젝트는 다음과 같이 확장할 수 있습니다.</b>

<ol>
  <li>의료 사각지대 지역의 의료 서비스 데이터를 집중적으로 분석하여 지역별 의료 서비스의 격차를 줄이고 질 높은 서비스를 제공</li>
  <li>커뮤니티 기능을 강화하여 의료 목적을 넘어 소모임 혹은 정보 공유 커뮤니티로 확장함으로써 사용자들이 웹에 오랜 시간 머무를 수 있도록 유도</li>
</ol>

닥터뷰 프로젝트는 지속적으로 사용자 피드백을 반영하여 서비스의 안정성과 편의성을 강화할 계획입니다. 이를 바탕으로 향후 더 많은 지역과 다양한 의료 분야로 서비스를 확장하여 많은 사용자에게 유용한 서비스를 제공할 것입니다.

<div align="right">
  
[(back to top)](#readme-top)

</div>


