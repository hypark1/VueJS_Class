<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.*,java.io.*,com.oreilly.servlet.*, com.oreilly.servlet.multipart.*" %>
<%
	//[1] contentType을 "application/json" 으로 설정해야 함의 주의하자.
	response.addHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");
	
	//[3] post방식일 때 한글 인코딩 처리
	request.setCharacterEncoding("UTF-8"); 
	//업로드 디렉토리 절대경로 구하기
	String upDir=application.getRealPath("/Upload");
	File dir=new File(upDir);
	if(!dir.exists()){
		dir.mkdirs();//업로드 디렉토리가 없다면 생성
	}
	//중복된 파일이름 처리
	DefaultFileRenamePolicy df=new DefaultFileRenamePolicy();
	//파일 업로드 처리
	MultipartRequest mr=new MultipartRequest(request,upDir,100*1024*1024,"UTF-8", df);
	String name=mr.getParameter("name");
	System.out.println("name: "+name);
	String pwd="123";
	String subject=mr.getParameter("subject");
	String content=mr.getParameter("content");
	int readnum=0, refer=0, lev=0, sunbun=0;
	long filesize=0;
	String filename=mr.getFilesystemName("filename");
	System.out.println("filename>>"+filename);		
	File mfile=mr.getFile("filename");//첨부파일 없을 경우 null반환
	if(mfile!=null)
		filesize=mfile.length();
	
	
	
	//[4] 드라이버 로딩 및 DB연결
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:XE";
	String user="scott", dbpwd="tiger";
	Connection con=DriverManager.getConnection(url,user,dbpwd);
	
	PreparedStatement ps=null;
	ResultSet rs=null;
	
	//[5] sql문 작성
	String sql="insert into board(idx,name,subject,content,filename,filesize,wdate)"
				+" values(board_seq.nextval,?,?,?,?,?,sysdate)";
	ps=con.prepareStatement(sql);			
	
	//[6] sql문 실행 및 그 결과 값 받기
	ps.setString(1,name);
	ps.setString(2,subject);
	ps.setString(3,content);
	ps.setString(4,filename);
	ps.setLong(5,filesize);
	
	int n=ps.executeUpdate();
	
	//[7] DB관련 자원 반납
	if(rs!=null) rs.close();
	if(ps!=null) ps.close();
	if(con!=null) con.close();
%>
{"result": <%=n%> }