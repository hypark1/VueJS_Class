<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*, org.json.simple.*"%><%
	response.addHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
	String cpage=request.getParameter("cpage");
	if(cpage==null){
		cpage="1";
	}
	int pageSize=5;
	
	int cp=Integer.parseInt(cpage);
	int end=cp*pageSize;
	int start=end-(pageSize-1);
	
	//[3] post방식일 때 한글 인코딩 처리
	request.setCharacterEncoding("UTF-8"); 
	//[4] 드라이버 로딩 및 DB연결
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="scott", dbpwd="tiger";
	Connection con=DriverManager.getConnection(url,user,dbpwd);
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	String sql1="select count(idx) cnt from board";
	ps=con.prepareStatement(sql1);
	rs=ps.executeQuery();
	rs.next();
	int cnt=rs.getInt("cnt");
	rs.close();
	ps.close();
	
	//[5] sql문 작성
	String sql="select * from (select rownum rn, a.* from (select idx,subject,name,filename,filesize, to_char(wdate,'yyyymmdd') wdate from board order by idx desc) a) where rn between ? and ?";
	//[6] sql문 실행 및 그 결과 값 받기
	ps=con.prepareStatement(sql);
	ps.setInt(1,start);
	ps.setInt(2,end);
	
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
	root.put("board_count", cnt);
%>
<%=root.toJSONString().trim()%>