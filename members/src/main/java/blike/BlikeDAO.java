package blike;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.JDBCUtil;


public class BlikeDAO {
	Connection conn = null;				//db연결 및 종료
	PreparedStatement pstmt = null;		//sql 처리
	ResultSet rs = null;				//검색한 데이터셋
	
	public void like(Blike l) {
		
		try {
			conn = JDBCUtil.getConnection();
			String sql = "INSERT INTO blike(likeno, bno, id) "
					+ "VALUES (seq_likeno.NEXTVAL, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, l.getBno());
			pstmt.setString(2, l.getId());
	
			//sql 처리
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	
	public void updateLikeCount(int bno){
		try {
			conn = JDBCUtil.getConnection();
			String sql = "UPDATE board SET like_count = "
					+ "(SELECT count(bno) FROM blike WHERE bno = ?) WHERE bno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			pstmt.setInt(2, bno);
			//sql 실행
			pstmt.executeUpdate();
			

		} catch (SQLException e) {	
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
	}
}
