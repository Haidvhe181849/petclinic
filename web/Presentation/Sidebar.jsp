<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%-- SET ACTIVE CLASSES --%>
<c:set var="currentPage" value="${currentPage}"/>

<c:if test="${empty currentPage}">
    <c:set var="currentPage" value="" />
</c:if>
<%-- Set active class for each page --%>
<c:set var="dashboardActive" value="${currentPage eq 'dashboard' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="newsActive" value="${currentPage eq 'news' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="serviceActive" value="${currentPage eq 'service' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="medicineActive" value="${currentPage eq 'medicine' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="accountActive" value="${currentPage eq 'account' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="employeeActive" value="${currentPage eq 'employee' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="doctorActive" value="${currentPage eq 'doctor' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="animalActive" value="${currentPage eq 'animal' || currentPage eq 'breed' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="animalTypeActive" value="${currentPage eq 'animal' ? 'font-bold text-blue-500' : ''}" />
<c:set var="breedActive" value="${currentPage eq 'breed' ? 'font-bold text-blue-500' : ''}" />
<c:set var="bookingActive" value="${currentPage eq 'booking' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<c:set var="feedbackActive" value="${currentPage eq 'feedback' ? 'bg-blue-500/13 font-semibold text-slate-700 rounded-lg' : ''}" />
<a class="absolute w-full h-full top-0 left-0 dark:hidden min-h-75 overflow-hidden">
    <img src="${pageContext.request.contextPath}/Presentation/img/hero/hero2.png" class="w-full h-50 object-cover" />
</a>
<aside class="fixed top-0 left-0 z-990 xl:ml-6 xl:left-0 xl:translate-x-0
       max-w-64 w-64 h-screen bg-white dark:bg-slate-850
       shadow-xl rounded-2xl transition-transform duration-200 transform -translate-x-full xl:relative flex flex-col"
       aria-expanded="false">

    <div class="h-19">
        <a class="block px-8 py-6 m-0 text-sm whitespace-nowrap dark:text-white text-slate-700" href="${pageContext.request.contextPath}/Home">
            <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" class="inline h-full max-w-full transition-all duration-200 dark:hidden ease-nav-brand max-h-8" />
            <img src="${pageContext.request.contextPath}/Presentation/img/logo/logo.png" class="hidden h-full max-w-full transition-all duration-200 dark:inline ease-nav-brand max-h-8" />
        </a>
    </div>

    <hr class="h-px mt-0 bg-transparent bg-gradient-to-r from-transparent via-black/40 to-transparent dark:bg-gradient-to-r dark:from-transparent dark:via-white dark:to-transparent" />

    <div id="sidebar-scroll" class="flex flex-col overflow-y-auto px-2" style="height: calc(100vh - 5rem);">
        <ul class="flex flex-col pl-0 mb-0">
            <c:if test="${sessionScope.staff.roleId == 1}">
                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${dashboardActive}" 
                       href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-blue-500 ni ni-tv-2"></i>
                        </div>
                        <span class="ml-1">Dashboard</span>
                    </a>
                </li>

                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${accountActive}" 
                       href="${pageContext.request.contextPath}/account-management">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-red-600 ni ni-circle-08"></i>
                        </div>
                        <span class="ml-1">Account Managerment</span>
                    </a>
                </li>   

                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${employeeActive}" 
                       href="${pageContext.request.contextPath}/Employee?service=listEmployee">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-red-600 ni ni-single-02"></i>
                        </div>
                        <span class="ml-1">Employee Managerment</span>
                    </a>
                </li>

                <li class="mt-0.5 w-full">
                    <a href="javascript:void(0);" onclick="toggleDropdown('animalDropdown')" 
                       class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center justify-between whitespace-nowrap px-4 transition-colors ${animalActive}">
                        <div class="flex items-center">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="text-red-600 ni ni-world-2"></i>
                            </div>
                            <span class="ml-1">Quản lý Animal</span>
                        </div>
                        <i class="fas fa-chevron-down text-xs"></i>
                    </a>

                    <!-- dropdown items -->
                    <ul id="animalDropdown" class="hidden ml-12 mt-1">
                        <li class="mb-1">
                            <a href="${pageContext.request.contextPath}/Animal?service=listType"
                               class="block px-2 py-1 text-sm rounded hover:bg-gray-100 dark:hover:bg-slate-700 ${animalTypeActive}">
                                Animal Type
                            </a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/Breed?service=listBreed"
                               class="block px-2 py-1 text-sm rounded hover:bg-gray-100 dark:hover:bg-slate-700 ${breedActive}">
                                Breed
                            </a>
                        </li>
                    </ul>
                </li>
                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${feedbackActive}" 
                       href="${pageContext.request.contextPath}/feedback-management">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-red-600 ni ni-chat-round"></i>
                        </div>
                        <span class="ml-1">Feedback Managerment</span>
                    </a>
                </li>
            </c:if>

            <c:if test="${sessionScope.staff.roleId == 2}">
                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${newsActive}" 
                       href="${pageContext.request.contextPath}/News?service=listNews">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-orange-500 ni ni-bullet-list-67"></i>
                        </div>
                        <span class="ml-1">News Managerment</span>
                    </a>
                </li>


                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${serviceActive}" 
                       href="${pageContext.request.contextPath}/Service?service=listService">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-emerald-500 ni ni-delivery-fast"></i>
                        </div>
                        <span class="ml-1">Service Managerment</span>
                    </a>
                </li>

                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${medicineActive}" 
                       href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-cyan-500 ni ni-caps-small"></i>
                        </div>
                        <span class="ml-1">Medicine Managerment</span>
                    </a>
                </li>
                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${doctorActive}" 
                       href="${pageContext.request.contextPath}/DoctorManagerment?service=listDoctor">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-red-600 ni ni-single-02"></i>
                        </div>
                        <span class="ml-1">Doctor Managerment</span>
                    </a>
                </li>

                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${bookingActive}" 
                       href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-red-600 ni ni-calendar-grid-58"></i>
                        </div>
                        <span class="ml-1">Booking Managerment</span>
                    </a>
                </li>
                <li class="mt-0.5 w-full">
                    <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors ${feedbackActive}" 
                       href="${pageContext.request.contextPath}/feedback-management">
                        <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                            <i class="text-red-600 ni ni-chat-round"></i>
                        </div>
                        <span class="ml-1">Feedback Managerment</span>
                    </a>
                </li>
            </c:if>

            <li class="w-full mt-4">
                <h6 class="pl-6 ml-2 text-xs font-bold leading-tight uppercase dark:text-white opacity-60">Account pages</h6>
            </li>

            <li class="mt-0.5 w-full">
                <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="ProfileStaff">
                    <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                        <i class="relative top-0 text-sm leading-normal text-slate-700 ni ni-single-02"></i>
                    </div>
                    <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Profile</span>
                </a>
            </li>
            <li class="mt-0.5 w-full">
                <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="logout">
                    <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                        <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-collection"></i>
                    </div>
                    <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Sign Up</span>
                </a>
            </li>
        </ul>
    </div>
</aside>
<script>
    function toggleDropdown(id) {
        const dropdown = document.getElementById(id);
        if (dropdown.classList.contains('hidden')) {
            dropdown.classList.remove('hidden');
        } else {
            dropdown.classList.add('hidden');
        }
    }
</script>
