/**
 * 시/구/군을 동적으로 셀렉트하는 함수
 */
$(function() {
	$('#sido').change(function() {
		$.ajax({
			url : "../hospital/getGugun.do",
			type : "get",
			contentType : "text/html;charset:utf-8;",
			// 파라미터: 선택한 시도를 전달
			data : {
				sido : $('#sido option:selected').val()
			},
			dataType : "json",
			success : function(d) {
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "- 시/군/구 선택 -";
				optionStr += "</option>";
				$.each(d.result, function(index, data) {
					optionStr += '<option value="' + data.gugun + '">';
					optionStr += data.gugun;
					optionStr += '</option>';
				});
				// 구군 <select> 태그에 삽입
				$('#gugun').html(optionStr);
			},
			error : function(e) {
				alert("오류발생:" + e.status + ":" + e.statusText); 
			}
		});
	});
});


/**
 * 읍/면/동을 동적으로 셀렉트하는 함수
 */
$(function() {
	$('#gugun').change(function() {
		$.ajax({
			url : "../hospital/getDong.do",
			type : "get",
			contentType : "text/html;charset:utf-8;",
			// 파라미터: 선택한 시도를 전달
			data : {
				gugun : $('#gugun option:selected').val()
			},
			dataType : "json",
			success : function(d) {
				var optionStr = "";
				optionStr += "<option value=''>";
				optionStr += "- 읍/면/동 선택 -";
				optionStr += "</option>";
				$.each(d.result, function(index, data) {
					optionStr += '<option value="' + data.dong + '">';
					optionStr += data.dong;
					optionStr += '</option>';
				});
				// 구군 <select> 태그에 삽입
				$('#dong').html(optionStr);
			},
			error : function(e) {
				alert("오류발생:" + e.status + ":" + e.statusText); 
			}
		});
	});
});



/**
 * 전역 변수 선언
 * offset: 현재 데이터 시작 위치
 * limit: 한 번에 가져올 데이터 개수
 * totalCount: 전체 데이터 개수
 * 
 * filters: 현재 적용된 필터 조건
 */
var offset = 0;
var limit = 10;
var count = 0;
var searchSido = '';
var searchGugun = '';
var searchDong = '';
var searchField = '';
var searchWord = ''
var filters = '';

$(document).ready(function () {
	// 홈 화면에서 병원을 검색한 경우
	var urlParams = new URLSearchParams(window.location.search);
	searchField = urlParams.get('searchField');
	searchWord = urlParams.get('searchWord');
		
    // 초기 페이지 로딩 시 doctorListContent를 가져오기 위한 AJAX 호출
    loadHospListContent();
	
    // 더보기 버튼 클릭 시 추가 데이터 로드
    $('.more_btn').click(function (event) {
        event.preventDefault();
        loadHospListContent();
    });

	// 지역 선택 시 데이터 로드
	    $('#dong').change(function () {
			// 초기화
	        offset = 0;
	        filters = '';
	        $('#hospListContent').empty();
			
	        // 선택된 지역 데이터 가져오기
	        searchSido = $('#sido').val();
	        searchGugun = $('#gugun').val();
	        searchDong = $('#dong').val();

	        // 지역 조건으로 병원 리스트 로드
	        loadHospListContent();
	    });

	    // 검색 폼 제출 시 데이터 로드
	    $('.search_form').submit(function (event) {
	        event.preventDefault();
			
			// 초기화
	        offset = 0;
	        filters = '';
	        $('#hospListContent').empty();
			
			// 검색어 데이터 가져오기
	        searchField = $('select[name="searchField"]').val();
	        searchWord = $('input[name="searchWord"]').val();

	        // 유효성 검사
	        if (!searchWord.trim()) {
	            alert('검색어를 입력해주세요.');
	            return;
	        }
			
	        // 검색 조건으로 병원 리스트 로드
	        loadHospListContent();
	    });
});


/**
 * 조건 필터 버튼 클릭 시 동작하는 함수
 */
document.addEventListener('DOMContentLoaded', function() {
    const filterButton = document.querySelectorAll('.filter-button');
    let selectFilter = [];

    // 버튼 클릭 시 처리
    filterButton.forEach(button => {
        button.addEventListener('click', function() {
			
			// 초기화
			offset = 0;
			$('#hospListContent').empty();

			// 선택한 필터의 값
            const value = button.getAttribute('data-filter');
			
            // 이미 선택된 필터인 경우 색상 되돌리기
            if (selectFilter.includes(value)) {
                selectFilter = selectFilter.filter(h => h !== value);
                button.style.backgroundColor = '';
                button.style.color = '';
                button.style.border = '';
            }
			// 선택되지 않은 필터인 경우 색상 변경
            else {
                selectFilter.push(value);
                button.style.backgroundColor = '#005ad5';
                button.style.color = '#fff';
                button.style.border = 'none';
            }
			
            // 필터 값을 숨겨진 input에 저장
            // filterInput.value = selectFilter.join(',');
			filters = selectFilter.join(',');
			
			// 필터 조건으로 병원 리스트 로드
			loadHospListContent();
        });
    });
});


/**
 * 병원 리스트 데이터를 로드하는 함수
 * @param {string} searchField - 검색 조건
 * @param {string} searchWord - 검색어
 */
function loadHospListContent() {
	
    $.ajax({
        url: './hospital/hospListContent.do',
        type: 'GET',
        data: {
	        offset: offset,
	        limit: limit,
			searchSido: searchSido,
			searchGugun: searchGugun,
			searchDong: searchDong,
	        searchField: searchField,
	        searchWord: searchWord,
	        filters: filters
		},
        success: function (response) {
            // 응답 데이터를 리스트에 추가
            $('#hospListContent').append(response);

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
        error: function () {
            $('.more_btn').hide();
        }
    });
}