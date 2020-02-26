<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*" %>
<%
	//[1] contentType을 "application/json" 으로 설정해야 함의 주의하자.

	/*[2] 자바스크립트 보안 정책(Same Origin Policy - 동일출처 정책) 
		- 웹 요청(request) 자신이 포함된 문서와 출처가 동일한 문서만 읽을 수 있다.
	    - Ajax요청시 요청을 보낸쪽과 받는 쪽이 동일한 도메인이어야 함
		
	    이를 해결하기 위해 cors (Cross-Origin Resource Sharing)  설정을 하자 
	*/
	response.addHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
	
	//[3] post방식일 때 한글 인코딩 처리
	request.setCharacterEncoding("UTF-8"); 
	
	
	//[4] 드라이버 로딩 및 DB연결
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="scott", dbpwd="tiger";
	Connection con=DriverManager.getConnection(url,user,dbpwd);
	
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	//[5] sql문 작성
	String sql="select idx,name,email, to_char(indate,'yyyy-mm-dd') indate from vue_user order by idx desc";
	
	//[6] sql문 실행 및 그 결과 값 받기
	ps=con.prepareStatement(sql);
	rs=ps.executeQuery();
	// 모든 데이터를 담아놓을 JSON Object
	JSONObject root = new JSONObject();
	
	JSONArray user_list = new JSONArray();
	while(rs.next()){
		JSONObject obj = new JSONObject();
		obj.put("idx", rs.getInt("idx"));
		obj.put("name", rs.getString("name"));
		obj.put("email", rs.getString("email"));
		obj.put("indate", rs.getString("indate"));
		user_list.add(obj);
	}
	root.put("users",user_list);
	
	//[7] DB관련 자원 반납
	if(rs!=null) rs.close();
	if(ps!=null) ps.close();
	if(con!=null) con.close();
	
%>
<%= root.toJSONString() %>