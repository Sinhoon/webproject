package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.acorn.dto.ListHelpDto;
import kr.co.acorn.util.ConnLocator;

public class ListHelpDao {
	private static ListHelpDao single;

	private ListHelpDao() {
	}

	public static ListHelpDao getInstance() {
		if (single == null) {
			single = new ListHelpDao();
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
			sql.append("FROM List_help ");

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

	public boolean insert(ListHelpDto dto) {
		boolean isSuccess = false;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO List_Help(num, category, title, content,"
					+ " gender,iscomplete,helper_max,ask_addr,email,regdate) ");
			sql.append("VALUES(?, ?, ?, ?, ?,?,?,? ,?,NOW()) ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			pstmt.setInt(++index, dto.getNum());
			pstmt.setInt(++index, dto.getCategory());
			pstmt.setString(++index, dto.getTitle());
			pstmt.setString(++index, dto.getContent());
			pstmt.setInt(++index, dto.getGender());
			pstmt.setInt(++index, dto.getIscomplete());
			pstmt.setInt(++index, dto.getHmax());
			pstmt.setString(++index, dto.getAddr());
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

	public int getMaxNextNo() {
		int result = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT IFNULL(MAX(num) +1,1) ");
			sql.append("FROM list_help ");

			pstmt = con.prepareStatement(sql.toString());
			int index = 0;
			rs = pstmt.executeQuery();
			if (rs.next()) {
				index = 0;
				result = rs.getInt(++index);
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

		return result;
	}
	
	// 전체보기
	   public JSONArray selectJson(int start, int len) {
		JSONArray jsonArray = new JSONArray();

	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         con = ConnLocator.getConnection();
	         StringBuffer sql = new StringBuffer();
	         sql.append(
	               "SELECT num, category, title, content, gender, iscomplete, helper_max, ask_addr, email, regdate ");
	         sql.append("FROM List_help ");
	         sql.append("WHERE helper_max != 0 and iscomplete = 0  ");
	         sql.append("ORDER BY regdate DESC ");
	         sql.append("LIMIT ?, ? ");//

	         pstmt = con.prepareStatement(sql.toString());
	         int index = 0;
	         pstmt.setInt(++index, start);
	         pstmt.setInt(++index, len);
	         rs = pstmt.executeQuery();
	         
	         ListHelpDto listDto = null;
	         JSONObject item = null;
	         
	         
	         while (rs.next()) {
	            index = 0;
	            int num = rs.getInt(++index);
	            int category = rs.getInt(++index);
	            String title = rs.getString(++index);
	            String content = rs.getString(++index);
	            int gender = rs.getInt(++index);
	            int iscomplete = rs.getInt(++index);
	            int hmax = rs.getInt(++index);
	            String addr = rs.getString(++index);
	            String email = rs.getString(++index);
	            String regdate = rs.getString(++index);

	            item = new JSONObject();
				item.put("num", num);
				item.put("category", category );
				item.put("title", title );
				item.put("gender", gender );
				item.put("iscomplete", iscomplete );
				item.put("hmax", hmax );
				item.put("addr", addr );
				item.put("email", email );
				item.put("regdate", regdate );
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

	   // 카테고리별 보기
	   public ArrayList<ListHelpDto> select(int start, int len, int category) {
	      ArrayList<ListHelpDto> list = new ArrayList<ListHelpDto>();

	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         con = ConnLocator.getConnection();
	         StringBuffer sql = new StringBuffer();
	         sql.append("SELECT num, title, content, gender, iscomplete, helper_max, ask_addr, email, regdate ");
	         sql.append("FROM List_help ");
	         sql.append("WHERE helper_max != 0 and category = ? and iscomplete = 0 ");
	         sql.append("ORDER BY regdate DESC ");
	         sql.append("LIMIT ?, ? ");//

	         pstmt = con.prepareStatement(sql.toString());
	         int index = 0;
	         pstmt.setInt(++index, start);
	         pstmt.setInt(++index, len);
	         pstmt.setInt(++index, category);
	         rs = pstmt.executeQuery();
	         while (rs.next()) {
	            index = 0;
	            int num = rs.getInt(++index);
	            String title = rs.getString(++index);
	            String content = rs.getString(++index);
	            int gender = rs.getInt(++index);
	            int iscomplete = rs.getInt(++index);
	            int hmax = rs.getInt(++index);
	            String addr = rs.getString(++index);
	            String email = rs.getString(++index);
	            String regdate = rs.getString(++index);

	            list.add(
	                  new ListHelpDto(num, category, title, content, gender, iscomplete, hmax, addr, email, regdate));

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

	      return list;
	   }

	// 상세보기 
	   public ListHelpDto select(int num) {
	      ListHelpDto list = new ListHelpDto();

	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         con = ConnLocator.getConnection();
	         StringBuffer sql = new StringBuffer();
	         sql.append("SELECT category, title, content, gender, iscomplete, helper_max, ask_addr, email, regdate ");
	         sql.append("FROM List_help ");
	         sql.append("WHERE helper_max != 0 and num = ? and iscomplete = 0 ");

	         pstmt = con.prepareStatement(sql.toString());
	         int index = 0;
	         pstmt.setInt(++index, num);
	         rs = pstmt.executeQuery();
	         while (rs.next()) {
	            index = 0;
	            int category = rs.getInt(++index);
	            String title = rs.getString(++index);
	            String content = rs.getString(++index);
	            int gender = rs.getInt(++index);
	            int iscomplete = rs.getInt(++index);
	            int hmax = rs.getInt(++index);
	            String addr = rs.getString(++index);
	            String email = rs.getString(++index);
	            String regdate = rs.getString(++index);

	            list = new ListHelpDto(num, category, title, content, gender, iscomplete, hmax, addr, email, regdate);

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

	      return list;
	   }
	   
	// 전체보기
	   public ArrayList<ListHelpDto> select(int start, int len) {
	      ArrayList<ListHelpDto> list = new ArrayList<ListHelpDto>();

	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;

	      try {
	         con = ConnLocator.getConnection();
	         StringBuffer sql = new StringBuffer();
	         sql.append(
	               "SELECT num, category, title, content, gender, iscomplete, helper_max, ask_addr, email, regdate ");
	         sql.append("FROM List_help ");
	         sql.append("WHERE helper_max != 0 and iscomplete = 0  ");
	         sql.append("ORDER BY regdate DESC ");
	         sql.append("LIMIT ?, ? ");//

	         pstmt = con.prepareStatement(sql.toString());
	         int index = 0;
	         pstmt.setInt(++index, start);
	         pstmt.setInt(++index, len);
	         rs = pstmt.executeQuery();
	         while (rs.next()) {
	            index = 0;
	            int num = rs.getInt(++index);
	            int category = rs.getInt(++index);
	            String title = rs.getString(++index);
	            String content = rs.getString(++index);
	            int gender = rs.getInt(++index);
	            int iscomplete = rs.getInt(++index);
	            int hmax = rs.getInt(++index);
	            String addr = rs.getString(++index);
	            String email = rs.getString(++index);
	            String regdate = rs.getString(++index);

	            list.add(
	                  new ListHelpDto(num, category, title, content, gender, iscomplete, hmax, addr, email, regdate));

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

	      return list;
	   }

	}
