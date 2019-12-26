package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.HelpMeDto;
import kr.co.acorn.util.ConnLocator;

public class HelpMeDao {
	private static HelpMeDao single;

	private HelpMeDao() {
	}

	public static HelpMeDao getInstance() {
		if (single == null) {
			single = new HelpMeDao();
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

	public ArrayList<HelpMeDto> select(int start, int len) {
		ArrayList<HelpMeDto> list = new ArrayList<HelpMeDto>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT category, title, content, gender, helper_email, ask_email, iscomplete, ask_addr, DATE_FORMAT(regdate, '%Y/%m/%d') ");
			sql.append("FROM help_me ");
			sql.append("ORDER BY regdate DESC ");
			sql.append("LIMIT ?, ? ");//
			
			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, start);
			pstmt.setInt(++index, len);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				index = 0;
				int category = rs.getInt(++index);
				
				  String title = rs.getString(++index); String content = rs.getString(++index);
				  int gender = rs.getInt(++index); String helper_email = rs.getString(++index);
				  String ask_email = rs.getString(++index); boolean iscomplete =
				  rs.getBoolean(++index); String ask_addr = rs.getString(++index); 
				  String regdate = rs.getString(++index);

				list.add(new HelpMeDto(category, title, content, gender, helper_email, ask_email, iscomplete, ask_addr, regdate)); 
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
}
/*
 * public HelpMeDto select(String email) { HelpMeDto dto = null;
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * try { con = ConnLocator.getConnection(); StringBuffer sql = new
 * StringBuffer(); sql.
 * append("SELECT m_email, m_name, m_pwd, m_phone, DATE_FORMAT(m_regdate, '%Y/%m/%d') "
 * ); sql.append("FROM member "); sql.append("WHERE m_email = ? ");
 * 
 * pstmt = con.prepareStatement(sql.toString()); int index = 0;
 * pstmt.setString(++index, email);
 * 
 * rs = pstmt.executeQuery(); if (rs.next()) { index = 0; email =
 * rs.getString(++index); String name = rs.getString(++index); String pwd =
 * rs.getString(++index); String phone = rs.getString(++index); String regdate =
 * rs.getString(++index);
 * 
 * DeptDto deptDto = new DeptDto(deptNo, null, null); // null�� name, loc
 * 
 * dto = new HelpMeDto(email, name, pwd, phone, regdate); } } catch
 * (SQLException e) { // TODO Auto-generated catch block e.printStackTrace(); }
 * finally { try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close();
 * if (con != null) con.close();
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } }
 * 
 * return dto; }
 * 
 * public boolean insert(HelpMeDto dto) { boolean isSuccess = false;
 * 
 * Connection con = null; PreparedStatement pstmt = null;
 * 
 * try { con = ConnLocator.getConnection(); StringBuffer sql = new
 * StringBuffer();
 * sql.append("INSERT INTO member(m_email, m_name, m_pwd, m_phone, m_regdate) "
 * ); sql.append("VALUES(?, ?, ?, ?, CURDATE()) ");
 * 
 * 
 * pstmt = con.prepareStatement(sql.toString()); int index = 0;
 * pstmt.setString(++index, dto.getEmail()); pstmt.setString(++index,
 * dto.getName()); pstmt.setString(++index, dto.getPassword());
 * pstmt.setString(++index, dto.getPhone());
 * 
 * pstmt.executeUpdate();
 * 
 * isSuccess = true;
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } finally { try { if (pstmt != null) pstmt.close(); if
 * (con != null) con.close();
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); }
 * 
 * } return isSuccess; }
 * 
 * public boolean update(HelpMeDto dto) { boolean isSuccess = false;
 * 
 * Connection con = null; PreparedStatement pstmt = null;
 * 
 * try { con = ConnLocator.getConnection(); StringBuffer sql = new
 * StringBuffer(); sql.append("UPDATE member ");
 * sql.append("SET m_name = ?, m_pwd = ?, m_phone = ? ");
 * sql.append("WHERE m_email = ? ");
 * 
 * pstmt = con.prepareStatement(sql.toString()); int index = 0;
 * pstmt.setString(++index, dto.getName()); pstmt.setString(++index,
 * dto.getPassword()); pstmt.setString(++index, dto.getPhone());
 * pstmt.setString(++index, dto.getEmail());
 * 
 * pstmt.executeUpdate();
 * 
 * isSuccess = true;
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } finally { try { if (pstmt != null) pstmt.close(); if
 * (con != null) con.close();
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); }
 * 
 * } return isSuccess; }
 * 
 * public boolean delete(String email) { boolean isSuccess = false;
 * 
 * Connection con = null; PreparedStatement pstmt = null;
 * 
 * try { con = ConnLocator.getConnection(); StringBuffer sql = new
 * StringBuffer(); sql.append("DELETE FROM member WHERE m_email = ? ");
 * 
 * pstmt = con.prepareStatement(sql.toString()); int index = 0;
 * pstmt.setString(++index, email);
 * 
 * pstmt.executeUpdate();
 * 
 * isSuccess = true;
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } finally { try { if (pstmt != null) pstmt.close(); if
 * (con != null) con.close();
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } }
 * 
 * return isSuccess; }
 * 
 * public HelpMeDto getMember(HelpMeDto dto) { HelpMeDto HelpMeDto = null;
 * 
 * Connection con = null; PreparedStatement pstmt = null; ResultSet rs = null;
 * 
 * try { con = ConnLocator.getConnection(); StringBuffer sql = new
 * StringBuffer(); sql.
 * append("SELECT m_email, m_name, m_phone, date_format(m_regdate, '%Y/%m/%d') "
 * ); sql.append("FROM member ");
 * sql.append("WHERE m_email = ? AND m_pwd = PASSWORD(?) ");
 * 
 * pstmt = con.prepareStatement(sql.toString()); int index = 0;
 * pstmt.setString(++index, dto.getEmail() ); pstmt.setString(++index,
 * dto.getPassword());
 * 
 * rs = pstmt.executeQuery(); if (rs.next()) { index = 0; String email =
 * rs.getString(++index); String name = rs.getString(++index); String phone =
 * rs.getString(++index); String regdate = rs.getString(++index); HelpMeDto =
 * new HelpMeDto(email, name, null, phone, regdate); } } catch (SQLException e)
 * { // TODO Auto-generated catch block e.printStackTrace(); } finally { try {
 * if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (con !=
 * null) con.close();
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } }
 * 
 * return HelpMeDto;
 * 
 * }
 * 
 * 
 * }
 */