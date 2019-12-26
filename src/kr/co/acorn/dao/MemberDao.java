package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.MemberDto;
import kr.co.acorn.util.ConnLocator;

public class MemberDao {
	private static MemberDao single;

	private MemberDao() {
	}

	public static MemberDao getInstance() {
		if (single == null) {
			single = new MemberDao();
		}
		return single;
	}

	public int getTotalRows() {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(email) ");
			sql.append("FROM member ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;

			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = 0;
				count = rs.getInt(++index);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return count;
	}

	public boolean isEmail(String email) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT email ");
			sql.append("FROM member ");
			sql.append("WHERE email = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = 0;
				isSuccess = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return isSuccess;
	}

	public ArrayList<MemberDto> select(int start, int len) {
		ArrayList<MemberDto> list = new ArrayList<MemberDto>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT email, name, pwd, phone, addr, gender, DATE_FORMAT(regdate, '%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("ORDER BY regdate DESC ");
			sql.append("LIMIT ?, ? ");//

			System.out.println(con);

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				index = 0;
				String email = rs.getString(++index);
				String name = rs.getString(++index);
				String password = rs.getString(++index);
				String phone = rs.getString(++index);
				String addr = rs.getString(++index);
				int gender = rs.getInt(++index);
				String regdate = rs.getString(++index);

				list.add(new MemberDto(email, name, password, phone, addr, gender, regdate));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return list;
	}

	public MemberDto select(String email) {
		MemberDto dto = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT email, name, pwd, phone, addr, gender, DATE_FORMAT(regdate, '%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("WHERE email = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, email);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				email = rs.getString(++index);
				String name = rs.getString(++index);
				String password = rs.getString(++index);
				String phone = rs.getString(++index);
				String addr = rs.getString(++index);
				int gender = rs.getInt(++index);
				String regdate = rs.getString(++index);

				dto = new MemberDto(email, name, password, phone, addr, gender, regdate);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return dto;
	}

	public boolean insert(MemberDto dto) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO member(email, name, pwd, phone, addr, gender, regdate) ");
			sql.append("VALUES(?, ?, password(?), ?, ?, ?, CURDATE()) ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, dto.getEmail());
			pstmt.setString(++index, dto.getName());
			pstmt.setString(++index, dto.getPassword());
			pstmt.setString(++index, dto.getPhone());
			pstmt.setString(++index, dto.getAddr());
			pstmt.setInt(++index, dto.getGender());
			pstmt.executeUpdate();

			isSuccess = true;

		} catch (SQLException e) { // TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) { // TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return isSuccess;
	}

	public boolean update(MemberDto dto) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE member ");
			sql.append("SET name = ?, pwd = ?, phone = ?, addr = ?, gender = ? ");
			sql.append("WHERE email = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, dto.getName());
			pstmt.setString(++index, dto.getPassword());
			pstmt.setString(++index, dto.getPhone());
			pstmt.setString(++index, dto.getEmail());

			pstmt.executeUpdate();

			isSuccess = true;

		} catch (SQLException e) { // TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) { // TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return isSuccess;
	}

	public boolean delete(String email) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM member WHERE email = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, email);

			pstmt.executeUpdate();

			isSuccess = true;

		} catch (SQLException e) { // TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) { // TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return isSuccess;
	}

	public MemberDto getMember(MemberDto dto) {
		MemberDto MemberDto = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT email, name, phone, date_format(regdate, '%Y/%m/%d') ");
			sql.append("FROM member ");
			sql.append("WHERE email = ? AND pwd = PASSWORD(?) ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setString(++index, dto.getEmail());
			pstmt.setString(++index, dto.getPassword());

			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = 0;
				String email = rs.getString(++index);
				String name = rs.getString(++index);
				String phone = rs.getString(++index);
				String regdate = rs.getString(++index);
				MemberDto = new MemberDto(email,name,null,phone,null,0,regdate);
				
			}
		} catch (SQLException e) { // 
			e.printStackTrace(); 
		}finally {
				try {
					if (rs != null)
						rs.close();
					if (pstmt != null)
						pstmt.close();
					if (con != null)
						con.close();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
		

		}
		return MemberDto;

	}

}