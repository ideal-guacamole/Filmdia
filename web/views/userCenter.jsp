<%--
  Created by IntelliJ IDEA.
  User: Ferriswheel
  Date: 2017/5/16
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<!-- Head -->
<head>
    <title>User Center · Filmdia</title>
    <!-- Meta-Tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="keywords"
          content="Premier Realty a Responsive Web Template, Bootstrap Web Templates, Flat Web Templates, Android Compatible Web Template, Smartphone Compatible Web Template, Free Webdesigns for Nokia, Samsung, LG, Sony Ericsson, Motorola Web Design">
    <script type="application/x-javascript"> addEventListener("load", function () {
        setTimeout(hideURLbar, 0);
    }, false);

    function hideURLbar() {
        window.scrollTo(0, 1);
    } </script>
    <!-- //Meta-Tags -->
    <!-- Custom-Theme-Files -->
    <link rel="stylesheet" href="../css/bootstrap.min.css" type="text/css" media="all">
    <link rel="stylesheet" href="../css/style.css" type="text/css" media="all">
    <!-- //Custom-Theme-Files -->
    <!-- Web-Fonts -->
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" type="text/css">
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Montserrat:400,700" type="text/css">
    <!-- //Web-Fonts -->
    <!-- Default-JavaScript-File -->
    <script type="text/javascript" src="../js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>


    <!-- Own css and js-->
    <script type="text/javascript" src="../js/jquery.min.js"></script>

    <!-- Star css and js -->
    <!-- <script type="text/javascript" src="../js/jquery.js"></script> -->
    <!-- script type="text/javascript" src="jquery.rater.js"></script -->
    <!-- 	<script type="text/javascript" src="../js/jquery.rater.packed.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/rater.css" media="all" />  -->

    <!--Pagination css-->
    <link rel="stylesheet" href="../css/pagi3.css" type="text/css" media="all">
    <!-- Button css -->
    <link rel="stylesheet" href="../css/button.css" type="text/css" media="all">
    <!-- Own css -->
    <link rel="stylesheet" href="../css/adminUI.css" type="text/css" media="all">
    <link rel="stylesheet" href="../css/library.css" type="text/css">
    <link rel="stylesheet" href="../css/user.css">
