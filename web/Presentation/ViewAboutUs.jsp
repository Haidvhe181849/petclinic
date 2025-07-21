<%-- 
    Document   : ViewAboutUs
    Created on : Jun 3, 2025, 8:29:55 AM
    Author     : trung123
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="Entity.AboutUs" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Pet Hospital</title>
    
    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/Presentation/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/Presentation/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/Presentation/css/style_1.css" rel="stylesheet">
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
     integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
     crossorigin=""/>
    
    <style>
        .about-section {
            padding: 80px 0;
        }
        
        .section-title {
            position: relative;
            display: inline-block;
            margin-bottom: 40px;
        }
        
        .section-title::before {
            position: absolute;
            content: "";
            width: 45px;
            height: 2px;
            top: 50%;
            left: -55px;
            margin-top: -1px;
            background: var(--primary);
        }
        
        .section-title::after {
            position: absolute;
            content: "";
            width: 45px;
            height: 2px;
            top: 50%;
            right: -55px;
            margin-top: -1px;
            background: var(--primary);
        }
        
        .about-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 45px rgba(0, 0, 0, .08);
            padding: 30px;
            margin-bottom: 30px;
            transition: all .5s;
        }
        
        .about-card:hover {
            transform: translateY(-10px);
        }
        
        .about-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: var(--primary);
            color: #fff;
            font-size: 32px;
            margin-bottom: 20px;
        }
        
        .about-img {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
        }
        
        .about-img img {
            width: 100%;
            transition: .5s;
        }
        
        .about-img:hover img {
            transform: scale(1.1);
        }
        
        .team-item {
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 45px rgba(0, 0, 0, .08);
        }
        
        .team-img {
            position: relative;
            overflow: hidden;
        }
        
        .team-img img {
            width: 100%;
            transition: .5s;
        }
        
        .team-item:hover img {
            transform: scale(1.1);
        }
        
        .team-text {
            position: relative;
            padding: 25px 15px;
            text-align: center;
            background-color: #fff;
        }
        
        .team-social {
            position: absolute;
            top: -20px;
            right: 20px;
            padding: 5px 10px;
            background: var(--primary);
            border-radius: 10px;
        }
        
        .team-social a {
            display: inline-block;
            margin: 0 5px;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            border-radius: 50%;
            transition: .3s;
        }
        
        .team-social a:hover {
            background: #fff;
            color: var(--primary);
        }
        
        .contact-info {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 45px rgba(0, 0, 0, .08);
            padding: 30px;
        }
        
        .contact-info-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .contact-info-icon {
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: var(--primary);
            color: #fff;
            font-size: 18px;
            margin-right: 15px;
        }
        
        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 0 45px rgba(0, 0, 0, .08);
        }
        
        .gallery-img {
            position: relative;
            overflow: hidden;
        }
        
        .gallery-img img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            transition: .5s;
        }
        
        .gallery-item:hover img {
            transform: scale(1.1);
        }
        
        .gallery-text {
            position: relative;
            padding: 25px 15px;
            text-align: center;
            background-color: #fff;
        }
        
        .map-container {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 45px rgba(0, 0, 0, .08);
        }
        
        #map {
            width: 100%;
            height: 450px;
            border: 0;
        }
    </style>
</head>

