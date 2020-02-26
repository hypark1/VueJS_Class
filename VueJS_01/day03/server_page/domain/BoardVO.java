package board.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class BoardVO implements Serializable {
	private Integer idx;
	private String name;
	private String subject;
	private String content;
	private java.sql.Timestamp wdate;	
	private String fileName; //업로드한 물리적 파일명
	private long fileSize;//파일크기
	private String imagePath="http://localhost:9090/VueBackend/Upload";
	
	public BoardVO() {
		
	}

	public BoardVO(Integer idx, String name, String subject, String content, Timestamp wdate, String fileName,
			 long fileSize) {
		super();
		this.idx = idx;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.wdate = wdate;
		this.fileName = fileName;
		this.fileSize = fileSize;
	}

	public Integer getIdx() {
		return idx;
	}

	public void setIdx(Integer idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public java.sql.Timestamp getWdate() {
		return wdate;
	}

	public void setWdate(java.sql.Timestamp wdate) {
		this.wdate = wdate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}


	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getImagePath() {
		if(this.fileName==null) this.fileName="noimage.png";
		return imagePath+"/"+this.fileName;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
    
	

}////////////////////////////////////////
