<%-- 
    Document   : ManageAboutUsAdmin
    Created on : Jun 3, 2025, 8:28:59 AM
    Author     : trung123
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List, Entity.AboutUs" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/Presentation/img/apple-icon.png" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Presentation/img/favicon.png" />
        <title>About Us Management</title>

        <!--     Fonts and icons     -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
        <!-- Font Awesome Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

            #sidebar-scroll::-webkit-scrollbar {
                width: 6px;
            }

            #sidebar-scroll::-webkit-scrollbar-track {
                background: transparent;
            }

            #sidebar-scroll::-webkit-scrollbar-thumb {
                background-color: rgba(100, 116, 139, 0.5);
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
                overflow: auto;
            }

            .toast-container {
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1060;
            }
            
            .toast {
                background-color: #d1e7dd;
                color: #0f5132;
                padding: 15px;
                border-radius: 4px;
                box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
                animation: slideIn 0.3s forwards;
                margin-bottom: 10px;
            }

            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }

            .aboutus-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .aboutus-table th {
                background-color: #f8f9fa;
                color: #495057;
                padding: 15px;
                text-align: left;
                font-weight: 600;
                border-bottom: 2px solid #dee2e6;
            }

            .aboutus-table td {
                padding: 15px;
                border-bottom: 1px solid #e9ecef;
                vertical-align: middle;
            }
            
            .aboutus-table tr:hover {
                background-color: #f8f9fa;
            }
            
            .action-btns {
                display: flex;
                gap: 8px;
                justify-content: flex-end;
            }
            
            .btn-action {
                padding: 6px 12px;
                border-radius: 4px;
                color: white;
                font-size: 14px;
                cursor: pointer;
                border: none;
                transition: all 0.2s;
            }
            
            .btn-edit {
                background-color: #0d6efd;
            }
            
            .btn-edit:hover {
                background-color: #0b5ed7;
            }
            
            .btn-delete {
                background-color: #dc3545;
            }
            
            .btn-delete:hover {
                background-color: #bb2d3b;
            }
            
            .btn-add {
                background-color: #198754;
                margin-bottom: 20px;
                padding: 10px 16px;
            }
            
            .btn-add:hover {
                background-color: #157347;
            }
            
            .modal-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }
            
            .modal-footer {
                border-top: 1px solid #dee2e6;
            }
            
            .description-cell {
                max-width: 300px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>
    </head>

    <body class="m-0 font-sans text-base antialiased font-normal dark:bg-slate-900 leading-default bg-gray-50 text-slate-500">
        <div class="absolute w-full bg-blue-500 dark:hidden min-h-75"></div>
        
        <!-- sidenav  -->
        <aside class="fixed top-0 left-0 z-990 xl:ml-6 xl:left-0 xl:translate-x-0
               max-w-64 w-64 h-screen bg-white dark:bg-slate-850
               shadow-xl rounded-2xl transition-transform duration-200 transform -translate-x-full xl:relative flex flex-col"
               aria-expanded="false">
            <div class="h-19">
                <i class="absolute top-0 right-0 p-4 opacity-50 cursor-pointer fas fa-times dark:text-white text-slate-400 xl:hidden" sidenav-close></i>
                <a class="block px-8 py-6 m-0 text-sm whitespace-nowrap dark:text-white text-slate-700" href="${pageContext.request.contextPath}/Home" >
                    <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" class="inline h-full max-w-full transition-all duration-200 dark:hidden ease-nav-brand max-h-8" alt="main_logo" />
                    <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" class="hidden h-full max-w-full transition-all duration-200 dark:inline ease-nav-brand max-h-8" alt="main_logo" />

                </a>
            </div>

            <hr class="h-px mt-0 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent dark:bg-gradient-to-r dark:from-transparent dark:via-white dark:to-transparent" />
            <div id="sidebar-scroll" class="flex flex-col overflow-y-auto px-2"
                 style="height: calc(100vh - 5rem);">

                <ul class="flex flex-col pl-0 mb-0">

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 bg-blue-500/13 dark:text-white dark:opacity-80 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap rounded-lg px-4 font-semibold text-slate-700 transition-colors" href="${pageContext.request.contextPath}/dashboard">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-blue-500 ni ni-tv-2"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Dashboard</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/manage-about-us">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-blue-500 ni ni-world-2"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">About Us Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/News?service=listNews">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-orange-500 ni ni-bullet-list-67"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">News Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Service?service=listService">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center fill-current stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-emerald-500 ni ni-delivery-fast"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Service Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-caps-small"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Medicine Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/account-management">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-circle-08"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Account Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-calendar-grid-58"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Booking Management</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/feedback-management">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-chat-round"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Feedback Management</span>
                        </a>
                    </li>
                </ul>
            </div>           
        </aside>

        <!-- end sidenav -->

        <main class="relative h-full max-h-screen transition-all duration-200 ease-in-out xl:ml-68 rounded-xl">
            <!-- Navbar -->
            <nav class="relative flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all ease-in shadow-none duration-250 rounded-2xl lg:flex-nowrap lg:justify-start" navbar-main navbar-scroll="false">
                <div class="flex items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit">
                    <nav>
                        <!-- breadcrumb -->
                        <ol class="flex flex-wrap pt-1 mr-12 bg-transparent rounded-lg sm:mr-16">
                            <li class="text-sm leading-normal">
                                <a class="text-white opacity-50" href="javascript:;">Pages</a>
                            </li>
                            <li class="text-sm pl-2 capitalize leading-normal text-white before:float-left before:pr-2 before:text-white before:content-['/']" aria-current="page">About Us Management</li>
                        </ol>
                        <h6 class="mb-0 font-bold text-white capitalize">About Us Management</h6>
                    </nav>
                </div>
            </nav>
            <!-- end Navbar -->

            <!-- Toast container for messages -->
            <div class="toast-container" id="toastContainer">
                <c:if test="${not empty message}">
                    <div class="toast" role="alert">
                        <div class="toast-body">
                            ${message}
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Cards section -->
            <div class="w-full px-6 py-6 mx-auto">
                <div class="flex flex-wrap -mx-3">
                    <div class="w-full max-w-full px-3 mb-6">
                        <div class="relative flex flex-col min-w-0 break-words bg-white shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="border-black/12.5 rounded-t-2xl border-b-0 border-solid p-6">
                                <h5 class="mb-0 font-bold text-xl">About Us Management</h5>
                                <p class="mb-4 text-sm leading-normal">
                                    Manage your company information that will be displayed to users
                                </p>
                                
                                <!-- Add New Button -->
                                <button type="button" class="btn-action btn-add" data-bs-toggle="modal" data-bs-target="#addModal">
                                    <i class="fas fa-plus mr-1"></i> Add New Information
                                </button>
                                
                                <!-- Table Section -->
                                <div class="table-responsive">
                                    <table class="aboutus-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Address</th>
                                                <th>Phone</th>
                                                <th>Email</th>
                                                <th>Description</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="about" items="${list}">
                                                <tr>
                                                    <td>${about.about_id}</td>
                                                    <td>${about.address}</td>
                                                    <td>${about.phone}</td>
                                                    <td>${about.email}</td>
                                                    <td class="description-cell">${about.description}</td>
                                                    <td>
                                                        <div class="action-btns">
                                                            <button type="button" class="btn-action btn-edit" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#editModal"
                                                                    data-about-id="${about.about_id}"
                                                                    data-address="${about.address}"
                                                                    data-phone="${about.phone}"
                                                                    data-email="${about.email}"
                                                                    data-description="${about.description}">
                                                                <i class="fas fa-edit"></i> Edit
                                                            </button>
                                                            <button type="button" class="btn-action btn-delete" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#deleteModal"
                                                                    data-about-id="${about.about_id}">
                                                                <i class="fas fa-trash"></i> Delete
                                                            </button>
                                                        </div>
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

                <!-- Footer -->
                <footer class="pt-4">
                    <div class="w-full px-6 mx-auto">
                        <div class="flex flex-wrap items-center -mx-3 lg:justify-between">
                            <div class="w-full max-w-full px-3 mt-0 mb-6 shrink-0 lg:mb-0 lg:w-1/2 lg:flex-none">
                                <div class="text-sm leading-normal text-center text-slate-500 lg:text-left">
                                    ©
                                    <script>
                                        document.write(new Date().getFullYear() + ",");
                                    </script>
                                    made with <i class="fa fa-heart"></i> by
                                    <a href="javascript:;" class="font-semibold text-slate-700" target="_blank">Pet Clinic Team</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </main>
        
        <!-- Add Modal -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Add New About Us Information</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/manage-about-us" method="post" id="addForm">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Edit Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editModalLabel">Edit About Us Information</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/manage-about-us" method="post" id="editForm">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" id="edit_about_id" name="about_id">
                            
                            <div class="mb-3">
                                <label for="edit_address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="edit_address" name="address" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="edit_phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="edit_phone" name="phone" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="edit_email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="edit_email" name="email" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="edit_description" class="form-label">Description</label>
                                <textarea class="form-control" id="edit_description" name="description" rows="4" required></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Delete Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/manage-about-us" method="post" id="deleteForm">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" id="delete_about_id" name="about_id">
                            
                            <p>Are you sure you want to delete this information? This action cannot be undone.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- JavaScript Includes -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/plugins/perfect-scrollbar.min.js"></script>
        <script src="${pageContext.request.contextPath}/Presentation/js/argon-dashboard-tailwind.js?v=1.0.1"></script>
        
        <script>
            // Auto-hide toasts after 3 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const toasts = document.querySelectorAll('.toast');
                toasts.forEach(toast => {
                    setTimeout(() => {
                        toast.style.opacity = '0';
                        toast.style.transition = 'opacity 0.5s';
                        setTimeout(() => {
                            toast.remove();
                        }, 500);
                    }, 3000);
                });
                
                // Edit modal data population
                const editModal = document.getElementById('editModal');
                if (editModal) {
                    editModal.addEventListener('show.bs.modal', function(event) {
                        const button = event.relatedTarget;
                        
                        const aboutId = button.getAttribute('data-about-id');
                        const address = button.getAttribute('data-address');
                        const phone = button.getAttribute('data-phone');
                        const email = button.getAttribute('data-email');
                        const description = button.getAttribute('data-description');
                        
                        const modal = this;
                        modal.querySelector('#edit_about_id').value = aboutId;
                        modal.querySelector('#edit_address').value = address;
                        modal.querySelector('#edit_phone').value = phone;
                        modal.querySelector('#edit_email').value = email;
                        modal.querySelector('#edit_description').value = description;
                    });
                }
                
                // Delete modal data population
                const deleteModal = document.getElementById('deleteModal');
                if (deleteModal) {
                    deleteModal.addEventListener('show.bs.modal', function(event) {
                        const button = event.relatedTarget;
                        const aboutId = button.getAttribute('data-about-id');
                        
                        const modal = this;
                        modal.querySelector('#delete_about_id').value = aboutId;
                    });
                }
            });
        </script>
    </body>
</html>
