/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.News;
import Utility.DBContext;
import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LENOVO
 */
public class NewsDAO extends DBContext {

    public Vector<News> getAllNews(String sql) {
        Vector<News> listNews = new Vector<>();

        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getTimestamp(4),
                        rs.getString(5),
                        rs.getBoolean(6)
                );
                listNews.add(n);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listNews;
    }
    
    public Vector<News> searchNews(String sql) {
        Vector<News> listNews = new Vector<>();

        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {

            while (rs.next()) {
                News n = new News(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getTimestamp(4),
                        rs.getString(5),
                        rs.getBoolean(6)
                );
                listNews.add(n);
            }
            System.out.println("Products fetched: " + listNews.size());

        } catch (SQLException ex) {
            Logger.getLogger(NewsDAO.class.getName()).log(Level.SEVERE, "Error fetching products", ex);
        }
        return listNews;
    }

    public int insertNews(News n) {
        String sql = "INSERT INTO News (news_id, image_url, nameNews, post_time, description, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        int i = 0;
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, n.getNewsId());
            ptm.setString(2, n.getImageUrl());
            ptm.setString(3, n.getNameNews());
            ptm.setTimestamp(4, n.getPostTime());
            ptm.setString(5, n.getDescription());
            ptm.setBoolean(6, n.isIsActive());
            i = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return i;
    }

    public String generateNextNewsId() {
        String sql = "SELECT TOP 1 news_id FROM News ORDER BY news_id DESC";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("news_id"); // ví dụ "N012"
                int num = Integer.parseInt(lastId.substring(1)); // bỏ chữ 'N', lấy số
                num++; // tăng lên
                return String.format("N%03d", num); // ví dụ N013
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "N001"; // Nếu chưa có gì trong DB
    }

    public void updateNews(News n) {
        String sql = "UPDATE News SET image_url = ?, nameNews = ?, post_time = ?, description = ?, is_active = ? WHERE news_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ptm.setString(1, n.getImageUrl());
            ptm.setString(2, n.getNameNews());
            ptm.setTimestamp(3, n.getPostTime());
            ptm.setString(4, n.getDescription());
            ptm.setBoolean(5, n.isIsActive());     // BIT
            ptm.setString(6, n.getNewsId());       // VARCHAR(50)
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updateStatus(String newsId, int isActive) {
        String sql = "UPDATE News SET is_active = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, isActive); // 1 = active, 0 = deactive
            ps.setString(2, newsId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int deleteNews(String newsId) {
        String sql = "DELETE FROM [dbo].[News]\n"
                + "      WHERE news_id=?";
        int i = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, newsId);
            i = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return i;
    }
    

    public Vector<News> getLatestNews() {
        Vector<News> list = new Vector<>();
        String sql = "SELECT TOP 5 * FROM News WHERE is_active = 1 ORDER BY post_time DESC";

        try (PreparedStatement ptm = connection.prepareStatement(sql)) {
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                News n = new News(
                        rs.getString("news_id"),
                        rs.getString("image_url"),
                        rs.getString("nameNews"),
                        rs.getTimestamp("post_time"), // vì bạn dùng java.util.Date
                        rs.getString("description"),
                        rs.getBoolean("is_active")
                );
                list.add(n);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        String sql = "SELECT * FROM News";
        NewsDAO nDAO = new NewsDAO();
//        Vector<News> nlist = nDAO.getLatestNews(5);
//        for (News news : nlist) {
//            System.out.println(news);
//        }
//        nDAO.deleteNews("N012");
News testNews = new News();
        testNews.setNewsId("N011");                        // Đảm bảo ID này tồn tại trong DB
        testNews.setImageUrl("https://cdn-media.sforum.vn/storage/app/media/anh-dep-16.jpg");
        testNews.setNameNews("Bài viết cập nhật");
        testNews.setPostTime(new Timestamp(System.currentTimeMillis()));
        testNews.setDescription("Nội dung mới được cập nhật");
        testNews.setIsActive(true);                        // true tương ứng với 1 (hiển thị)

        // Gọi hàm update
        nDAO.updateNews(testNews);

        System.out.println("Update hoàn tất.");
    }

    }