</head>
<!-- //Head -->
<!-- Body -->
<body>
<!-- Header -->
<div class="header">
    <!-- Top-Bar -->
    <div class="top-bar w3-1">
        <div class="container">
            <div class="header-nav w3-agileits-1">
                <nav class="navbar navbar-default">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                                data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <h1><a class="navbar-brand" href="../index.jsp"><img src="../images/logo2.png"
                                                                             style="top:-65px;"></a></h1>
                    </div>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav ">
                            <li><a href="../index.jsp">Home</a></li>
                            <li><a href="library.jsp">Library</a></li>
                            <li><a href="details.jsp">Statistic</a></li>
                            <li><a href="predict.jsp">Predict</a></li>
                        </ul>
                        <div class="search-box">
                            <div id="sb-search" class="sb-search">
                                <form>
                                    <input id="searchField" class="sb-search-input"
                                           placeholder="Enter your search term..." type="search"
                                           name="search" autocomplete="off" value=""/>
                                    <input type="text" name="notautosubmit" style="display:none"/>
                                    <input id="searchBtn" class="sb-search-submit" type="button" value=""/>
                                    <span class="sb-icon-search"> </span>
                                </form>
                            </div>
                        </div>
                        <div id="suggestionResults">
                        </div>
                        <script>
                            var searchField = document.getElementById('searchField');
                            var divSuggestionResults = document.getElementById('suggestionResults');
                            searchField.onclick = getResults;
                            searchField.onkeyup = getResults;
                            document.body.onclick = function () {
                                divSuggestionResults.style.display = 'none';
                            };

                            function getResults() {
                                var searchMsg = searchField.value;
                                var aFilm = null;
                                var innerHtmlTemp = '';
                                if (searchMsg !== '') {
                                    divSuggestionResults.style.display = 'block';
                                    $.ajax({
                                        type: 'post',
                                        url: '/film/getFilmsByName',
                                        contentType: 'application/json;charset=utf-8',
                                        data: searchMsg,
                                        success: function (data) {
                                            $.each(data, function (i, item) {
                                                if (i < 6) {
                                                    var url = '../views/details.jsp';
                                                    url = setQueryString(url, 'filmID', item.filmID);
                                                    url = setQueryString(url, 'imdb_filmID', item.imdb_filmID);
                                                    var tagLine = item.tagLine ? item.tagLine : 'No tagline now...';
                                                    aFilm = '<a href=' + url + '><img src=' + item.posterURL +
                                                        '/><div class="suggestionResultsLabel"><span class="title">'
                                                        + item.name + '</span><div class="summary">' + tagLine +
                                                        '</div></div></a>';
                                                    innerHtmlTemp += aFilm;
                                                }
                                            });
                                            divSuggestionResults.innerHTML = innerHtmlTemp;
                                            var aArr = divSuggestionResults.getElementsByTagName('a');
                                            for (var i = 0; i < aArr.length; i++) {
                                                aArr[i].onmouseover = function () {
                                                    this.className = 'highlight';
                                                };
                                                aArr[i].onmouseout = function () {
                                                    this.className = '';
                                                };
                                                aArr[i].onclick = function () {
                                                    divSuggestionResults.style.display = 'none';
                                                }
                                            }
                                        }
                                    });

                                }
                                else {
                                    divSuggestionResults.style.display = 'none';
                                }

                            }
                        </script>
                        <ul class="user-manage">
                            <img id="userCenter" src="../images/Center.png">
                            <div id="userUnderBox">
                                <div style="text-indent:0;text-align: center">Hello, <span>xxx</span>!</div>
                                <ul>
                                    <li><img src="../images/userCenter.png"/><a href="userCenter.jsp">User
                                        Center</a></li>
                                    <li><img src="../images/exit.png"/><a href="" onclick="signOut()">Sign Out</a></li>
                                </ul>
                            </div>
                        </ul>
                    </div><!-- /navbar-collapse -->
                    <!-- search-scripts -->
                    <script src="../js/classie.js"></script>
                    <script src="../js/uisearch.js"></script>
                    <script>
                        new UISearch(document.getElementById('sb-search'));
                    </script>
                    <!-- //search-scripts -->
                </nav>
            </div>
        </div>
    </div>

    <!-- //Slider -->
</div>
<!-- //Header -->
<div class="banner" style="height: 50px;">

</div>

