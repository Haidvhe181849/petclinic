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
        <a class="absolute w-full h-full top-0 left-0 dark:hidden min-h-75 overflow-hidden">
            <img src="${pageContext.request.contextPath}/Presentation/img/hero/hero2.png" class="w-full h-50 object-cover" />
        </a>



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
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Presentation/Dashbroard.jsp">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class=" relative top-0 text-sm leading-normal text-blue-500 ni ni-tv-2"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Dashboard</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors " href="${pageContext.request.contextPath}/News?service=listNews">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-orange-500 ni ni-bullet-list-67"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">News Managerment</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 dark:text-white dark:opacity-80 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap rounded-lg px-4" href="${pageContext.request.contextPath}/Service?service=listService">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center fill-current stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-emerald-500 ni ni-delivery-fast"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Service Managerment</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Medicine?service=getAllMedicines">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-caps-small"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Medicine Managerment</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/account-management">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-circle-08"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Account Managerment</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Presentation/Medicine.jsp">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-single-02"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Employee Managerment</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/Presentation/Medicine.jsp">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-world-2"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Pet Managerment</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 bg-blue-500/13 dark:text-white dark:opacity-80 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap rounded-lg px-4 font-semibold text-slate-700 transition-colors" href="${pageContext.request.contextPath}/ConfirmBooking?service=listBooking">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center fill-current stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-emerald-500 ni ni-delivery-fast"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Booking Managerment</span>
                        </a>
                    </li>
                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="${pageContext.request.contextPath}/feedback-management">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-red-600 ni ni-calendar-grid-58"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Feedback Managerment</span>
                        </a>
                    </li>

                    <li class="w-full mt-4">
                        <h6 class="pl-6 ml-2 text-xs font-bold leading-tight uppercase dark:text-white opacity-60">Account pages</h6>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="../pages/profile.html">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-slate-700 ni ni-single-02"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Profile</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="../pages/sign-in.html">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-orange-500 ni ni-single-copy-04"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Sign In</span>
                        </a>
                    </li>

                    <li class="mt-0.5 w-full">
                        <a class="py-2.7 text-sm ease-nav-brand my-0 mx-2 flex items-center whitespace-nowrap px-4 transition-colors dark:text-white dark:opacity-80" href="../pages/sign-up.html">
                            <div class="mr-2 flex h-8 w-8 items-center justify-center rounded-lg bg-center stroke-0 text-center xl:p-2.5">
                                <i class="relative top-0 text-sm leading-normal text-cyan-500 ni ni-collection"></i>
                            </div>
                            <span class="ml-1 duration-300 opacity-100 pointer-events-none ease">Sign Up</span>
                        </a>
                    </li>
                </ul>
            </div>           
        </aside>

        <main class="relative overflow-y-auto xl:ml-68 rounded-xl" style="height: calc(100vh - 64px);">

            <!-- Navbar -->
            <nav class="relative flex flex-wrap items-center justify-between px-0 py-2 mx-6 transition-all ease-in shadow-none duration-250 rounded-2xl lg:flex-nowrap lg:justify-start" navbar-main navbar-scroll="false">
                <div class="flex items-center justify-between w-full px-4 py-1 mx-auto flex-wrap-inherit">
                    <nav>
                        <!-- breadcrumb -->
                        <ol class="flex flex-wrap pt-1 mr-12 bg-transparent rounded-lg sm:mr-16">
                            <li class="text-sm leading-normal">
                                <a class="text-black opacity-50" href="${pageContext.request.contextPath}/Home">Home</a>
                            </li>
                            <!--                            <li class="text-sm pl-2 capitalize leading-normal text-black before:float-left before:pr-2 before:text-white before:content-['/']" aria-current="page">Tables</li>-->
                        </ol>

                    </nav>

                    <div class="flex items-center mt-2 grow sm:mt-0 sm:mr-6 md:mr-0 lg:flex lg:basis-auto">
                        <form action="${pageContext.request.contextPath}/ConfirmBooking" method="get" class="flex items-center md:ml-auto md:pr-4">
                            <input type="hidden" name="service" value="blist">
                            <input type="hidden" name="submit" value="search">
                            <div class="relative flex flex-wrap items-stretch w-full transition-all rounded-lg ease">
                                <button type="submit" class="text-sm ease leading-5.6 absolute z-50 -ml-px flex h-full items-center whitespace-nowrap rounded-lg rounded-tr-none rounded-br-none border border-r-0 border-transparent bg-transparent py-2 px-2.5 text-center font-normal text-slate-500 transition-all">
                                    <i class="fas fa-search"></i>
                                </button>
                                <input 
                                    type="text" 
                                    name="bookingId"
                                    value="${param.bookingId != null ? param.bookingId : ''}"
                                    class="pl-9 text-sm focus:shadow-primary-outline ease w-1/100 leading-5.6 relative -ml-px block min-w-0 flex-auto rounded-lg border border-solid border-gray-300 dark:bg-slate-850 dark:text-white bg-white bg-clip-padding py-2 pr-3 text-gray-700 transition-all placeholder:text-gray-500 focus:border-blue-500 focus:outline-none focus:transition-shadow" 
                                    placeholder="Search booking by id..." 
                                    />
                            </div>
                        </form>


                        <ul class="flex flex-row justify-end pl-0 mb-0 list-none md-max:w-full">                        
                            <li class="flex items-center">
                                <a href="../pages/sign-in.html" class="block px-0 py-2 text-sm font-semibold text-white transition-all ease-nav-brand">
                                    <i class="fa fa-user sm:mr-1"></i>
                                    <span class="hidden sm:inline">Sign In</span>
                                </a>
                            </li>
                            <li class="flex items-center pl-4 xl:hidden">
                                <a href="javascript:;" class="block p-0 text-sm text-white transition-all ease-nav-brand" sidenav-trigger>
                                    <div class="w-4.5 overflow-hidden">
                                        <i class="ease mb-0.75 relative block h-0.5 rounded-sm bg-white transition-all"></i>
                                        <i class="ease mb-0.75 relative block h-0.5 rounded-sm bg-white transition-all"></i>
                                        <i class="ease relative block h-0.5 rounded-sm bg-white transition-all"></i>
                                    </div>
                                </a>
                            </li>
                            <li class="flex items-center px-4">
                                <a href="javascript:;" class="p-0 text-sm text-white transition-all ease-nav-brand">
                                    <i fixed-plugin-button-nav class="cursor-pointer fa fa-cog"></i>
                                    <!-- fixed-plugin-button-nav  -->
                                </a>
                            </li>

                            <!-- notifications -->

                            <li class="relative flex items-center pr-2">
                                <p class="hidden transform-dropdown-show"></p>
                                <a href="javascript:;" class="block p-0 text-sm text-white transition-all ease-nav-brand" dropdown-trigger aria-expanded="false">
                                    <i class="cursor-pointer fa fa-bell"></i>
                                </a>

                                <ul dropdown-menu class="text-sm transform-dropdown before:font-awesome before:leading-default dark:shadow-dark-xl before:duration-350 before:ease lg:shadow-3xl duration-250 min-w-44 before:sm:right-8 before:text-5.5 pointer-events-none absolute right-0 top-0 z-50 origin-top list-none rounded-lg border-0 border-solid border-transparent dark:bg-slate-850 bg-white bg-clip-padding px-2 py-4 text-left text-slate-500 opacity-0 transition-all before:absolute before:right-2 before:left-auto before:top-0 before:z-50 before:inline-block before:font-normal before:text-white before:antialiased before:transition-all before:content-['\f0d8'] sm:-mr-6 lg:absolute lg:right-0 lg:left-auto lg:mt-2 lg:block lg:cursor-pointer">
                                    <!-- add show class on dropdown open js -->
                                    <li class="relative mb-2">
                                        <a class="dark:hover:bg-slate-900 ease py-1.2 clear-both block w-full whitespace-nowrap rounded-lg bg-transparent px-4 duration-300 hover:bg-gray-200 hover:text-slate-700 lg:transition-colors" href="javascript:;">
                                            <div class="flex py-1">
                                                <div class="my-auto">
                                                    <img src="../assets/img/team-2.jpg" class="inline-flex items-center justify-center mr-4 text-sm text-white h-9 w-9 max-w-none rounded-xl" />
                                                </div>
                                                <div class="flex flex-col justify-center">
                                                    <h6 class="mb-1 text-sm font-normal leading-normal dark:text-white"><span class="font-semibold">New message</span> from Laur</h6>
                                                    <p class="mb-0 text-xs leading-tight text-slate-400 dark:text-white/80">
                                                        <i class="mr-1 fa fa-clock"></i>
                                                        13 minutes ago
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>

                                    <li class="relative mb-2">
                                        <a class="dark:hover:bg-slate-900 ease py-1.2 clear-both block w-full whitespace-nowrap rounded-lg px-4 transition-colors duration-300 hover:bg-gray-200 hover:text-slate-700" href="javascript:;">
                                            <div class="flex py-1">
                                                <div class="my-auto">
                                                    <img src="../assets/img/small-logos/logo-spotify.svg" class="inline-flex items-center justify-center mr-4 text-sm text-white bg-gradient-to-tl from-zinc-800 to-zinc-700 dark:bg-gradient-to-tl dark:from-slate-750 dark:to-gray-850 h-9 w-9 max-w-none rounded-xl" />
                                                </div>
                                                <div class="flex flex-col justify-center">
                                                    <h6 class="mb-1 text-sm font-normal leading-normal dark:text-white"><span class="font-semibold">New album</span> by Travis Scott</h6>
                                                    <p class="mb-0 text-xs leading-tight text-slate-400 dark:text-white/80">
                                                        <i class="mr-1 fa fa-clock"></i>
                                                        1 day
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>

                                    <li class="relative">
                                        <a class="dark:hover:bg-slate-900 ease py-1.2 clear-both block w-full whitespace-nowrap rounded-lg px-4 transition-colors duration-300 hover:bg-gray-200 hover:text-slate-700" href="javascript:;">
                                            <div class="flex py-1">
                                                <div class="inline-flex items-center justify-center my-auto mr-4 text-sm text-white transition-all duration-200 ease-nav-brand bg-gradient-to-tl from-slate-600 to-slate-300 h-9 w-9 rounded-xl">
                                                    <svg width="12px" height="12px" viewBox="0 0 43 36" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                                    <title>credit-card</title>
                                                    <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                    <g transform="translate(-2169.000000, -745.000000)" fill="#FFFFFF" fill-rule="nonzero">
                                                    <g transform="translate(1716.000000, 291.000000)">
                                                    <g transform="translate(453.000000, 454.000000)">
                                                    <path class="color-background" d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z" opacity="0.593633743"></path>
                                                    <path class="color-background" d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"></path>
                                                    </g>
                                                    </g>
                                                    </g>
                                                    </g>
                                                    </svg>
                                                </div>
                                                <div class="flex flex-col justify-center">
                                                    <h6 class="mb-1 text-sm font-normal leading-normal dark:text-white">Payment successfully completed</h6>
                                                    <p class="mb-0 text-xs leading-tight text-slate-400 dark:text-white/80">
                                                        <i class="mr-1 fa fa-clock"></i>
                                                        2 days
                                                    </p>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <div class="w-full px-6 py-6 mx-auto">
                <!-- table 1 -->

                <div class="flex flex-wrap -mx-3">
                    <div class="flex-none w-full max-w-full px-3">
                        <div class="relative flex flex-col min-w-0 mb-6 break-words bg-white border-0 border-transparent border-solid shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="p-6 pb-0 mb-0 border-b-0 border-b-solid rounded-t-2xl border-b-transparent">
                                <div class="flex items-center justify-between">
                                    <h6 class="dark:text-white text-lg font-semibold">Booking Management</h6>
                                    <div class="flex gap-2 items-center">
                                        <!-- Nút Sort -->
                                        <form action="${pageContext.request.contextPath}/ConfirmBooking" method="get" class="flex items-center ml-2">
                                            <input type="hidden" name="service" value="blist" />
                                            <select name="order" class="..." onchange="this.form.submit()" type="submit">
                                                <option value="">Sort by time</option>
                                                <option value="desc" <c:if test="${order == 'desc'}">selected</c:if>>Newest</option>
                                                <option value="asc" <c:if test="${order == 'asc'}">selected</c:if>>Oldest</option>
                                                </select>
                                            </form>


                                            <!-- Nút All -->
                                            <form action="${pageContext.request.contextPath}/ConfirmBooking" method="get">
                                            <input type="hidden" name="service" value="blist" />
                                            <button type="submit" class="bg-blue-500 text-white px-3 py-1 text-sm rounded hover:bg-blue-600 transition-all">
                                                All
                                            </button>
                                        </form>
                                    </div>
                                </div>



                            </div>
                            <div class="flex-auto px-0 pt-0 pb-2">
                                <div class="p-0 overflow-x-auto">
                                    <table class="items-center w-full mb-0 align-top border-collapse dark:border-white/40 text-slate-500">
                                        <thead class="align-bottom">
                                            <tr>
                                        <thead>
                                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Booking ID</th>
                                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Customer</th>
                                        <th class="px-6 py-3 font-bold text-left uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Pet</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Type</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Service</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Doctor</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Booking Time</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Status</th>
                                        <th class="px-6 py-3 font-bold text-center uppercase align-middle bg-transparent border-b border-collapse shadow-none dark:border-white/40 dark:text-white text-xxs border-b-solid tracking-none whitespace-nowrap text-slate-400 opacity-70">Accept</th>
                                        <th class="px-6 py-3 font-semibold capitalize align-middle bg-transparent border-b border-collapse border-solid shadow-none dark:border-white/40 dark:text-white tracking-none whitespace-nowrap text-slate-400 opacity-70">Actions</th>
                                        </tr>
                                        </thead>


                                        <tbody>
                                            <c:forEach var="b" items="${blist}">
                                                <tr>
                                                    <!-- Booking ID -->
                                                    <td>
                                                        <c:out value="${b.bookingId}" />
                                                    </td>

                                                    <!-- Customer Name -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-left text-black">
                                                        <c:out value="${b.customerName}" />
                                                    </td>

                                                    <!-- Pet Name -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.petName}" />
                                                    </td>

                                                    <!-- Pet Type -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.petType}" />
                                                    </td>

                                                    <!-- Service Name -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.serviceName}" />
                                                    </td>

                                                    <!-- Doctor Name -->
                                                    <td class="...">
                                                        <c:choose>
                                                            <c:when test="${not empty b.employeeName}">
                                                                <c:out value="${b.employeeName}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                Not selected yet
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                    <!-- Booking Time -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <fmt:formatDate value="${b.bookingTime}" pattern="yyyy-MM-dd HH:mm" />
                                                    </td>

                                                    <!-- Status -->
                                                    <td class="p-2 align-middle bg-transparent border-b dark:border-white/40 text-sm text-center text-black">
                                                        <c:out value="${b.status}" />
                                                    </td>

                                                    <!-- Accept -->
                                                    <td class="text-center">
                                                        <form action="${pageContext.request.contextPath}/ConfirmBooking" method="post">
                                                            <input type="hidden" name="service" value="updateStatus" />
                                                            <input type="hidden" name="bookingId" value="${b.bookingId}" />

                                                            <select name="status"
                                                                    class="text-sm rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 p-1 bg-white dark:bg-slate-800 dark:text-white"
                                                                    onchange="handleStatusChange(this, '${b.bookingId}')">
                                                                <option value="Confirmed">Choose Status</option>
                                                                <c:if test="${b.status eq 'Pending' || b.status eq 'Processing Cancel'}">
                                                                    <option value="Confirmed">Confirmed</option>
                                                                    <option value="Failed">Failed</option>
                                                                </c:if>

                                                                <c:if test="${b.status ne 'Pending' && b.status ne 'Processing Cancel'}">
                                                                    <option value="${b.status}" selected>${b.status}</option>
                                                                </c:if>

                                                            </select>

                                                            <!-- Hiện input nhập lý do khi chọn Failed -->
                                                            <div id="cancelReasonDiv-${b.bookingId}" style="display:none; margin-top: 5px;">
                                                                <input type="text" name="cancelReason" placeholder="Enter cancel reason"
                                                                       class="text-sm p-1 rounded border border-red-400 w-full" />
                                                            </div>
                                                        </form>
                                                    </td>
                                                    <!-- Actions -->
                                                    <td class="text-center">
                                                        <a href="ConfirmBooking?service=bookingDetail&bookingId=${b.bookingId}"
                                                           class="text-blue-600 hover:text-blue-800"
                                                           title="Xem chi tiết">
                                                            <i class="fa fa-eye"></i>
                                                        </a>

                                                        <!-- Delete -->
                                                        <form action="ConfirmBooking" method="post" style="display:inline;" 
                                                              onsubmit="return confirm('Bạn có chắc chắn muốn xoá booking này không?');">
                                                            <input type="hidden" name="service" value="deleteBooking"/>
                                                            <input type="hidden" name="bookingId" value="${b.bookingId}"/>
                                                            <button type="submit" class="text-red-600 hover:text-red-800" title="Xoá">
                                                                <i class="fa fa-trash"></i>
                                                            </button>
                                                        </form>
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
            <div id="failStatusModal" class="modal fade" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/ConfirmBooking" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title">Cancel Reason</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>

                            <div class="modal-body">
                                <input type="hidden" name="service" value="updateStatus" />
                                <input type="hidden" name="bookingId" />
                                <input type="hidden" name="status" />
                                <div class="mb-3">
                                    <label for="cancelReason" class="form-label">Reason for Cancellation</label>
                                    <textarea name="cancelReason" class="form-control" required></textarea>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-danger">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Booking Detail Modal -->
            <c:if test="${not empty bookingDetail}">
                <div class="mt-6 p-6 rounded-lg border bg-white shadow-md text-slate-700 dark:bg-slate-800 dark:text-white">
                    <h2 class="text-xl font-bold mb-4">Booking Detail Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">

                        <div><strong>Booking ID:</strong> ${bookingDetail.bookingId}</div>
                        <div><strong>Customer Name:</strong> ${bookingDetail.customerName}</div>
                        <div><strong>Phone Number:</strong> ${bookingDetail.customerPhone}</div>
                        <div><strong>Email:</strong> ${bookingDetail.customerEmail}</div>
                        <div><strong>Pet Name:</strong> ${bookingDetail.petName}</div>
                        <div><strong>Breed:</strong> ${bookingDetail.breed}</div>
                        <div><strong>Pet Type:</strong> ${bookingDetail.petType}</div>
                        <div><strong>Service:</strong> ${bookingDetail.serviceName}</div>
                        <div><strong>Doctor:</strong> ${bookingDetail.employeeName}</div>
                        <div><strong>Booking Time:</strong> 
                            <fmt:formatDate value="${bookingDetail.bookingTime}" pattern="yyyy-MM-dd HH:mm" />
                        </div>
                        <div><strong>Note:</strong> ${bookingDetail.note}</div>
                        <div><strong>Status:</strong> ${bookingDetail.status}</div>

                        <c:if test="${bookingDetail.status eq 'Failed'}">
                            <div class="text-red-600 col-span-2"><strong>Cancel Reason:</strong> ${bookingDetail.cancelReason}</div>
                        </c:if>

                        <c:if test="${bookingDetail.actualCheckinTime != null}">
                            <div class="text-green-600 col-span-2"><strong>Actual Check-in:</strong> 
                                <fmt:formatDate value="${bookingDetail.actualCheckinTime}" pattern="yyyy-MM-dd HH:mm" />
                            </div>
                        </c:if>

                    </div>
                </div>
            </c:if>








        </main>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <c:if test="${not empty bookingDetail}">
            <script>
                    $(document).ready(function () {
                        $("#BookingDetailModal").modal("show");

                        $("#BookingDetailModal input[name='bookingId']").val("${bookingDetail.bookingId}");
                        $("#BookingDetailModal input[name='customerName']").val("${bookingDetail.customerName}");
                        $("#BookingDetailModal input[name='customerPhone']").val("${bookingDetail.customerPhone}");
                        $("#BookingDetailModal input[name='customerEmail']").val("${bookingDetail.customerEmail}");
                        $("#BookingDetailModal input[name='petName']").val("${bookingDetail.petName}");
                        $("#BookingDetailModal input[name='petType']").val("${bookingDetail.petType}");
                        $("#BookingDetailModal input[name='breed']").val("${bookingDetail.breed}");
                        $("#BookingDetailModal input[name='serviceName']").val("${bookingDetail.serviceName}");
                        $("#BookingDetailModal input[name='employeeName']").val("${bookingDetail.employeeName}");
                        $("#BookingDetailModal input[name='bookingTime']").val("${bookingDetail.bookingTime}");
                        $("#BookingDetailModal input[name='status']").val("${bookingDetail.status}");
                        $("#BookingDetailModal input[name='actualCheckinTime']").val("${bookingDetail.actualCheckinTime}");
                        $("#BookingDetailModal textarea[name='cancelReason']").val("${bookingDetail.cancelReason}");
                        $("#BookingDetailModal textarea[name='note']").val("${bookingDetail.note}");
                    });

                    if ("${bookingDetail.status}" === "Failed") {
                        $("textarea[name='cancelReason']").closest(".mb-3").show();
                    } else {
                        $("textarea[name='cancelReason']").closest(".mb-3").hide();
                    }

            </script>
        </c:if>


        <script>
            function handleStatusChange(selectElement, bookingId) {
                var selectedValue = selectElement.value;

                if (selectedValue === "Failed") {
                    // Gán giá trị vào modal để biết booking nào đang sửa
                    $('#failStatusModal input[name="bookingId"]').val(bookingId);
                    $('#failStatusModal input[name="status"]').val(selectedValue);

                    // Hiện modal để nhập lý do
                    $('#failStatusModal').modal('show');
                } else {
                    // Tự động submit với các status khác
                    selectElement.form.submit();
                }
            }
        </script>

        <script>
            function handleStatusChange(selectElement, bookingId) {
                const selectedValue = selectElement.value;

                // Ẩn hoặc hiện div lý do nếu đang dùng inline div
                const reasonDiv = document.getElementById('cancelReasonDiv-' + bookingId);
                if (reasonDiv) {
                    reasonDiv.style.display = (selectedValue === 'Failed') ? 'block' : 'none';
                }

                if (selectedValue === "Failed") {
                    $('#failStatusModal input[name="bookingId"]').val(bookingId);
                    $('#failStatusModal input[name="status"]').val(selectedValue);
                    $('#failStatusModal').modal('show');
                } else {
                    // Submit form ngay nếu chọn Confirm
                    selectElement.form.submit();
                }
            }

        </script>



        <script>
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
    </body>


</html>