<body>
    <!-- Include Header -->
    <jsp:include page="Header.jsp"></jsp:include>
    
    <!-- Hero Area Start -->
    <div class="slider-area2 slider-height2 d-flex align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="hero-cap text-center pt-50">
                        <h2>About Us</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- About Section Start -->
    <div class="container-fluid about-section py-5">
        <div class="container">
            <div class="row g-5 align-items-center">
                <div class="col-lg-6">
                    <div class="about-img">
                        <img src="${pageContext.request.contextPath}/Presentation/img/about/pet.jpg" class="img-fluid rounded" alt="">
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="text-start mb-4">
                        <h1 class="mb-3">Welcome to Our Pet Hospital</h1>
                        <p class="mb-4">At our Pet Hospital, we are passionate about providing the highest quality veterinary care for your furry family members. With state-of-the-art facilities, a team of experienced veterinarians, and a compassionate staff, we strive to make every visit comfortable and stress-free for both pets and their owners.</p>
                        <p>From routine check-ups to specialized treatments, we are committed to the health and well-being of your pets throughout all stages of their lives. Our mission is to deliver exceptional care with compassion and expertise.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- About Section End -->
    
    <!-- Contact Info Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-5">Contact Information</h1>
                <p class="mb-4">Get in touch with us for appointments, emergencies, or any questions about our services.</p>
            </div>
            <div class="row g-5">
                <c:forEach var="a" items="${list}">
                    <div class="col-lg-12">
                        <div class="contact-info">
                            <div class="contact-info-item">
                                <div class="contact-info-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <div class="contact-info-text">
                                    <h4>Address</h4>
                                    <p>${a.address}</p>
                                </div>
                            </div>
                            <div class="contact-info-item">
                                <div class="contact-info-icon">
                                    <i class="fas fa-phone-alt"></i>
                                </div>
                                <div class="contact-info-text">
                                    <h4>Phone</h4>
                                    <p>${a.phone}</p>
                                </div>
                            </div>
                            <div class="contact-info-item">
                                <div class="contact-info-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <div class="contact-info-text">
                                    <h4>Email</h4>
                                    <p>${a.email}</p>
                                </div>
                            </div>
                            <div class="contact-info-item">
                                <div class="contact-info-icon">
                                    <i class="fas fa-info-circle"></i>
                                </div>
                                <div class="contact-info-text">
                                    <h4>About Us</h4>
                                    <p>${a.description}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="clinicAddress" value="${a.address}">
                </c:forEach>
            </div>
        </div>
    </div>
    <!-- Contact Info End -->
    
    <!-- Services Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-5">Our Mission & Values</h1>
                <p class="mb-4">We are dedicated to providing exceptional veterinary care with compassion and expertise</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="about-card text-center">
                        <div class="about-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <h4 class="mb-3">Compassionate Care</h4>
                        <p class="mb-0">We treat every pet as if they were our own, providing gentle, compassionate care tailored to their individual needs.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="about-card text-center">
                        <div class="about-icon">
                            <i class="fas fa-stethoscope"></i>
                        </div>
                        <h4 class="mb-3">Medical Excellence</h4>
                        <p class="mb-0">Our team is committed to staying at the forefront of veterinary medicine, utilizing the latest techniques and technologies.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="about-card text-center">
                        <div class="about-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h4 class="mb-3">Client Education</h4>
                        <p class="mb-0">We believe in empowering pet owners with knowledge to make informed decisions about their pet's health and wellbeing.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Services End -->
    
    <!-- Gallery Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-5">Our Facility</h1>
                <p class="mb-4">Take a look at our modern facilities designed for your pet's comfort and care</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="gallery-item">
                        <div class="gallery-img">
                            <img src="https://sudospaces.com/happyvet-com-vn/2019/06/a-meo-me-di-kham-thai-dinh-ky.jpg" alt="Pet Examination">
                        </div>
                        <div class="gallery-text">
                            <h5>Examination Room</h5>
                            <p>Modern facilities for thorough pet examinations</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="gallery-item">
                        <div class="gallery-img">
                            <img src="https://caodangytetphcm.edu.vn/wp-content/uploads/2022/04/top-phong-kham-thu-y-q7.jpg" alt="Treatment Area">
                        </div>
                        <div class="gallery-text">
                            <h5>Treatment Area</h5>
                            <p>Specialized equipment for various treatments</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="gallery-item">
                        <div class="gallery-img">
                            <img src="https://medlatec.vn/media/2589/content/20230208_luu-y-khi-tim-phong-dai-cho-cho-1.jpg" alt="Waiting Room">
                        </div>
                        <div class="gallery-text">
                            <h5>Waiting Room</h5>
                            <p>Comfortable space for pets and their owners</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Gallery End -->
    
    <!-- Team Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-5">Our Veterinary Team</h1>
                <p class="mb-4">Meet our experienced and compassionate veterinary professionals</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="team-item">
                        <div class="team-img">
                            <img src="${pageContext.request.contextPath}/Presentation/img/team/1.png" alt="Dr. Sarah Johnson">
                        </div>
                        <div class="team-text">
                            <div class="team-social">
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                            <h5>Dr. Sarah Johnson</h5>
                            <p>Chief Veterinarian</p>
                            <p class="mb-0">Specialized in small animal medicine with over 15 years of experience.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="team-item">
                        <div class="team-img">
                            <img src="${pageContext.request.contextPath}/Presentation/img/team/2.png" alt="Dr. Michael Chen">
                        </div>
                        <div class="team-text">
                            <div class="team-social">
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                            <h5>Dr. Michael Chen</h5>
                            <p>Veterinary Surgeon</p>
                            <p class="mb-0">Expert in advanced surgical procedures and emergency care.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="team-item">
                        <div class="team-img">
                            <img src="${pageContext.request.contextPath}/Presentation/img/team/3.png" alt="Dr. Emily Rodriguez">
                        </div>
                        <div class="team-text">
                            <div class="team-social">
                                <a href="#"><i class="fab fa-facebook-f"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                            <h5>Dr. Emily Rodriguez</h5>
                            <p>Veterinary Dermatologist</p>
                            <p class="mb-0">Specialized in treating skin conditions and allergies in pets.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Team End -->
    
    <!-- Map Start -->
    <div class="container-fluid py-5">
        <div class="container">
            <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                <h1 class="display-5">Find Us</h1>
                <p class="mb-4">Visit our clinic at the location shown on the map below</p>
            </div>
            <div class="map-container">
                <div id="map"></div>
            </div>
        </div>
    </div>
    <!-- Map End -->
    
    <!-- Include Footer -->
    <jsp:include page="Footer.jsp"></jsp:include>
    
    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   
    
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/waypoints/waypoints.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/lightbox/js/lightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/Presentation/lib/owlcarousel/owl.carousel.min.js"></script>
    
    <!-- Leaflet JavaScript -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
     integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
     crossorigin=""></script>
    
    <script>
        // Khởi tạo bản đồ khi trang tải xong
        document.addEventListener('DOMContentLoaded', function() {
            // Lấy địa chỉ từ thẻ input ẩn
            const address = document.getElementById('clinicAddress').value;
            
            // Khởi tạo bản đồ với vị trí mặc định (Hà Nội)
            const map = L.map('map').setView([21.0285, 105.8542], 15);
            
            // Thêm layer OpenStreetMap
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);
            
            // Xử lý địa chỉ để tìm kiếm
            const searchAddress = address.replace(/ /g, '+');
            
            // Sử dụng Nominatim để geocode địa chỉ
            fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + searchAddress)
                .then(response => response.json())
                .then(data => {
                    if (data && data.length > 0) {
                        const lat = parseFloat(data[0].lat);
                        const lon = parseFloat(data[0].lon);
                        
                        // Cập nhật vị trí trung tâm của bản đồ
                        map.setView([lat, lon], 15);
                        
                        // Thêm marker vào bản đồ
                        const marker = L.marker([lat, lon]).addTo(map);
                        
                        // Thêm popup vào marker
                        marker.bindPopup(`<b>Pet Hospital</b><br>${address}`).openPopup();
                    } else {
                        console.error("Không thể tìm thấy tọa độ cho địa chỉ: " + address);
                    }
                })
                .catch(error => {
                    console.error("Lỗi khi tìm tọa độ: ", error);
                });
        });
    </script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/Presentation/js/main.js"></script>
</body>
</html>
