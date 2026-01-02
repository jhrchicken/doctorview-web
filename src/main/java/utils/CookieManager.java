package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CookieManager {
	/*
	쿠키생성 : 생성시 response내장객체가 필요하므로 매개변수를 통해
		JSP에서 전달받아야한다. 나머지는 쿠키명, 쿠키값, 유효시간
		설정을 위한 값이다. 
	*/
    public static void makeCookie(HttpServletResponse response, 
    		String cName, String cValue, int cTime) {
    	//생성자를 통해 쿠키를 생성한다. 
        Cookie cookie = new Cookie(cName, cValue);
        //경로를 설정한다. 
        cookie.setPath("/");
        //유효시간을 설정한다. 
        cookie.setMaxAge(cTime);
        //응답헤더에 추가하여 클라이언트로 전송한다. 
        response.addCookie(cookie);
    }
    //쿠키값읽기 : request내장객체가 필요하므로 매개변수로 선언한다.
    public static String readCookie(HttpServletRequest request, 
    		String cName) {
        String cookieValue = "";
        //생성된 쿠키를 배열로 읽어온다. 
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
        	//갯수만큼 반복해서 이름이 일치하는 쿠키의 값을 저장한다. 
            for (Cookie c : cookies) {  
                String cookieName = c.getName();
                if (cookieName.equals(cName)) {
                    cookieValue = c.getValue();
                }
            }
        }
        return cookieValue; 
    }
    /*
    쿠키삭제 : 쿠키는 삭제를 위한 별도의 메서드가 없다. 유지시간을 0으로
     	설정하면 삭제된다. 따라서 앞에서 정의한 makeCookis()메서드를 
     	사용한다.  
    */
    public static void deleteCookie(HttpServletResponse response, String cName) {    	
        makeCookie(response, cName, "", 0);
    }
}


