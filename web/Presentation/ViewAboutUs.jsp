        <%-- 
        Document   : ViewAboutUs
        Created on : Jun 3, 2025, 8:29:55 AM
        Author     : trung123
    --%>

    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ page import="Entity.AboutUs" %>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>About Us - Pet Hospital</title>
        <style>
            body {
                background-color: #fff;
                font-family: 'Segoe UI', sans-serif;
                color: #d00000;
                padding: 30px;
                line-height: 1.6;
            }
            .intro {
                background-color: #ffe5e5;
                padding: 20px;
                border-radius: 12px;
                margin-bottom: 30px;
                text-align: center;
            }
            .info-box {
                background-color: #fff5f5;
                border: 1px solid #d00000;
                padding: 15px;
                border-radius: 10px;
                margin-bottom: 30px;
            }
            .gallery {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
                justify-content: center;
                margin-bottom: 30px;
            }
            .gallery img {
                width: 250px;
                height: 180px;
                object-fit: cover;
                border: 2px solid #d00000;
                border-radius: 10px;
                transition: transform 0.3s ease;
            }
            .gallery img:hover {
                transform: scale(1.05);
            }
            .map-container {
                text-align: center;
            }
            iframe {
                width: 100%;
                height: 400px;
                border: 3px solid #d00000;
                border-radius: 10px;
            }
        </style>
    </head>
    <body>
        
        <div class="intro">
            <h2>Chào mừng đến với Phòng Khám Thú Cưng</h2>
            <p>Chúng tôi là nơi chăm sóc sức khỏe cho thú cưng với đội ngũ bác sĩ tận tâm, dịch vụ hiện đại và không gian thân thiện. Từ tiêm phòng, khám bệnh, đến tư vấn dinh dưỡng – chúng tôi luôn đồng hành cùng thú cưng của bạn!</p>
        </div>

        <div class="info-box">
            <h3>Thông tin liên hệ</h3>
            <c:forEach var="a" items="${list}">
                <p><strong>Địa chỉ:</strong> ${a.address}</p>
                <p><strong>Email:</strong> ${a.email}</p>
                <p><strong>Hotline:</strong> ${a.hotline}</p>
                <p><strong>Mô tả:</strong> ${a.description}</p>
            </c:forEach>
        </div>

        <div class="gallery">
    <img src="https://sudospaces.com/happyvet-com-vn/2019/06/a-meo-me-di-kham-thai-dinh-ky.jpg" alt="Mèo đi khám thai">
    <img src="https://caodangytetphcm.edu.vn/wp-content/uploads/2022/04/top-phong-kham-thu-y-q7.jpg" alt="Ảnh 2">
    <img src="https://medlatec.vn/media/2589/content/20230208_luu-y-khi-tim-phong-dai-cho-cho-1.jpg" alt="Phòng khám thú cưng">
</div>




        <div class="map-container">
            <h3>Bản đồ vị trí phòng khám</h3>
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d28630.508324435505!2d105.52731075317051!3d21.02092856734336!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e1!3m2!1svi!2s!4v1748915111840!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"
                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
            </iframe>
        </div>
    </body>
    </html>
