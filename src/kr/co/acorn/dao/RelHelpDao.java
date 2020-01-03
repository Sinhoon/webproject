package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.acorn.dto.ListHelpDto;
import kr.co.acorn.dto.RelHelpDto;
import kr.co.acorn.util.ConnLocator;

public class RelHelpDao {
	private static RelHelpDao single;

	private RelHelpDao() {
	}

	public static RelHelpDao getInstance() {
		if (single == null) {
			single = new RelHelpDao();
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
			sql.append("SELECT COUNT(num) ");
			sql.append("FROM Rel_help ");

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

	// 수락자 가져오기
	public JSONArray helperJson(int num) {
		JSONArray jsonArray = new JSONArray();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT num, helper_email, ask_email, choice , m.gender,m.addr,m.phone ");
			sql.append("FROM member m join rel_help r ");
			sql.append("WHERE m.email=r.helper_email AND num = ? ");
			sql.append("ORDER BY choice DESC ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, num);

			rs = pstmt.executeQuery();

			ListHelpDto listDto = null;
			JSONObject item = null;

			while (rs.next()) {
				index = 0;
				num = rs.getInt(++index);
				String helper_email = rs.getString(++index);
				String ask_email = rs.getString(++index);
				int choice = rs.getInt(++index);
				int gender = rs.getInt(++index);
				String addr = rs.getString(++index);
				String phone = rs.getString(++index);
				phone = phone.replaceFirst("(^[0-9]{4})([0-9]{4})([0-9]{4})$", "$1-$2-$3");
				item = new JSONObject();
				item.put("num", num);
				item.put("helper_email", helper_email);
				item.put("ask_email", ask_email);
				item.put("choice", choice);
				if (gender == 1) {
					item.put("gender", "남");
				} else {
					item.put("gender", "여");
				}
				item.put("addr", addr);
				item.put("phone", phone);
				jsonArray.add(item);
			}

		} catch (SQLException e) { // TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e) { // TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return jsonArray;
	}

	// 관계 삭제
	public boolean deleteJson(int num) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("delete ");
			sql.append("FROM rel_help ");
			sql.append("WHERE num=? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, num);
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

	/* 존재여부확인 */
	public int islist(ListHelpDto dto, String email) {
		int count = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(num) ");
			sql.append("FROM Rel_help ");
			sql.append("Where num=? and helper_email= ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, dto.getNum());
			pstmt.setString(++index, email);

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

	// 수락자수 감소
	public boolean downhmax(int num) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE List_Help SET helper_max = helper_max-1 ");
			sql.append("WHERE num = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, num);
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

//	수락자수 증가
	public boolean uphmax(int num) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE List_Help SET helper_max = helper_max+1 ");
			sql.append("WHERE num = ? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, num);
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

	// choice 변경
	public boolean changechoice(int num, String email, int choice) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE rel_Help SET choice = ? ");
			sql.append("WHERE num = ? and helper_email =? ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, choice);
			pstmt.setInt(++index, num);
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
  
	// 진행중
	public boolean changeiscom (int num,int iscom) {
		boolean isSuccess = false;
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE List_Help SET iscomplete = ? ");
			sql.append("WHERE num = ? and helper_max = 0 ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, iscom);
			pstmt.setInt(++index, num);
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
	// 미선택
		public boolean changeiscomed (int num,int iscom) {
			boolean isSuccess = false;
			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ConnLocator.getConnection();
				StringBuffer sql = new StringBuffer();
				sql.append("UPDATE List_Help SET iscomplete = ? ");
				sql.append("WHERE num = ? and helper_max != 0 ");

				pstmt = con.prepareStatement(sql.toString());
				int index = 0;
				pstmt.setInt(++index, iscom);
				pstmt.setInt(++index, num);
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
	// 관계 추가
	public boolean insert(ListHelpDto dto, String email) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO Rel_Help(num, helper_email ,ask_email ,choice) ");
			sql.append("VALUES(?, ?, ?,?) ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, dto.getNum());
			pstmt.setString(++index, email);
			pstmt.setString(++index, dto.getEmail());
			pstmt.setInt(++index, 0);
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
}
