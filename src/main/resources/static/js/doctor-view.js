/**
 * 의사를 삭제하는 함수
 * 
 * @param {Integer} doc_idx - 의사 일련번호
 */
function deleteDoctor(doc_idx) {
   if (confirm("정말로 삭제하시겠습니까?")) {
      var form = document.deleteDoctorForm;
      form.method = "post";
      form.action = "/doctor/deleteDoctor.do";
      form.submit();
   }
}


/**
 * 의사 리뷰를 수정하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} doc_ref - 의사 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 * @param {Integer} score - 별점
 * @param {String} content - 리뷰 내용
 */
function openReviewEditModal(doc_ref, review_idx, score, content) {
   document.getElementById("review_edit_doc_ref").value = doc_ref;
    document.getElementById("review_edit_score").value = score;
    document.getElementById("review_edit_content").value = content;
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
 * 의사 리뷰를 삭제하는 함수
 * 
 * @param {Integer} doc_ref - 의사 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 */
// 리뷰 삭제
function deleteReview(doc_ref, review_idx) {
   if (confirm("댓글을 삭제하시겠습니까?")) {
      var form = document.deleteReviewForm;
      // hidden 필드에 값을 동적으로 설정
       form.doc_ref.value = doc_ref;
       form.review_idx.value = review_idx;
      form.method = "post";
      form.action = "/doctor/deleteReview.do";
      form.submit();
   }
}


/**
 * 의사 답변을 작성하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} doc_ref - 의사 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 */
function openReplyWriteModal(doc_ref, review_idx) {
   document.getElementById("reply_write_doc_ref").value = doc_ref;
    document.getElementById("reply_write_review_idx").value = review_idx;
}


/**
 * 의사 답변을 수정하기 위한 모달창을 여는 함수
 * 
 * @param {Integer} doc_ref - 의사 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 * @param {String} content - 리뷰 내용
 */
// 답변 수정 모달창 열기
function openReplyEditModal(doc_ref, review_idx, content) {
   document.getElementById("reply_edit_doc_ref").value = doc_ref;
    document.getElementById("reply_edit_content").value = content;
    document.getElementById("reply_edit_review_idx").value = review_idx;
}


/**
 * 의사 답변을 삭제하는 함수
 * 
 * @param {Integer} doc_ref - 의사 일련번호
 * @param {Integer} review_idx - 리뷰 일련번호
 */
function deleteReply(doc_ref, review_idx) {
   if (confirm("답변을 삭제하시겠습니까?")) {
      var form = document.deleteReplyForm;
      // hidden 필드에 값을 동적으로 설정
        form.doc_ref.value = doc_ref;
        form.review_idx.value = review_idx;
      form.method = "post";
      form.action = "/doctor/deleteReply.do";
      form.submit();
   }
}


/**
 * 폼값을 검증하는 함수
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
 * 의사 리뷰 작성 시 해시태그를 처리하는 함수
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