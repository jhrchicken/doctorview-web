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
})



/**
 * 병원 리뷰를 수정하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} api_ref - 병원 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 * @param {Integer} score - 별점
 * @param {Integer} content - 리뷰 내용
 * @param {Integer} cost - 비용
 * @param {Integer} treat - 치료 내용
 * @param {Integer} doctor - 담당의
 */
function openHreviewEditModal(api_ref, review_idx, score, content, cost, treat, doctor) {
    document.getElementById("hreview_edit_api_ref").value = api_ref;
    document.getElementById("hreview_edit_score").value = score;
    document.getElementById("hreview_edit_content").value = content;
    document.getElementById("hreview_edit_cost").value = cost;
    document.getElementById("hreview_edit_treat").value = treat;
    document.getElementById("hreview_edit_doctor").value = doctor;
    document.getElementById("hreview_edit_hreview_idx").value = review_idx;
    // 별점 이미지 업데이트
    document.querySelectorAll('.star').forEach(function(star) {
        if (star.getAttribute('data-value') <= score) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}


/**
 * 병원 리뷰를 삭제하기 위한 함수
 * 
 * @param {Integer} - 병원 일련번호
 * @param {Integer} - 리뷰 일련번호
 */
function deleteHreview(api_ref, review_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteHreviewForm;
		// hidden 필드에 값을 동적으로 설정
        form.api_ref.value = api_ref;
        form.hreview_idx.value = review_idx;
		form.method = "post";
		form.action = "/mypage/deleteHreview.do";
		form.submit();
	}
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
 * 병원 리뷰 수정 시 해시태그를 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('hreview_edit_hashtags');
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
            } else {
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

// 병원 리뷰 수정 별점
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('hreview_edit_score');
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



/**
 * 의사 리뷰를 수정하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} doc_ref - 의사 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 * @param {Integer} score - 별점
 * @param {String} content - 리뷰 내용
 */
function openDreviewEditModal(doc_ref, review_idx, score, content) {
   document.getElementById("dreview_edit_doc_ref").value = doc_ref;
    document.getElementById("dreview_edit_score").value = score;
    document.getElementById("dreview_edit_content").value = content;
    document.getElementById("dreview_edit_dreview_idx").value = review_idx;
    // 별점 이미지 업데이트
    document.querySelectorAll('.star').forEach(function(star) {
        if (star.getAttribute('data-value') <= score) {
            star.src = '/images/star.svg';
        } else {
            star.src = '/images/star_empty.svg';
        }
    });
}

// 의사 리뷰 삭제
function deleteDreview(doc_ref, review_idx) {
   if (confirm("댓글을 삭제하시겠습니까?")) {
      var form = document.deleteDreviewForm;
      // hidden 필드에 값을 동적으로 설정
      form.doc_ref.value = doc_ref;
      form.dreview_idx.value = review_idx;
      form.method = "post";
      form.action = "/mypage/deleteDreview.do";
      form.submit();
   }
}


/**
 * 의사 리뷰 수정 시 해시태그를 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('dreview_edit_hashtags');
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
 * 의사 리뷰 수정 시 별점을 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('dreview_edit_score');
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