/**
 * 채팅창을 여는 함수
 * 
 * @param {String} userId - 일반사용자 아이디
 * @param {String} hospId - 병원사용자 아이디
 */
function openChatRoom(userId, hospId) {
	window.open('/chat/index.html#/chat/view?room=' + userId + '-' + hospId + '&user=' + userId,
			userId + '-' + hospId, 'width=500, height=650')
}


/**
 * 리뷰를 수정하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} api_ref - 병원 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 * @param {Integer} score - 별점
 * @param {Integer} content - 리뷰 내용
 * @param {Integer} cost - 비용
 * @param {Integer} treat - 치료 내용
 * @param {Integer} doctor - 담당의
 */
function openReviewEditModal(api_ref, review_idx, score, content, cost, treat, doctor) {
    document.getElementById("review_edit_api_ref").value = api_ref;
    document.getElementById("review_edit_score").value = score;
    document.getElementById("review_edit_content").value = content;
    document.getElementById("review_edit_cost").value = cost;
    document.getElementById("review_edit_treat").value = treat;
    document.getElementById("review_edit_doctor").value = doctor;
    document.getElementById("review_edit_review_idx").value = review_idx;
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
 * 리뷰를 삭제하기 위한 함수
 * 
 * @param {Integer} - 병원 일련번호
 * @param {Integer} - 리뷰 일련번호
 */
function deleteReview(api_ref, review_idx) {
	if (confirm("댓글을 삭제하시겠습니까?")) {
		var form = document.deleteReviewForm;
		// hidden 필드에 값을 동적으로 설정
        form.api_ref.value = api_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/hospital/deleteReview.do";
		form.submit();
	}
}


/**
 * 답변을 작성하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} api_ref - 병원 일련변호
 * @param {Integer} review_idx - 리뷰 일련번호
 */
function openReplyWriteModal(api_ref, review_idx) {
	document.getElementById("reply_write_api_ref").value = api_ref;
    document.getElementById("reply_write_review_idx").value = review_idx;
}


/**
 * 답변을 수정하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} api_ref - 병원 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 * @param {String} content - 답변 내용
 */
function openReplyEditModal(api_ref, review_idx, content) {
	document.getElementById("reply_edit_api_ref").value = api_ref
    document.getElementById("reply_edit_content").value = content;
    document.getElementById("reply_edit_review_idx").value = review_idx;
}


/**
 * 답변을 삭제하는 함수
 * 
 * @param {Integer} api_ref - 병원 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 */
function deleteReply(api_ref, review_idx) {
	if (confirm("답변을 삭제하시겠습니까?")) {
		var form = document.deleteReplyForm;
		// hidden 필드에 값을 동적으로 설정
        form.api_ref.value = api_ref;
        form.review_idx.value = review_idx;
		form.method = "post";
		form.action = "/hospital/deleteReply.do";
		form.submit();
	}
}


/**
 * 리뷰와 답변의 폼값을 검증하는 함수
 */
function validateReviewForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
function validateReplyForm(form) {
	if (form.content.value == "") {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}


/**
 * 리뷰 수정 시 해시태그를 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const hashtagButtons = document.querySelectorAll('#hashtag-list button');
    const hashtagsHiddenInput = document.getElementById('review_edit_hashtags');
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


/**
 * 리뷰 수정 시 별점을 처리하는 함수
 */
document.addEventListener('DOMContentLoaded', function () {
    const stars = document.querySelectorAll('#star-rating .star');
    const scoreInput = document.getElementById('review_edit_score');
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