<div class="container2">

    <div class="Tab">

        <div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
            <script src="../js/easyResponsiveTabs.js" type="text/javascript"></script>
            <script type="text/javascript">
                $(document).ready(function () {
                    $('#horizontalTab').easyResponsiveTabs({
                        type: 'default', //Types: default, vertical, accordion
                        width: 'auto', //auto or any width like 600px
                        fit: true,   // 100% fit in a container
                        closed: 'accordion', // Start closed if in accordion view
                        activate: function (event) { // Callback function if tab is switched
                            var $tab = $(this);
                            var $info = $('#tabInfo');
                            var $name = $('span', $info);
                            $name.text($tab.text());
                            $info.show();
                        }
                    });

                    $('#verticalTab').easyResponsiveTabs({
                        type: 'vertical',
                        width: 'auto',
                        fit: true
                    });
                });
            </script>

            <div class="tabs_user" style="height: 100%; overflow: hidden;">
                <div></div>
                <div class="tab-left">
                    <ul class="resp-tabs-list">
                        <li class="resp-tab-item">Favorite</li>
                        <li class="resp-tab-item">Recommends</li>
                        <li class="resp-tab-item">Past Reviews</li>
                        <li class="resp-tab-item">Change Passoword</li>
                        <!-- <li class="resp-tab-item">Recover Form</li>
                        <li class="resp-tab-item">Contact Form</li> -->
                    </ul>
                </div>

                <div class="tab-right">
                    <div class="resp-tabs-container">
                        <%--Favorite--%>
                        <div class="tab-1 resp-tab-content" id="Favorite">
                            <!-- A film -->

                            <%--<!-- End of a film -->--%>
                        </div>
                        <%--Favorite end--%>

                        <%--Recommends--%>
                        <div class="tab-1 resp-tab-content" id="Recommends">
                            <!-- A film -->
                            <%--<!-- End of a film -->--%>
                        </div>
                        <%--Recommeds end--%>
                        <!-- Past Reviews -->
                        <div id="pastReviewBox" class="tab-1 resp-tab-content gallery-images">

                        </div>
                        <script>
                            var pastReviewBox = document.getElementById('pastReviewBox');
                            $.ajax({
                                type: 'post',
                                url: '/user/getPersonalReview.action',
                                contentType: 'application/json',
                                data: '<%=userAccount.getUserID()%>',
                                success: function (data) {
                                    if (data != null && data.length !== 0) {
                                        for (var i = 0; i < data.length; i++) {
                                            var filmName = '';
                                            var num = i;
                                            $.ajax({
                                                type: 'post',
                                                url: '/film/getFilmName.action',
                                                contentType: 'application/json;charset=utf-8',
                                                data: data[i].imdb_filmID,
                                                success: function (data1) {
                                                    filmName = data1;
                                                    var stars = '';
                                                    for (var j = 0; j < data[num].score; j++) {
                                                        stars += '<img style="width: 18px" src="../images/star-small.png" />';
                                                    }
                                                    for (var j = 0; j < (10 - data[num].score); j++) {
                                                        stars += '<img style="width: 18px" src="../images/star-small-dark.png" />';
                                                    }
                                                    var reviewDiv = '<div class="review_box">\
                                                            <h4 class="review_moviename">' + filmName + '</h4>\
                                                            <span class="review_time">Review Date: ' + data[num].time.year + '-' + data[num].time.monthValue + '-' + data[num].time.dayOfMonth + '<span></span></span>\
                                                            ' + stars + '\
                                                            <div class="review_summary">' + data[num].summary + '</div>\
                                                            <div class="review_text">' + data[num].text + '</div>\
                                                            </div>';
                                                    pastReviewBox.innerHTML += reviewDiv;
                                                }
                                            });
                                        }

                                    }
                                }
                            });
                        </script>
                        <!-- Past Reviews end-->
                        <%--Reset password--%>
                        <div class="tab-1 resp-tab-content">
                            <div class="w3l-sign-in">

                                <form action="#" method="post">
                                    <input type="password" class="password" name="password" placeholder="Password"
                                           required="">
                                    <input type="password" class="password" name="password-confirm"
                                           placeholder="Confirm Password" required="">
                                    <ul class="w3agile">
                                        <li>
                                            <input type="checkbox" id="brand1" value="">
                                            <label for="brand1"><span></span>Remember me</label>
                                        </li>
                                    </ul>
                                    <input type="submit" value="Confirm">
                                    <div class="clear"></div>
                                </form>
                            </div>
                        </div>
                        <%--Reset password end--%>
                        <!-- End tab -->
                    </div>
                </div>
                <!-- End tab-right -->
                <div class="clear"></div>

            </div>
            <!-- End tabs -->
        </div>
        <!-- End horizontalTab -->
    </div>
    <!-- End tab -->
</div>
<!-- End container -->

<!--loginBox-->
<jsp:include page="common/loginbox.jsp"></jsp:include>

