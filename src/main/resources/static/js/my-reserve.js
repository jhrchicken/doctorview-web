/**
 * 예약을 취소하는 함수
 * 
 * @paran {String} app_id - 예약 일련번호
 */
function cancelReservation(app_id) {
	if (confirm("예약을 취소하시겠습니까?")) {
		var form = document.forms["cancelReservationForm_" + app_id];
		form.method = "post";
		form.action = "/reserve/cancel.do";
		form.submit();
	}
}


/**
 * 예약 내역을 숨기는 함수
 * 
 * @paran {String} app_id - 예약 일련번호
 */
function hideReservation(app_id) {
	if (confirm("숨겨진 내역은 다시 되돌릴 수 없습니다. 예약내역을 숨김처리 하시겠습니까?")) {
		var form = document.forms["hideReservationForm_" + app_id];
		form.action = "/reserve/delete.do";
		form.submit();
	}
}


/**
 * 탭 메뉴 클릭 시 탭 메뉴를 활성화하고 해당하는 내용을 표시하는 함수
 */
document.addEventListener('DOMContentLoaded', function() {
    const tabItems = document.querySelectorAll('.tab ul li');
    const contentItems = document.querySelectorAll('.tab_content');

    tabItems.forEach((item, index) => {
        item.addEventListener('click', function(event) {
            event.preventDefault();
            
            // 모든 li에서 active 클래스 제거
            tabItems.forEach(li => li.classList.remove('active'));
            // 클릭된 li에만 active 클래스 추가
            this.classList.add('active');
            
            // 모든 contentItems 숨기기
            contentItems.forEach(content => content.style.display = 'none');
            // 클릭된 탭에 해당하는 내용만 보이기
            contentItems[index].style.display = 'block';
        });
    });

    // 첫 번째 탭과 내용을 기본으로 활성화
    tabItems[0].classList.add('active');
	contentItems.forEach(content => content.style.display = 'none');
    contentItems[0].style.display = 'block';
});


/**
 * 메모 작성 모달창을 여는 함수
 * 
 * @param {String} app_id - 예약 일련번호
 * @param {String} content - 메모 내용
 */
function openMemoModal(app_id, content) {
	document.getElementById("memo_app_id").value = app_id;
	document.getElementById("memo_content").value = content;
}


/**
 * 메모 내용을 입력했는지 검증하는 함수
 * 
 * @param {Form} form - 검증할 HTML폼 객체
 * @returns {boolean} - 검증 결과  
 */
function validateMemoForm(form) {
	if (form.memo_content.value == "") {
		alert("내용을 입력하세요");
		form.memo_content.focus();
		return false;
	}
}


/**
 * 병원 리뷰를 작성하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} api_idx - 병원 일련번호
 * 
 */
