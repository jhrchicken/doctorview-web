/**
 * 병원/의사 검색 시 실행되는 함수
 */
function searchHosp() {
	var form = document.searchForm;
	
	if (form.searchWord.value == "") {
		alert("검색어를 입력하세요");
		return false;
	}
	else {
		var searchField = form.searchField.value;
		var searchWord = form.searchWord.value;
		if (searchField == "hospital") {
			window.location.href = "hospital.do?searchField=name&searchWord=" + searchWord;
			return false;
		}
		else if (searchField == "doctor") {
			window.location.href = "doctor.do?searchField=name&searchWord=" + searchWord;
			return false;
		}
	}
}


/**
 * 베스트메뉴의 탭 메뉴 클릭 시 탭 메뉴를 활성화하고 해당하는 내용을 표시하는 함수
 */
document.addEventListener('DOMContentLoaded', function() {
    const tabItems = document.querySelectorAll('.best_menu .hd .tab ul li');
    const contentItems = document.querySelectorAll('.best_menu_wrap > ul');

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
    contentItems[0].style.display = 'block';
});

