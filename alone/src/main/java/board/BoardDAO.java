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
	public List<Board> getBoardList() {
		conn = JDBCUtil.getConnection();
		List<Board> boardList = new ArrayList<>();
		
		try {
			String sql = "SELECT * FROM board ORDER BY boardNo";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Board b = new Board();
				b.setBoardNo(rs.getInt("sid"));
				b.setUsername(rs.getString("username"));
				b.setbTitle(rs.getString("bTitle"));
				b.setbOption(rs.getInt("bOption"));
				b.setbWDate(rs.getTimestamp("bWDate"));
				b.setbWTime(rs.getTimestamp("bWTime"));
				
				boardList.add(b);	//어레이리스트에 객체 1명 저장
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return boardList;
	}
}