<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Employee Feedback Content (Fragment for AJAX loading) -->
<div class="feedback-container">
    <c:if test="${empty feedbackList}">
        <div class="alert alert-info text-center">
            <i class="fas fa-info-circle me-2"></i>
            No feedback available for this employee.
        </div>
    </c:if>

    <c:if test="${not empty feedbackList}">
        <div class="row">
            <c:forEach var="feedback" items="${feedbackList}">
                <div class="col-12 mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div class="d-flex align-items-center">
                                    <div class="avatar-circle me-3">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 fw-bold">${feedback.userName}</h6>
                                        <small class="text-muted">${feedback.userEmail}</small>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <div class="rating-stars mb-1">
                                        <c:forEach begin="1" end="5" var="i">
                                            <i class="fas fa-star ${i <= feedback.rating ? 'text-warning' : 'text-muted'}"></i>
                                        </c:forEach>
                                        <span class="ms-2 text-muted">(${feedback.rating}/5)</span>
                                    </div>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${feedback.rateTime}" pattern="dd/MM/yyyy HH:mm"/>
                                    </small>
                                </div>
                            </div>
                            
                            <div class="feedback-content">
                                <p class="mb-0">${feedback.comment}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- Statistics Summary -->
        <div class="mt-4">
            <div class="card bg-light border-0">
                <div class="card-body text-center">
                    <div class="row">
                        <div class="col-4">
                            <h5 class="mb-0 text-primary">${fn:length(feedbackList)}</h5>
                            <small class="text-muted">Total Reviews</small>
                        </div>
                        <div class="col-4">
                            <c:set var="totalRating" value="0"/>
                            <c:forEach var="feedback" items="${feedbackList}">
                                <c:set var="totalRating" value="${totalRating + feedback.rating}"/>
                            </c:forEach>
                            <c:set var="averageRating" value="${totalRating / fn:length(feedbackList)}"/>
                            <h5 class="mb-0 text-warning">
                                <fmt:formatNumber value="${averageRating}" pattern="#.#"/>
                            </h5>
                            <small class="text-muted">Average Rating</small>
                        </div>
                        <div class="col-4">
                            <c:set var="excellentCount" value="0"/>
                            <c:forEach var="feedback" items="${feedbackList}">
                                <c:if test="${feedback.rating >= 4}">
                                    <c:set var="excellentCount" value="${excellentCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            <h5 class="mb-0 text-success">
                                <fmt:formatNumber value="${(excellentCount / fn:length(feedbackList)) * 100}" pattern="#"/>%
                            </h5>
                            <small class="text-muted">Excellent (4-5★)</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<style>
    .feedback-container {
        max-height: 500px;
        overflow-y: auto;
        padding: 15px;
    }
    
    .avatar-circle {
        width: 40px;
        height: 40px;
        background: linear-gradient(45deg, #007bff, #0056b3);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 18px;
    }
    
    .rating-stars {
        font-size: 14px;
    }
    
    .feedback-content {
        background: #f8f9fa;
        padding: 12px;
        border-radius: 8px;
        border-left: 4px solid #007bff;
    }
    
    .card {
        transition: transform 0.2s ease-in-out;
        border-radius: 12px;
    }
    
    .card:hover {
        transform: translateY(-2px);
    }
    
    .feedback-container::-webkit-scrollbar {
        width: 6px;
    }
    
    .feedback-container::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }
    
    .feedback-container::-webkit-scrollbar-thumb {
        background: #888;
        border-radius: 10px;
    }
    
    .feedback-container::-webkit-scrollbar-thumb:hover {
        background: #555;
    }
</style>

