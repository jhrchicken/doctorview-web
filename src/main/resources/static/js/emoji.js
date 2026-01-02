/**
 * 탭 메뉴 클릭 시 탭 메뉴를 활성화하고 해당하는 내용을 표시하는 함수
 */
document.addEventListener('DOMContentLoaded', function() {
    const tabItems = document.querySelectorAll('.tab_menu ul li');
    const contentItems = document.querySelectorAll('.emoji_list > ul');

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