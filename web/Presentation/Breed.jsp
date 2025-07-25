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
        <title>Breed Managerment</title>

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
            </nav>
            <!-- Header title on pink background -->
            <div class="w-full bg-pink-100 py-4 flex justify-center items-center">
                <h2 class="text-2xl font-bold text-gray-700">Breed Management</h2>
            </div>
            <div class="w-full px-6 py-6 mx-auto">
                <!-- table 1 -->

                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-end">
                                    <div class="flex gap-2 items-center">
                                        <!-- Filter form -->
                                        <form action="${pageContext.request.contextPath}/Breed" method="get" class="d-flex gap-2">
                                            <input type="hidden" name="service" value="listBreed"/>

                                            <input type="text" name="name" class="form-control" style="min-width: 180px"
                                                   value="${param.name}" placeholder="Breed name..."/>


                                            <select name="order" class="form-select">
                                                <option value="">Sort by name</option>
                                                <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>A → Z</option>
                                                <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>Z → A</option>
                                            </select>>

                                            <select name="status" class="form-select">
                                                <option value="">All Status</option>
                                                <option value="true" ${param.status == 'true' ? 'selected' : ''}>Active</option>
                                                <option value="false" ${param.status == 'false' ? 'selected' : ''}>Inactive</option>
                                            </select>

                                            <select name="typeId" class="form-select">
                                                <option value="">Animal Type</option> <!-- All -->
                                                <c:forEach var="type" items="${typeList}">
                                                    <option value="${type.animalTypeId}"
                                                            ${param.typeId == type.animalTypeId ? 'selected' : ''}>
                                                        ${type.typeName}
                                                    </option>
                                                </c:forEach>
                                            </select>


                                            <button class="btn btn-sm btn-outline-secondary">Filter</button>
                                        </form>

                                        <!-- Nút All -->
                                        <form action="${pageContext.request.contextPath}/Breed" method="get">
                                            <input type="hidden" name="service" value="listBreed" />
                                            <button type="submit" class="btn btn-sm btn-outline-secondary">
                                                All
                                            </button>
                                        </form>

                                        <!-- Nút Add Breed -->
                                        <button class="btn btn-sm btn-outline-secondary"
                                                data-bs-toggle="modal"
                                                data-bs-target="#addBreedModal">
                                            Add Breed
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
                                                <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Animal Type</th>
                                                <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Status</th>
                                                <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-collapse border-solid shadow-none dark:border-white/40 dark:text-white tracking-none whitespace-nowrap text-slate-400 opacity-70">Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="breed" items="${Breedlist}">
                                                <tr>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">
                                                        ${breed.breedId}
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left">
                                                        <c:if test="${not empty breed.image}">
                                                            <img src="${pageContext.request.contextPath}/${breed.image}" width="80" height="60" alt="Breed Image" class="rounded shadow"/>
                                                        </c:if>
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">
                                                        ${breed.breedName}
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        ${typeMap[breed.animalTypeId]}
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:choose>
                                                            <c:when test="${breed.active}">
                                                                <span class="bg-green-500 text-blue-500 text-xs font-bold px-2 py-1 rounded badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="bg-red-500 text-red-600 text-xs font-bold px-2 py-1 rounded badge bg-secondary">Inactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center">
                                                        <button class="btn btn-sm btn-outline-primary me-2 update-btn" 
                                                                style="background: #0000;" 
                                                                data-bs-toggle="modal" 
                                                                data-bs-target="#editBreedModal"
                                                                data-id="${breed.breedId}"
                                                                data-name="${breed.breedName}"
                                                                data-type="${breed.animalTypeId}"
                                                                data-status="${breed.active}"
                                                                data-image="${breed.image}">
                                                            <i class="fa fa-edit"></i>
                                                        </button>
                                                        <a href="Breed?service=deleteBreed&id=${breed.breedId}"
                                                           onclick="return confirm('Are you sure to delete this Breed?');"
                                                           class="btn btn-sm btn-outline-danger"
                                                           style="background: #0000;"
                                                           title="Delete Breed">
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

            <!-- Add Modal -->
            <!-- Add Modal -->
            <div class="modal fade" id="addBreedModal" tabindex="-1">
                <div class="modal-dialog">
                    <form id="addBreedForm" class="modal-content" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title">Add Breed</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-danger d-none" id="add-error"></div>

                            <div class="mb-3">
                                <label>Name</label>
                                <input name="breed_name" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label>Animal Type</label>
                                <select name="animal_type_id" class="form-select" required>
                                    <c:forEach var="type" items="${typeList}">
                                        <option value="${type.animalTypeId}">${type.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label>Image</label>
                                <input type="file" name="image" class="form-control" accept="image/*" required />
                            </div>

                            <input type="hidden" name="is_active" value="true" />
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-success">Add</button>
                        </div>
                    </form>
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
            <!-- Edit Modal -->
            <div class="modal fade" id="editBreedModal" tabindex="-1">
                <div class="modal-dialog">
                    <form id="editBreedForm" class="modal-content" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Breed</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="alert alert-danger d-none" id="edit-error"></div>

                            <input type="hidden" name="breed_id" />
                            <input type="hidden" name="oldImage" />

                            <div class="mb-3">
                                <label>Name</label>
                                <input name="breed_name" class="form-control" required />
                            </div>

                            <div class="mb-3">
                                <label>Animal Type</label>
                                <select name="animal_type_id" class="form-select" required>
                                    <c:forEach var="type" items="${typeList}">
                                        <option value="${type.animalTypeId}">${type.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label>Image</label>
                                <input type="file" name="image" class="form-control" accept="image/*" />
                            </div>

                            <div class="mb-3">
                                <label>Status</label>
                                <select name="is_active" class="form-select">
                                    <option value="true">Active</option>
                                    <option value="false">Inactive</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>


            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                    document.querySelectorAll('.update-btn').forEach(btn => {
                        btn.addEventListener('click', () => {
                            const modal = document.querySelector('#editBreedModal');
                            modal.querySelector("input[name='breed_id']").value = btn.dataset.id;
                            modal.querySelector("input[name='breed_name']").value = btn.dataset.name;
                            modal.querySelector("select[name='animal_type_id']").value = btn.dataset.type;
                            modal.querySelector("input[name='oldImage']").value = btn.dataset.image;
                            modal.querySelector("select[name='is_active']").value = btn.dataset.status;
                        });
                    });
            </script>    

            <script>
                document.addEventListener("DOMContentLoaded", () => {
                    const addForm = document.getElementById("addBreedForm");
                    const editForm = document.getElementById("editBreedForm");
                    const addError = document.getElementById("add-error");
                    const editError = document.getElementById("edit-error");

                    function validateName(name) {
                        return name.trim().length >= 2 && name.trim().length <= 100;
                    }

                    function handleBreedSubmit(form, errorBox, service) {
                        form.addEventListener("submit", function (e) {
                            e.preventDefault();
                            const formData = new FormData(form);
                            formData.append("service", service);

                            const name = formData.get("breed_name");
                            if (!validateName(name)) {
                                showError(errorBox, "❌ Tên phải từ 2-100 ký tự và không toàn khoảng trắng.");
                                return;
                            }

                            fetch("Breed", {
                                method: "POST",
                                body: formData,
                            })
                                    .then((res) => res.text())
                                    .then((text) => {
                                        try {
                                            const json = JSON.parse(text);
                                            showError(errorBox, json.message || "Có lỗi xảy ra!");
                                        } catch {
                                            location.href = "Breed?service=listBreed";
                                        }
                                    })
                                    .catch(() => {
                                        showError(errorBox, "❌ Lỗi mạng, thử lại sau.");
                                    });
                        });
                    }

                    function showError(errorBox, message) {
                        errorBox.classList.remove("d-none");
                        errorBox.innerText = message;
                    }

                    handleBreedSubmit(addForm, addError, "addBreed");
                    handleBreedSubmit(editForm, editError, "updateBreed");

                    // Đổ dữ liệu vào Edit Modal
                    document.querySelectorAll(".update-btn").forEach((btn) => {
                        btn.addEventListener("click", () => {
                            const modal = document.querySelector("#editBreedModal");
                            modal.querySelector("input[name='breed_id']").value = btn.dataset.id;
                            modal.querySelector("input[name='breed_name']").value = btn.dataset.name;
                            modal.querySelector("select[name='animal_type_id']").value = btn.dataset.type;
                            modal.querySelector("input[name='oldImage']").value = btn.dataset.image;
                            modal.querySelector("select[name='is_active']").value = btn.dataset.status;
                            editError.classList.add("d-none");
                        });
                    });
                });
            </script>

    </body>
</html>
