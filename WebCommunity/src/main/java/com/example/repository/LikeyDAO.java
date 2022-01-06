package com.example.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class LikeyDAO {
	
	private static LikeyDAO instance;
	
	public static LikeyDAO getInstance() {
		if (instance == null) {
			instance = new LikeyDAO();
		}
		return instance;
	}

	private LikeyDAO() {
	}

    // 좋아요한 사람들의  데이터베이스 추가 기능
	public int like(String userId, String userSubJect, String userIpAddr) {
		Connection con = null;
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO LIKEY VALUES (?, ?, ?)";

		try {
			con = JdbcUtils.getConnection();

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userSubJect);
			pstmt.setString(3, userIpAddr);

			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtils.close(con, pstmt);
		}
		return -1; 
	}
}
