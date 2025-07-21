<%-- 
    Document   : Dashbroard
    Created on : Jun 20, 2025, 8:52:55 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/Presentation/img/apple-icon.png" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/Presentation/img/favicon.png" />
        <title>Dashboard - Pet Hospital</title>

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
        <div class="absolute w-full bg-blue-500 dark:hidden min-h-75"></div>
        <!-- sidenav  -->
        <jsp:include page="/Presentation/Sidebar.jsp" />

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
                            <li class="text-sm pl-2 capitalize leading-normal text-white before:float-left before:pr-2 before:text-white before:content-['/']" aria-current="page">Dashboard</li>
                        </ol>
                        <h6 class="mb-0 font-bold text-white capitalize">Dashboard</h6>
                    </nav>

                    <div class="flex items-center mt-2 grow sm:mt-0 sm:mr-6 md:mr-0 lg:flex lg:basis-auto">
                        <div class="flex items-center md:ml-auto md:pr-4">
                            <div class="relative flex flex-wrap items-stretch w-full transition-all rounded-lg ease">
                                <span class="text-sm ease leading-5.6 absolute z-50 -ml-px flex h-full items-center whitespace-nowrap rounded-lg rounded-tr-none rounded-br-none border border-r-0 border-transparent bg-transparent py-2 px-2.5 text-center font-normal text-slate-500 transition-all">
                                    <i class="fas fa-search"></i>
                                </span>
                                <input type="text" class="pl-9 text-sm focus:shadow-primary-outline ease w-1/100 leading-5.6 relative -ml-px block min-w-0 flex-auto rounded-lg border border-solid border-gray-300 dark:bg-slate-850 dark:text-white bg-white bg-clip-padding py-2 pr-3 text-gray-700 transition-all placeholder:text-gray-500 focus:border-blue-500 focus:outline-none focus:transition-shadow" placeholder="Type here..." />
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
            <!-- end Navbar -->

            <!-- cards -->
            <div class="w-full px-6 py-6 mx-auto">
                <!-- row 1 -->
                <div class="flex flex-wrap -mx-3">
                    <!-- card1 - Total Doctors -->
                    <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
                        <div class="relative flex flex-col min-w-0 break-words bg-white shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="flex-auto p-4">
                                <div class="flex flex-row -mx-3">
                                    <div class="flex-none w-2/3 max-w-full px-3">
                                        <div>
                                            <p class="mb-0 font-sans text-sm font-semibold leading-normal uppercase dark:text-white dark:opacity-60">Total Doctors</p>
                                            <h5 class="mb-2 font-bold dark:text-white">${totalDoctors}</h5>
                                            <p class="mb-0 dark:text-white dark:opacity-60">
                                                <span class="text-sm font-bold leading-normal text-emerald-500">Medical Staff</span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="px-3 text-right basis-1/3">
                                        <div class="inline-block w-12 h-12 text-center rounded-circle bg-gradient-to-tl from-blue-500 to-violet-500">
                                            <i class="ni leading-none ni-single-02 text-lg relative top-3.5 text-white"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- card2 - Total Services -->
                    <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
                        <div class="relative flex flex-col min-w-0 break-words bg-white shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="flex-auto p-4">
                                <div class="flex flex-row -mx-3">
                                    <div class="flex-none w-2/3 max-w-full px-3">
                                        <div>
                                            <p class="mb-0 font-sans text-sm font-semibold leading-normal uppercase dark:text-white dark:opacity-60">Total Services</p>
                                            <h5 class="mb-2 font-bold dark:text-white">${totalServices}</h5>
                                            <p class="mb-0 dark:text-white dark:opacity-60">
                                                <span class="text-sm font-bold leading-normal text-emerald-500">Available Treatments</span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="px-3 text-right basis-1/3">
                                        <div class="inline-block w-12 h-12 text-center rounded-circle bg-gradient-to-tl from-red-600 to-orange-600">
                                            <i class="ni leading-none ni-world text-lg relative top-3.5 text-white"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- card3 - Total Bookings -->
                    <div class="w-full max-w-full px-3 mb-6 sm:w-1/2 sm:flex-none xl:mb-0 xl:w-1/4">
                        <div class="relative flex flex-col min-w-0 break-words bg-white shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="flex-auto p-4">
                                <div class="flex flex-row -mx-3">
                                    <div class="flex-none w-2/3 max-w-full px-3">
                                        <div>
                                            <p class="mb-0 font-sans text-sm font-semibold leading-normal uppercase dark:text-white dark:opacity-60">Total Bookings</p>
                                            <h5 class="mb-2 font-bold dark:text-white">${totalBookings}</h5>
                                            <p class="mb-0 dark:text-white dark:opacity-60">
                                                <span class="text-sm font-bold leading-normal text-emerald-500">Appointments</span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="px-3 text-right basis-1/3">
                                        <div class="inline-block w-12 h-12 text-center rounded-circle bg-gradient-to-tl from-emerald-500 to-teal-400">
                                            <i class="ni leading-none ni-calendar-grid-58 text-lg relative top-3.5 text-white"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- card4 - Total Customers -->
                    <div class="w-full max-w-full px-3 sm:w-1/2 sm:flex-none xl:w-1/4">
                        <div class="relative flex flex-col min-w-0 break-words bg-white shadow-xl dark:bg-slate-850 dark:shadow-dark-xl rounded-2xl bg-clip-border">
                            <div class="flex-auto p-4">
                                <div class="flex flex-row -mx-3">
                                    <div class="flex-none w-2/3 max-w-full px-3">
                                        <div>
                                            <p class="mb-0 font-sans text-sm font-semibold leading-normal uppercase dark:text-white dark:opacity-60">Total Customers</p>
                                            <h5 class="mb-2 font-bold dark:text-white">${totalCustomers}</h5>
                                            <p class="mb-0 dark:text-white dark:opacity-60">
                                                <span class="text-sm font-bold leading-normal text-emerald-500">Pet Owners</span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="px-3 text-right basis-1/3">
                                        <div class="inline-block w-12 h-12 text-center rounded-circle bg-gradient-to-tl from-orange-500 to-yellow-500">
                                            <i class="ni leading-none ni-circle-08 text-lg relative top-3.5 text-white"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Revenue Summary cards -->
                <div class="flex flex-wrap mt-6 -mx-3">
                    <div class="w-full max-w-full px-3 mt-0 mb-6 lg:mb-0 lg:w-7/12 lg:flex-none">
                        <div class="border-black/12.5 dark:bg-slate-850 dark:shadow-dark-xl shadow-xl relative z-20 flex min-w-0 flex-col break-words rounded-2xl border-0 border-solid bg-white bg-clip-border">
                            <div class="border-black/12.5 mb-0 rounded-t-2xl border-b-0 border-solid p-6 pt-4 pb-0">
                                <div class="flex justify-between items-center">
                                    <div>
                                        <h6 class="capitalize dark:text-white">${chartTitle}</h6>
                                        <p class="mb-0 text-sm leading-normal dark:text-white dark:opacity-60">
                                            <i class="fa fa-arrow-up text-emerald-500"></i>
                                            <span class="font-semibold">Revenue Overview</span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="flex-auto p-4">
                                <div>
                                    <canvas id="revenue-chart" height="300"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="w-full max-w-full px-3 lg:w-5/12 lg:flex-none">
                        <div class="border-black/12.5 shadow-xl dark:bg-slate-850 dark:shadow-dark-xl relative flex min-w-0 flex-col break-words rounded-2xl border-0 border-solid bg-white bg-clip-border">
                            <div class="border-black/12.5 mb-0 rounded-t-2xl border-b-0 border-solid p-6">
                                <div class="flex justify-between items-center">
                                    <h6 class="capitalize dark:text-white">Revenue Statistics</h6>
                                    <form action="${pageContext.request.contextPath}/dashboard" method="get" class="flex space-x-2">
                                        <select name="period" class="form-select text-sm rounded-md border-gray-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-blue-200 focus:ring-opacity-50" onchange="this.form.submit()">
                                            <option value="week" ${selectedPeriod == 'week' ? 'selected' : ''}>Weekly</option>
                                            <option value="month" ${selectedPeriod == 'month' ? 'selected' : ''}>Monthly</option>
                                            <option value="year" ${selectedPeriod == 'year' ? 'selected' : ''}>Yearly</option>
                                        </select>
                                    </form>
                                </div>
                            </div>
                            <div class="flex-auto p-6 pb-4">
                                <div class="relative mb-8">
                                    <div class="flex mb-2 justify-between">
                                        <div>
                                            <h6 class="mb-0 text-sm leading-normal dark:text-white">
                                                ${selectedPeriod == 'week' ? '<strong>Weekly Revenue</strong>' : 'Weekly Revenue'}
                                            </h6>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 text-sm leading-normal dark:text-white">
                                                <fmt:formatNumber value="${weeklyRevenue}" type="currency" currencySymbol="$" />
                                            </h6>
                                        </div>
                                    </div>
                                    <div class="h-1 bg-gray-200 rounded-full overflow-hidden">
                                        <div class="h-1 bg-blue-500 rounded-full" style="width: 100%"></div>
                                    </div>
                                </div>
                                <div class="relative mb-8">
                                    <div class="flex mb-2 justify-between">
                                        <div>
                                            <h6 class="mb-0 text-sm leading-normal dark:text-white">
                                                ${selectedPeriod == 'month' ? '<strong>Monthly Revenue</strong>' : 'Monthly Revenue'}
                                            </h6>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 text-sm leading-normal dark:text-white">
                                                <fmt:formatNumber value="${monthlyRevenue}" type="currency" currencySymbol="$" />
                                            </h6>
                                        </div>
                                    </div>
                                    <div class="h-1 bg-gray-200 rounded-full overflow-hidden">
                                        <div class="h-1 bg-emerald-500 rounded-full" style="width: 100%"></div>
                                    </div>
                                </div>
                                <div class="relative">
                                    <div class="flex mb-2 justify-between">
                                        <div>
                                            <h6 class="mb-0 text-sm leading-normal dark:text-white">
                                                ${selectedPeriod == 'year' ? '<strong>Yearly Revenue</strong>' : 'Yearly Revenue'}
                                            </h6>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 text-sm leading-normal dark:text-white">
                                                <fmt:formatNumber value="${yearlyRevenue}" type="currency" currencySymbol="$" />
                                            </h6>
                                        </div>
                                    </div>
                                    <div class="h-1 bg-gray-200 rounded-full overflow-hidden">
                                        <div class="h-1 bg-orange-500 rounded-full" style="width: 100%"></div>
                                    </div>
                                </div>

                                <div class="mt-8 text-center">
                                    <div class="p-3 bg-gray-100 rounded-lg">
                                        <h6 class="mb-0 text-sm font-bold">
                                            Selected Period: 
                                            <span class="text-blue-500">
                                                ${selectedPeriod == 'week' ? 'Weekly' : selectedPeriod == 'month' ? 'Monthly' : 'Yearly'}
                                            </span>
                                        </h6>
                                        <p class="text-xs text-gray-600 mt-1 mb-0">
                                            Revenue: <fmt:formatNumber value="${filteredRevenue}" type="currency" currencySymbol="$" />
                                        </p>
                                    </div>
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
                                    © <script>document.write(new Date().getFullYear());</script>
                                    made with <i class="fa fa-heart"></i> by
                                    <a href="javascript:;" class="font-semibold text-slate-700" target="_blank">Pet Clinic Team</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
            <!-- end cards -->
        </main>
    </body>
    <!-- JavaScript for the chart -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
                                        document.addEventListener('DOMContentLoaded', function () {
                                            // Setup chart data
                                            var ctx = document.getElementById('revenue-chart').getContext('2d');

                                            // Get data passed from the servlet
                                            var labels = [
        <c:forEach var="label" items="${last7DaysLabels}" varStatus="status">
                                            "${label}"${!status.last ? ',' : ''}
        </c:forEach>
                                            ];

                                            var data = [
        <c:forEach var="value" items="${last7DaysData}" varStatus="status">
            ${value}${!status.last ? ',' : ''}
        </c:forEach>
                                            ];

                                            var chart = new Chart(ctx, {
                                                type: 'line',
                                                data: {
                                                    labels: labels,
                                                    datasets: [{
                                                            label: 'Daily Revenue ($)',
                                                            data: data,
                                                            backgroundColor: 'rgba(66, 135, 245, 0.2)',
                                                            borderColor: 'rgba(66, 135, 245, 1)',
                                                            borderWidth: 2,
                                                            pointBackgroundColor: 'rgba(66, 135, 245, 1)',
                                                            pointRadius: 4,
                                                            tension: 0.4,
                                                            fill: true
                                                        }]
                                                },
                                                options: {
                                                    responsive: true,
                                                    maintainAspectRatio: false,
                                                    plugins: {
                                                        legend: {
                                                            display: true,
                                                            position: 'top'
                                                        },
                                                        title: {
                                                            display: true,
                                                            text: 'Last 7 Days Revenue',
                                                            font: {
                                                                size: 16
                                                            }
                                                        },
                                                        tooltip: {
                                                            callbacks: {
                                                                label: function (context) {
                                                                    return '$' + context.parsed.y.toFixed(2);
                                                                }
                                                            }
                                                        }
                                                    },
                                                    scales: {
                                                        y: {
                                                            beginAtZero: true,
                                                            grid: {
                                                                drawBorder: false,
                                                                display: true,
                                                                drawOnChartArea: true,
                                                                drawTicks: false,
                                                                borderDash: [5, 5]
                                                            },
                                                            ticks: {
                                                                callback: function (value) {
                                                                    return '$' + value;
                                                                }
                                                            }
                                                        },
                                                        x: {
                                                            grid: {
                                                                drawBorder: false,
                                                                display: false,
                                                                drawOnChartArea: false,
                                                                drawTicks: false
                                                            }
                                                        }
                                                    }
                                                }
                                            });
                                        });
    </script>
    <!-- plugin for charts  -->
    <script src="${pageContext.request.contextPath}/Presentation/js/plugins/chartjs.min.js" async></script>
    <!-- plugin for scrollbar  -->
    <script src="${pageContext.request.contextPath}/Presentation/js/plugins/perfect-scrollbar.min.js" async></script>
    <!-- main script file  -->
    <script src="${pageContext.request.contextPath}/Presentation/js/argon-dashboard-tailwind.js?v=1.0.1" async></script>
</html>
