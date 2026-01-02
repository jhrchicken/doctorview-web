/**
 * 일반사용자와 병원사용자 간의 채팅방을 여는 함수
 * 
 * @param {String} userId - 일반사용자의 아이디
 * @param {String} hospId - 병원사용자의 아이디
 */
function openChatList(userId, hospId) {
	window.open('/chat/index.html#/chat/list?user=' + userId,
			'', 'width=500, height=650')
}


/**
 * 메뉴에 마우스를 올리면 #header에 open 클래스를 추가하고 마우스가 벗어났을 때 클래스를 제거하는 함수
 */
document.addEventListener('DOMContentLoaded', () => {
    const gnbList = document.querySelector('#header .gnb > ul');
    const header = document.querySelector('#header');

    if (gnbList && header) {
        gnbList.addEventListener('mouseover', () => {
            header.classList.add('open');
        });

        gnbList.addEventListener('mouseout', () => {
            header.classList.remove('open');
        });
    }
});