<!-- footer -->
<div class="footer w3-agile-1">
    <div class="container">

        <ul class="fb_icons2 agile-1">
            <li><a class="fb" href="#"></a></li>
            <li><a class="twit" href="#"></a></li>
            <li><a class="goog" href="#"></a></li>
            <li><a class="pin" href="#"></a></li>
            <li><a class="drib" href="#"></a></li>
        </ul>
    </div>
    <p class="copyright">© 2017 Filmdia. All Rights Reserved | Design by XYC, GZQ, XZH and LWY</p>
</div>
<!-- footer -->

<script src="../js/search.js"></script>

<%--启动加载收藏的电影\推荐的电影和过去评论--%>
<script>
    var Favorite = document.getElementById('Favorite');
    var Recommeds = document.getElementById('Recommends');
    var accountID = <%=userAccount.getUserID()%>;
    var recoBox = '';
    var temprecoBox = '';
    var filmBox = '';
    var tempBox = '';
    var favid = '';
    var url = 'details.jsp';
    $(window).load(function () {
        getFav();
        getReco();
    })

    function getFav() {
        $.ajax({
            type: 'post',
            url: '/user/getFavorite.action',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(accountID),
            success: function (data) {
                $.each(data, function (i, item) {
                    Favorite.innerHTML = '';
                    favid = item.favoriteID;
                    url = setQueryString(url, 'filmID', item.filmID);
                    tempBox = '' +
                        '<div class="col-md-4 gal-left gal_mar">' +
                        '<div class="content-grid-effect slow-zoom vertical text-center">' +
                        '<a href="' + url + '" class="b-link-stripe b-animate-go  swipebox">' +
                        '<div class="img-box"> ' +
                        '<img src=' + item.posterURL + ' alt="image" class="img-responsive zoom-img">' +
                        '</div>' +
                        '<div class="info-box">' +
                        '<div class="info-content">' +
                        '<h4>' + item.filmName + '</h4>' +
                        '<span class="separator"></span>' +
                        '<p style="max-height: 145px">' + item.summary + '</p>' +
                        '</div>' +
                        '</div>' +
                        '</a>' +
                        '</div>' +
                        '<div class="deleteBtn" onclick="this.parentNode.parentNode.removeChild(this.parentNode);removeFav(' + item.favoriteID + ')">Remove</div>' +
                        '</div>';
                    filmBox += tempBox;
                });
                Favorite.innerHTML = filmBox;
            }
        });
    }

    function getReco() {
        $.ajax({
            type: 'post',
            url: '/user/getRecommendFilms.action',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(accountID),
            success: function (data) {
                $.each(data, function (i, item) {
                    Recommeds.innerHTML = '';
                    url = setQueryString(url, 'filmID', item.filmID);
                    url = setQueryString(url, 'imdb_filmID', item.imdb_filmID);
                    temprecoBox = '' +
                        '<div class="col-md-4 gal-left gal_mar">' +
                        '<div class="content-grid-effect slow-zoom vertical text-center">' +
                        '<a href="' + url + '" class="b-link-stripe b-animate-go  swipebox">' +
                        '<div class="img-box"> ' +
                        '<img src=' + item.posterURL + ' alt="image" class="img-responsive zoom-img">' +
                        '</div>' +
                        '<div class="info-box">' +
                        '<div class="info-content">' +
                        '<h4>' + item.name + '</h4>' +
                        '<span class="separator"></span>' +
                        '<p style="max-height: 145px">' + item.summary + '</p>' +
                        '</div>' +
                        '</div>' +
                        '</a>' +
                        '</div>' +
                        '</div>';
                    recoBox += temprecoBox;
                });
                Recommeds.innerHTML = recoBox;
            }
        });
    }

    //从数据库中删除
    function removeFav(favID) {
        $.ajax({
            type: 'post',
            url: '/user/removeFavorite.action',
            contentType: 'application/json;charset=utf-8',
            data: JSON.stringify(favID),
            success: function (data) {
                if (data.result == 'success') {
                } else {
                    alert('Remove failed.');
                }
            }
        });
    }
</script>

</body>
<!-- //Body -->
</html>