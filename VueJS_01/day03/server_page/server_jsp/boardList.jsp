<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*, org.json.simple.*"%><%
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
	String sql="select idx,subject,name,filename,filesize, to_char(wdate,'yyyymmdd') wdate from board order by idx desc";
	//[6] sql문 실행 및 그 결과 값 받기
	ps=con.prepareStatement(sql);
	rs=ps.executeQuery();
	JSONObject root=new JSONObject();
	JSONArray arr=new JSONArray();
	while(rs.next()){
		JSONObject obj=new JSONObject();
		obj.put("idx",rs.getInt("idx"));
		obj.put("subject",rs.getString("subject"));
		obj.put("name",rs.getString("name"));
		obj.put("filename",rs.getString("filename"));
		obj.put("filesize",rs.getString("filesize"));
		obj.put("wdate",rs.getString("wdate"));
		obj.put("imagePath","http://localhost:9090/VueBackend/Upload/"+rs.getString("filename"));
		arr.add(obj);
	}
	//[7] DB관련 자원 반납
	if(rs!=null) rs.close();
	if(ps!=null) ps.close();
	if(con!=null) con.close();
	root.put("boards",arr);
%>
<%=root.toJSONString().trim()%>