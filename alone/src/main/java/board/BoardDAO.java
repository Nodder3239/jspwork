package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBCUtil;


public class BoardDAO {
	Connection conn = null;		
	PreparedStatement pstmt = null;		//sql 처리 메서드
	ResultSet rs = null;


	//게시판 목록 보기
	public List<Board> getStudentList() {
		conn = JDBCUtil.getConnection();
		List<Board> boards = new ArrayList<>();
		
		try {
			String sql = "SELECT * FROM board ORDER BY boardNo";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board s = new Board();
				s.setBoardNo(rs.getInt("sid"));
				s.setUsername(rs.getString("username"));
				s.setbTitle(rs.getString("bTitle"));
				s.setbOption(rs.getInt("bOption"));
				s.setbWDate(rs.getTimestamp("bWDate"));
				s.setbWTime(rs.getTimestamp("bWTime"));
				
				boards.add(s);	//어레이리스트에 객체 1명 저장
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return boards;
	}
}