function openHospReviewWriteModal(api_idx, app_id) {
	document.getElementById("hosp_review_write_api_idx").value = api_idx;
	document.getElementById("hosp_app_id").value = app_id;
	document.getElementById("hosp_review_write_score").value = 1;
	// 별점 UI 업데이트 (1점을 선택된 상태로 설정)
    document.querySelectorAll('.hosp_star').forEach(function(star) {
        if (star.getAttribute('data-value') <= 1) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}


/**
 * 리뷰의 폼값을 검증하는 함수
 * 
 * @param {Form} form - 폼 
 */
function validateReviewForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}


/**
 * 병원 리뷰 작성 시 해시태그를 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hosp-hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('hosp_review_write_hashtags');
    let selectedHashtags = [];
    // 해시태그 버튼 클릭 시 처리
    hashtagButtons.forEach(button => {
        button.addEventListener('click', function () {
            const tag = button.textContent.trim();
            // 이미 선택된 해시태그인 경우 색상 원래대로 되돌리기
            if (selectedHashtags.includes(tag)) {
                selectedHashtags = selectedHashtags.filter(h => h !== tag);
                button.style.backgroundColor = ''; // 원래 색상으로 변경
                button.style.color = ''; // 원래 텍스트 색상으로 변경
                button.style.border = '';
            }
            else {
                // 선택되지 않은 해시태그인 경우 추가
                selectedHashtags.push(tag);
                button.style.backgroundColor = '#005ad5'; // 선택된 색상으로 변경
                button.style.color = '#fff'; // 텍스트 색상 변경
                button.style.border = '1px solid #005ad5';
            }
            // 히든 필드에 선택된 해시태그 값을 저장
            updateHiddenInput();
        });
    });
    // 히든 필드에 선택된 해시태그 값을 저장
    function updateHiddenInput() {
        hashtagsHiddenInput.value = selectedHashtags.join(',');
    }
});


/**
 * 병원 리뷰 작성 시 별점을 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#hosp-star-rating .hosp_star');
    const scoreInput = document.getElementById('hosp_review_write_score');
    stars.forEach(star => {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-value');
            scoreInput.value = rating; // 히든 필드에 점수 저장
            // 선택된 별의 색상 변경
            stars.forEach(s => {
                if (s.getAttribute('data-value') <= rating) {
                    s.src = '/images/star.svg';
                } else {
                    s.src = '/images/star_empty.svg';
                }
            });
        });
    });
});


/**
 * 의사 리뷰를 작성하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} doc_idx - 의사 일련번호
 * @param {Integer} app_id - 예약 일련번호
 */
function openDoctorReviewWriteModal(doc_idx, app_id) {
	document.getElementById("doc_review_write_doc_ref").value = doc_idx;
	document.getElementById("doc_app_id").value = app_id;
	console.log(app_id);
	document.getElementById("doc_review_write_score").value = 1;
	// 별점 UI 업데이트 (1점을 선택된 상태로 설정)
	document.querySelectorAll('.doc_star').forEach(function(star) {
		if (star.getAttribute('data-value') <= 1) {
			star.src = '/images/star.svg';
		} else {
			star.src = '/images/star_empty.svg';
		}
	});
}


/**
 * 의사 리뷰 작성 시 해시태그를 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#doc-hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('doc_review_write_hashtags');
    let selectedHashtags = [];
    // 해시태그 버튼 클릭 시 처리
    hashtagButtons.forEach(button => {
        button.addEventListener('click', function () {
            const tag = button.textContent.trim();
            // 이미 선택된 해시태그인 경우 색상 원래대로 되돌리기
            if (selectedHashtags.includes(tag)) {
                selectedHashtags = selectedHashtags.filter(h => h !== tag);
                button.style.backgroundColor = ''; // 원래 색상으로 변경
                button.style.color = ''; // 원래 텍스트 색상으로 변경
            } else {
                // 선택되지 않은 해시태그인 경우 추가
                selectedHashtags.push(tag);
                button.style.backgroundColor = '#005ad5'; // 선택된 색상으로 변경
                button.style.color = '#fff'; // 텍스트 색상 변경
            }
            // 히든 필드에 선택된 해시태그 값을 저장
            updateHiddenInput();
        });
    });
    // 히든 필드에 선택된 해시태그 값을 저장
    function updateHiddenInput() {
        hashtagsHiddenInput.value = selectedHashtags.join(',');
    }
});


/**
 * 의사 리뷰 작성 시 별점을 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#doc-star-rating .doc_star');
    const scoreInput = document.getElementById('doc_review_write_score');
    stars.forEach(star => {
        star.addEventListener('click', function () {
            const rating = this.getAttribute('data-value');
            scoreInput.value = rating; // 히든 필드에 점수 저장
            // 선택된 별의 색상 변경
            stars.forEach(s => {
                if (s.getAttribute('data-value') <= rating) {
                    s.src = '/images/star.svg'; // 선택된 별의 색상
                } else {
                    s.src = '/images/star_empty.svg'; // 선택되지 않은 별의 색상
                }
            });
        });
    });
});
