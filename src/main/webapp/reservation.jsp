<%--
  Created by IntelliJ IDEA.
  User: DuduŚ
  Date: 2016-12-11
  Time: 22:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl_PL">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>kennyS - centrum sportowe</title>
    <link href="https://fonts.googleapis.com/css?family=Audiowide" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css?family=Play" rel="stylesheet"/>
    <link rel="stylesheet" href="resources/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="resources/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="resources/css/style.css"/>
    <script src="resources/js/jquery.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="resources/js/script.js"></script>
    <script src="resources/js/scrollReveal.js"></script>
    <script src="resources/js/custom.js"></script>

</head>

<body>

<div class="navbar navbar-default navbar-fixed-top" style="background-color: white;">
    <div class="container">

        <div class="collapse navbar-collapse col-lg-3 col-md-3 navbar-left" style="height: 150px;">
            <ul class="nav navbar-nav ">
                <li><a href="/"><img src="resources/img/logo2.png"/></a></li>
            </ul>
        </div>

        <div class="col-lg-9 col-md-9 navbar-right" style="height: 130px;">
            <c:if test="${pageContext.request.userPrincipal.name == null}">
                <div class="col-lg-4 col-lg-offset-8" style="height: 55px; padding-top: 10px;  padding-left: 45px;">

                    <button id="userMenu1" class="btn btn-primary" type="button" style="background-color: #6666FF;">
                        <a href="/login" style="color: white"><span>Zaloguj się </span></a>
                    </button>
                    <button id="userMenu" class="btn btn-primary" type="button" style="background-color: #6666FF;">
                        <a href="/registration" style="color: white"><span>Zarejestruj się</span></a>
                    </button>
                </div>
            </c:if>
            <ul class="nav navbar-nav navbar-right">
                <sec:authorize access="hasRole('ROLE_USER')">
                    <c:url value="/logout" var="logoutUrl"/>
                    <form action="${logoutUrl}" method="post" id="logoutForm">
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                    </form>
                    <script>
                        function formSubmit() {
                            document.getElementById("logoutForm").submit();
                        }
                    </script>

                    <c:if test="${pageContext.request.userPrincipal.name != null}">
                        <ul class="nav navbar-nav navbar-right"
                            style="margin-right: 35px; padding-top: 10px; font-size: 17px;">
                            <li><a href="userProfile" style="color: black"><strong>Mój profil</strong></a></li>
                            <li style="padding-top: 5px;">
                                <ol class="breadcrumb" style="float: left;">
                                    <li class="active" style="color: black;">
                                        Witaj, ${pageContext.request.userPrincipal.name}</li>
                                    <li><a href="javascript:formSubmit()" style="color: black;"> Wyloguj</a></li>
                                </ol>
                            </li>
                        </ul>
                    </c:if>
                </sec:authorize>
            </ul>
            <div class="col-lg-12" style="height: 65px;">
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav nav-pills text-header  navbar-right">
                        <li role="presentation"><a href="/news">
                            <div style="color: black;">aktualności</div>
                        </a></li>
                        <li role="presentation"><a href="/priceList">
                            <div style="color: black;">cennik</div>
                        </a></li>
                        <li role="presentation"><a href="/offer">
                            <div style="color: black;">oferta</div>
                        </a></li>
                        <li role="presentation"><a href="/contact">
                            <div style="color: black;">kontakt</div>
                        </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="content-home" style="padding-top: 250px;">
    <div class="container">
        <div id="signupbox" class="col-md-10 col-md-offset-1"
             data-scrollreveal="enter left and move 300px over 1.33s">
            <div class="panel" style="border-color: #5151cc;">
                <div class="panel-heading" style="background-color: #a3a3ff;">
                    <div class="panel-title">Rezerwacja</div>

                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <form:form method="POST" name="reservationForm" modelAttribute="reservationForm"
                                   class="form-signin">
                        <table class="table table-condensed">
                            <thead>
                            <tr class="active">
                                <th>Obiekt sportowy</th>
                                <th>Dzień rezerwacji</th>
                                <th>Godzina rozpoczęcia</th>
                                <th>Godzina zakończenia</th>
                            </tr>
                            </thead>
                            <tbody style="background-color: white; ">
                            <tr style="padding-top: 25px;">
                                <th>${object.name}</th>
                                <th>
                                    <form:input type="text" path="dayOfReservation" id="datetimepicker"
                                                onchange="evaluatePrice()"/>
                                    </br>
                                    <form:errors path="dayOfReservation"/>

                                </th>
                                <th>
                                    <spring:bind path="hourOfReservation">
                                        <form:select path="hourOfReservation" id="hourOfReservation"
                                                     onchange="evaluatePrice()"
                                                     style="border-radius: 3px; border-width: 1px; font-size: 16px;">
                                            <option value="08:00">8:00</option>
                                            <option value="09:00">9:00</option>
                                            <option value="10:00">10:00</option>
                                            <option value="11:00">11:00</option>
                                            <option value="12:00">12:00</option>
                                            <option value="13:00">13:00</option>
                                            <option value="14:00">14:00</option>
                                            <option value="15:00">15:00</option>
                                            <option value="16:00">16:00</option>
                                            <option value="17:00">17:00</option>
                                            <option value="18:00">18:00</option>
                                            <option value="19:00">19:00</option>
                                            <option value="20:00">20:00</option>
                                            <option value="21:00">21:00</option>
                                        </form:select>
                                    </spring:bind>
                                </th>
                                <th>
                                    <spring:bind path="hourOfEndReservation">
                                        <form:select path="hourOfEndReservation" id="hourOfEndReservation"
                                                     onchange="evaluatePrice()"
                                                     style="border-radius: 3px; border-width: 1px; font-size: 16px;">
                                            <option value="09:00">9:00</option>
                                            <option value="10:00">10:00</option>
                                            <option value="11:00">11:00</option>
                                            <option value="12:00">12:00</option>
                                            <option value="13:00">13:00</option>
                                            <option value="14:00">14:00</option>
                                            <option value="15:00">15:00</option>
                                            <option value="16:00">16:00</option>
                                            <option value="17:00">17:00</option>
                                            <option value="18:00">18:00</option>
                                            <option value="19:00">19:00</option>
                                            <option value="20:00">20:00</option>
                                            <option value="21:00">21:00</option>
                                            <option value="22:00">22:00</option>
                                            ";
                                        </form:select>
                                        </br>
                                        <form:errors path="hourOfEndReservation"/>
                                    </spring:bind>
                                </th>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12 " style="padding-top: 30px; padding-bottom: 30px; text-align: left;">
                            <h4><strong>Podsumowanie:</strong></h4>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <spring:bind path="userId">
                        <form:hidden path="userId" value="${user.id}"/>
                    </spring:bind>


                    <div class="form-group">
                        <div class="col-lg-2">
                            <a href="/priceList"><img src="resources/img/left-arrow.png"></a>
                        </div>
                        <div class="col-lg-offset-7 col-lg-2">
                            <div style="margin-top: 5px" class="form-group">
                                <input type="submit" value="Zarezerwuj" class="btn btn-primary"
                                       style="background-color: #6666FF; width: 150px;">
                            </div>
                        </div>
                    </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/scrollReveal.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/custom.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</body>

</html>
