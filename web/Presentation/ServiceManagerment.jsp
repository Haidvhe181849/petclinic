<%-- 
    Document   : ServiceManagerment
    Created on : Jun 11, 2025, 11:19:47 PM
    Author     : LENOVO
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/Presentation/img/apple-icon.png" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Presentation/img/favicon.png" />
        <title>Service Managerment</title>

        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="${pageContext.request.contextPath}/Presentation/js/argon-dashboard-tailwind.js"></script>


        <!-- Nucleo Icons -->
        <link href="${pageContext.request.contextPath}/Presentation/css/nucleo-icons.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Presentation/css/nucleo-svg.css" rel="stylesheet" />
        <!-- Main Styling -->
        <link href="${pageContext.request.contextPath}/Presentation/css/argon-dashboard-tailwind.css?v=1.0.1" rel="stylesheet" />

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">



        <style>
            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            a {
                text-decoration: none !important;
            }

            a:hover {
                text-decoration: none !important;
            }



            #popup-message {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #d1e7dd; /* Bootstrap green background */
                color: #0f5132;            /* Bootstrap green text */
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.3);
                font-size: 18px;
                font-weight: 500;
                z-index: 9999;
                animation: fadeIn 0.4s ease;
            }
            .is-invalid {
                border: 1px solid red;
            }

            #sidebar-scroll::-webkit-scrollbar {
                width: 6px;
            }

            #sidebar-scroll::-webkit-scrollbar-track {
                background: transparent;
            }

            #sidebar-scroll::-webkit-scrollbar-thumb {
                background-color: rgba(100, 116, 139, 0.5); /* Slate-500 */
                border-radius: 3px;
            }

            #sidebar-scroll:hover::-webkit-scrollbar-thumb {
                background-color: rgba(100, 116, 139, 0.7);
            }

            #sidebar-scroll::-webkit-scrollbar {
                width: 6px;
            }

            html, body {
                height: 100%;
                overflow: hidden; /* nếu sidebar dùng fixed thì phần content có thể tự cuộn */
            }


            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translate(-50%, -60%);
                }
                to {
                    opacity: 1;
                    transform: translate(-50%, -50%);
                }
            }



        </style>

    </head>

    <body class="m-0 font-sans text-base antialiased font-normal dark:bg-slate-900 leading-default bg-gray-50 text-slate-500">
        <jsp:include page="/Presentation/Sidebar.jsp" />
        <main class="relative overflow-y-auto xl:ml-68 rounded-xl" style="height: calc(100vh - 64px);">

            <!-- Navbar -->
            <nav class="relative flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all ease-in shadow-none duration-250 rounded-2xl lg:flex-nowrap lg:justify-start" navbar-main navbar-scroll="false">
                <div class="flex items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit">
                    <nav>
                        <!-- breadcrumb -->
                        <ol class="flex flex-wrap pt-1 mr-12 bg-transparent rounded-lg sm:mr-16">
                            <li class="text-sm leading-normal">
                                <a class="text-black opacity-50" href="${pageContext.request.contextPath}/homeemployee">Home</a>
                            </li>
                            <!--                            <li class="text-sm pl-2 capitalize leading-normal text-black before:float-left before:pr-2 before:text-white before:content-['/']" aria-current="page">Tables</li>-->
                        </ol>
                    </nav>
                </div>
            </nav>

            <!-- Header title on pink background -->
            <div class="w-full bg-pink-100 py-4 flex justify-center items-center">
                <h2 class="text-2xl font-bold text-gray-700">Service Management</h2>
            </div> 

            <div class="w-full px-6 py-6 mx-auto">
                <!-- table 1 -->

                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-end">
                                    <div class="flex gap-2 items-center">
                                        <!-- Nút Sort -->
                                        <form action="${pageContext.request.contextPath}/Service" method="get" class="flex gap-2 items-center">
                                            <input type="hidden" name="service" value="slist"/>
                                            <input type="text" name="name" class="form-control" style="min-width: 180px"
                                                   value="${param.name}" placeholder="Service name..."/>
                                            <select name="order" class="..." onchange="this.form.submit()">
                                                <option value="">Sort by price</option>
                                                <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>Low to High</option>
                                                <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>High to Low</option>
                                            </select>

                                            <!-- Trạng thái -->
                                            <select name="status" class="px-2 py-1 rounded border text-sm">
                                                <option value="">All</option>
                                                <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                                                <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                            </select>

                                            <input type="number" name="minPrice" value="${minPrice}" placeholder="Min Price" class="form-control form-control-sm w-auto"/>
                                            <input type="number" name="maxPrice" value="${maxPrice}" placeholder="Max Price" class="form-control form-control-sm w-auto"/>


                                            <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                Filter
                                            </button>
                                        </form>



                                        <!-- Nút All -->
                                        <form action="${pageContext.request.contextPath}/Service" method="get">
                                            <input type="hidden" name="service" value="slist" />
                                            <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                All
                                            </button>
                                        </form>

                                        <!-- Nút Add Service -->
                                        <button class="btn btn-sm btn-outline-secondary"
                                                data-bs-toggle="modal"
                                                data-bs-target="#addServiceModal">
                                            Add Service
                                        </button>
                                    </div>
                                </div>



                            </div>
                            <div class="flex-auto px-0 pt-0 pb-2">
                                <div class="p-0 overflow-x-auto">
                                    <table class="items-center w-full mb-0 align-top border-collapse dark:border-white/40 text-slate-500">
                                        <thead class="align-bottom">
                                            <tr>
                                                <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">ID</th>
                                                <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Image</th>
                                                <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Name</th>
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Price</th>
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Description</th>
                                                <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Status</th>
                                                <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-collapse border-solid shadow-none dark:border-white/40 dark:text-white tracking-none whitespace-nowrap text-slate-400 opacity-70">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="sv" items="${slist}">
                                                <tr>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">${sv.serviceId}</td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left">
                                                        <c:if test="${not empty sv.image}">
                                                            <img src="${pageContext.request.contextPath}/${sv.image}" width="80" height="60" alt="Service Image" class="rounded shadow"/>
                                                        </c:if>
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">${sv.serviceName}</td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <fmt:formatNumber value="${sv.price}" type="number" groupingUsed="true" /> VNĐ
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <div class="line-clamp-2">
                                                            ${sv.description}
                                                        </div>
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left">
                                                        <span class="badge bg-${sv.status ? 'success' : 'secondary'}">
                                                            ${sv.status ? 'Active' : 'Inactive'}
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <a href="#"
                                                           class="btn btn-sm btn-outline-primary me-2 update-btn"
                                                           style="background: #0000;"
                                                           data-bs-toggle="modal"
                                                           data-bs-target="#editServiceModal"
                                                           data-id="${sv.serviceId}"
                                                           data-name="${sv.serviceName}"
                                                           data-price="${sv.price}"
                                                           data-describe="${fn:escapeXml(sv.description)}"
                                                           data-status="${sv.status}"
                                                           data-image="${sv.image}"
                                                           title="Edit Service">
                                                            <i class="fa fa-edit"></i>
                                                        </a>

                                                        <a href="Service?service=deleteService&sID=${sv.serviceId}"
                                                           onclick="return confirm('Are you sure to delete this Service?');"
                                                           class="btn btn-sm btn-outline-danger"
                                                           style="background: #0000;"
                                                           title="Delete Service">
                                                            <i class="fa fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Add Service Modal -->
            <div id="addServiceModal" class="modal fade" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form id="addServiceForm" onsubmit="return validateServiceForm('addServiceForm', 'addPriceError')" action="${pageContext.request.contextPath}/Service" method="post" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h4 class="modal-title">Add Service</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label>Name</label>
                                    <input type="text" name="service_name" class="form-control" required pattern="^(?!\s*$).{2,100}$" 
                                           title="Tên không được để trống hoặc chỉ chứa khoảng trắng. Tối thiểu 2 ký tự, tối đa 100 ký tự.">
                                </div>
                                <div class="mb-3">
                                    <label>Price</label>
                                    <input type="text"
                                           name="price"
                                           id="price"
                                           class="form-control"
                                           required
                                           placeholder="Enter price"
                                           inputmode="numeric"
                                           pattern="[\d,]+"
                                           title="Nhập số hợp lệ, ví dụ: 1,000,000">
                                    <div class="text-danger small" id="addPriceError"></div>
                                </div>
                                <div class="mb-3">
                                    <label>Description</label>
                                    <textarea name="description" class="form-control" rows="10" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label>Image</label>
                                    <input type="file" name="image" class="form-control" accept="image/*">
                                </div>
                                <input type="hidden" name="status" value="true">
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <input type="submit" name="submit" class="btn btn-success" value="Add">
                                <input type="hidden" name="service" value="addService">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <c:if test="${not empty sessionScope.message}">
                <div id="popup-message">${sessionScope.message}</div>
                <script>
                    setTimeout(function () {
                        var popup = document.getElementById("popup-message");
                        if (popup)
                            popup.style.display = "none";
                    }, 3000);
                </script>
                <c:remove var="message" scope="session"/>
            </c:if>


            <!-- Update Service Modal -->
            <div id="editServiceModal" class="modal fade" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form id="updateServiceForm" onsubmit="return validateServiceForm('updateServiceForm', 'updatePriceError')" action="${pageContext.request.contextPath}/Service" method="post" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h4 class="modal-title">Update Service</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label>ID</label>
                                    <input name="service_id" type="text" class="form-control" readonly required>
                                </div>
                                <div class="mb-3">
                                    <label>Name</label>
                                    <input type="text" name="service_name" class="form-control" required pattern="^(?!\s*$).{2,100}$" 
                                           title="Tên không được để trống hoặc chỉ chứa khoảng trắng. Tối thiểu 2 ký tự, tối đa 100 ký tự.">
                                </div>
                                <div class="mb-3">
                                    <label>Price</label>
                                    <input type="text" name="price" id="updatePrice" class="form-control" required placeholder="Enter price">
                                    <div class="text-danger small" id="updatePriceError"></div>
                                </div>

                                <div class="mb-3">
                                    <label>Description</label>
                                    <textarea name="description" class="form-control" rows="10" required></textarea>
                                </div>
                                <div class="mb-3">
                                    <label>Image</label>

                                    <input type="file" name="image" class="form-control" accept="image/*">
                                    <input type="hidden" name="old_image" id="old_image">
                                </div>
                                <div class="mb-3">
                                    <label>Status</label><br/>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" id="active" value="true">
                                        <label class="form-check-label" for="active">Active</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" id="inactive" value="false">
                                        <label class="form-check-label" for="inactive">Inactive</label>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <input type="submit" name="submit" class="btn btn-info" value="Save">
                                <input type="hidden" name="service" value="updateService">
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script>
                            $(document).ready(function () {
                                $(".update-btn").click(function () {
                                    var service_id = $(this).data("id");
                                    var service_name = $(this).data("name");
                                    var price = $(this).data("price");
                                    var description = $(this).data("describe");
                                    var status = $(this).data("status");
                                    var image = $(this).data("image");

                                    console.log("ID:", service_id,
                                            "name:", service_name,
                                            "price:", price,
                                            "desc:", description,
                                            "status:", status,
                                            "image:", image);

                                    $("#editServiceModal input[name='service_id']").val(service_id);
                                    $("#editServiceModal input[name='service_name']").val(service_name);
                                    $("#editServiceModal input[name='price']").val(price);
                                    $("#editServiceModal textarea[name='description']").val(description);
                                    $("#editServiceModal input[name='status'][value='" + status + "']").prop("checked", true);

                                    if (image) {
                                        $("#editServiceModal .current-image-preview").html(`<img src='${pageContext.request.contextPath}/${image}' alt='Current Image' width='100' class='rounded'>`);
                                        $("#editServiceModal #old_image").val(image);
                                    } else {
                                        $("#editServiceModal .current-image-preview").html(`<span class='text-muted'>No image</span>`);
                                    }
                                });
                            });

                            function validateServiceForm(formId, errorId) {
                                const form = document.getElementById(formId);
                                const priceInput = form.querySelector("input[name='price']");
                                const errorDiv = document.getElementById(errorId);
                                const priceValue = priceInput.value.trim();


                                const price = parseFloat(priceValue);

                                if (isNaN(price)) {
                                    errorDiv.innerText = "Giá không hợp lệ";
                                    priceInput.classList.add("is-invalid");
                                    return false;
                                }

                                if (price <= 0) {
                                    errorDiv.innerText = "Giá phải lớn hơn 0";
                                    priceInput.classList.add("is-invalid");
                                    return false;
                                }

                                if (price > 999999999) {
                                    errorDiv.innerText = "Giá không được vượt quá 999999999 VNĐ";
                                    priceInput.classList.add("is-invalid");
                                    return false;
                                }

                                errorDiv.innerText = "";
                                priceInput.classList.remove("is-invalid");
                                return true;
                            }

                            function attachLiveValidation(inputName, errorId) {
                                const inputFields = document.querySelectorAll(`input[name='${inputName}']`);
                                inputFields.forEach(el => {
                                    el.addEventListener("input", () => {
                                        const value = el.value.trim();
                                        const errorDiv = document.getElementById(errorId);

                                        if (!/^-?\d*(\.\d{0,2})?$/.test(value)) {
                                            errorDiv.innerText = "Chỉ được nhập số và tối đa 2 chữ số thập phân";
                                            el.classList.add("is-invalid");
                                        } else if (parseFloat(value) <= 0) {
                                            errorDiv.innerText = "Giá phải lớn hơn 0";
                                            el.classList.add("is-invalid");
                                        } else if (parseFloat(value) > 10000) {
                                            errorDiv.innerText = "Giá không được lớn hơn 10,000$";
                                            el.classList.add("is-invalid");
                                        } else {
                                            errorDiv.innerText = "";
                                            el.classList.remove("is-invalid");
                                        }
                                    });
                                });
                            }

                            document.addEventListener("DOMContentLoaded", function () {
                                const sidebar = document.querySelector("aside");
                                const hamburger = document.querySelector("[sidenav-trigger]");
                                const closeBtn = document.querySelector("[sidenav-close]");

                                if (hamburger) {
                                    hamburger.addEventListener("click", function () {
                                        const isOpen = sidebar.classList.contains("translate-x-0");
                                        sidebar.classList.toggle("-translate-x-full", isOpen);
                                        sidebar.classList.toggle("translate-x-0", !isOpen);
                                    });
                                }

                                if (closeBtn) {
                                    closeBtn.addEventListener("click", function () {
                                        sidebar.classList.add("-translate-x-full");
                                        sidebar.classList.remove("translate-x-0");
                                    });
                                }
                            });
        </script>

        <script>
            function formatNumberWithCommas(value) {
                value = value.replace(/[^\d]/g, ""); // Xóa hết ký tự không phải số
                if (value === "")
                    return "";
                return Number(value).toLocaleString("en-US");
            }

            document.addEventListener("DOMContentLoaded", function () {
                const priceIds = ["price", "updatePrice"]; // Các ID cần xử lý
                const inputs = priceIds.map(id => document.getElementById(id)).filter(el => el !== null);

                inputs.forEach(input => {
                    input.addEventListener("input", function () {
                        const cursor = this.selectionStart;
                        const originalLength = this.value.length;
                        const formatted = formatNumberWithCommas(this.value);
                        this.value = formatted;
                        const newLength = this.value.length;
                        this.selectionEnd = cursor + (newLength - originalLength);
                    });
                });

                // Khi submit: bỏ dấu phẩy để gửi đúng về server
                const form = document.querySelector("form");
                if (form) {
                    form.addEventListener("submit", function () {
                        inputs.forEach(input => {
                            input.value = input.value.replace(/,/g, "");
                        });
                    });
                }
            });
        </script>


    </body>


</html>
