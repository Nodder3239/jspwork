package board;

import java.io.Serializable;
import java.sql.Timestamp;

public class Board implements Serializable{
	private static final long serialVersionUID = 1L;

	//필드
	private int boardNo;
	private String username;
	private String bTitle;
	private String bContent;
	private int bOption;
	private Timestamp bWDate;
	private Timestamp bWTime;
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public int getbOption() {
		return bOption;
	}
	public void setbOption(int bOption) {
		this.bOption = bOption;
	}
	public Timestamp getbWDate() {
		return bWDate;
	}
	public void setbWDate(Timestamp bWDate) {
		this.bWDate = bWDate;
	}
	public Timestamp getbWTime() {
		return bWTime;
	}
	public void setbWTime(Timestamp bWTime) {
		this.bWTime = bWTime;
	}

}