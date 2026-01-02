/**
 * 전역 변수 선언
 * offset: 현재 데이터 시작 위치
 * limit: 한 번에 가져올 데이터 개수
 * count: 전체 데이터 개수
 */
var offset = 0;
var limit = 10;
var count = 0;
var searchField = '';
var searchWord = '';


/**
 * 더보기 버튼 클릭 시 데이터 로드 함수를 호출하는 함수
 */
$(document).ready(function() {
    // 홈 화면에서 의사를 검색한 경우
	var urlParams = new URLSearchParams(window.location.search);
	searchField = urlParams.get('searchField');
	searchWord = urlParams.get('searchWord');
	
	// 초기 페이지 로딩 시 doctorListContent를 가져오기 위한 AJAX 호출
    loadDoctorListContent();

    // 더보기 버튼 클릭 시 추가 데이터 로드
    $('.more_btn').click(function(event) {
        event.preventDefault();
        loadDoctorListContent();
    });

    // 검색 폼 제출 시 데이터 로드
    $('.search_form').submit(function(event) {
        event.preventDefault();
		
        // 검색 조건과 검색어
        searchField = $('select[name="searchField"]').val();
        searchWord = $('input[name="searchWord"]').val();
		
        // 초기화 후 데이터 로드
        offset = 0;
        $('#doctorListContent').empty();
        loadDoctorListContent();
    });
});


/**
 * 데이터를 로드하는 함수
 * @param {string} searchField - 검색 조건
 * @param {string} searchWord - 검색어
 */
function loadDoctorListContent() {
    $.ajax({
        url: './doctor/doctorListContent.do',
        type: 'GET',
        data: {
            offset: offset,
            limit: limit,
            searchField: searchField,
            searchWord: searchWord
        },
        success: function(response) {
			// 응답 데이터를 리스트에 추가
            $('#doctorListContent').append(response);

            // 서버에서 총 데이터의 개수를 가져와서 설정
            count = parseInt($('#count').val());
            offset += limit;

            // 불러올 데이터가 없으면 더보기 버튼 숨김
            if (offset >= count) {
                $('.more_btn').hide();
            } else {
                $('.more_btn').show();
            }
        },
        error: function() {
            $('.more_btn').hide();
        }
    });
}
