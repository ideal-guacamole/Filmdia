
<%--
  Created by IntelliJ IDEA.
  User: mac
  Date: 2017/5/9
  Time: 上午9:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<!-- Head -->
<head>
    <title>Home · Filmdia</title>
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
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" media="all">
    <link rel="stylesheet" href="css/style.css" type="text/css" media="all">
    <link rel="stylesheet" href="css/index.css" type="text/css">
    <!-- //Custom-Theme-Files -->
    <!-- Web-Fonts -->
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800" type="text/css">
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Montserrat:400,700" type="text/css">
    <!-- //Web-Fonts -->
    <!-- Default-JavaScript-File -->
    <script type="text/javascript" src="js/lib/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="js/lib/bootstrap.min.js"></script>
    <script src="js/ajax.js"></script>
    <script src="js/mylib.js"></script>
    <script src="js/lib/responsiveslides.min.js"></script>
    <script>
        $(function () {
            $("#slider").responsiveSlides({
                auto: true,
                pager: true,
                nav: true,
                speed: 1000,
                namespace: "callbacks",
                before: function () {
                    $('.events').append("<li>before event fired.</li>");
                },
                after: function () {
                    $('.events').append("<li>after event fired.</li>");
                }
            });
        });
    </script>
    <!--css and js for the pagination bar-->

    <!--<link rel="stylesheet" href="../css/pagi.css" type="text/css">-->
    <link rel="stylesheet" type="text/css" href="css/pagi3.css" media="screen"/>

    <link rel="stylesheet" href="css/user.css"/>
</head>
<!-- //Head -->
<!-- Body -->
<body>
<!-- Header -->
<div class="header w3layouts-1">
    <!-- Top-Bar -->

    <div class="top-bar w3-1">
        <div class="container">
            <div class="header-nav w3-agileits-1">
                <nav class="navbar navbar-default">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <h1><a class="navbar-brand" href="index.jsp"><img src="../images/logo2.png"></a></h1>
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                                data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>

                    </div>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav ">
                            <li><a class=" active" href="index.jsp">Home</a></li>
                            <li><a href="views/library.jsp">Library</a></li>
                            <li><a href="views/statistic.jsp">Statistic</a></li>
                            <li><a href="views/predict.jsp">Predict</a></li>
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
                        <div id="userBox" class="user-manage">
                            <img id="userCenter" src="images/Center.png">
                            <div id="userUnderBox">
                                <div style="text-indent:0;text-align: center">Hello, <span>xxx</span>!</div>
                                <ul>
                                    <li>
                                        <img src="images/userCenter.png"/><a href="views/userCenter.jsp">User Center</a>
                                    </li>
                                    <li><img src="images/exit.png"/><a href="" onclick="signOut()">Sign Out</a></li>
                                </ul>
                            </div>
                            <!--<a href="" class="sign-in-out" style="color: #fff">Sign In/Up</a>-->
                            <!--<span style="color: #fff"> | </span>-->
                            <!--<a href="" class="sign-up" style="color: #fff">Sign Up</a>-->
                        </div>
                    </div><!-- /navbar-collapse -->
                    <!-- search-scripts -->
                    <script src="js/classie.js"></script>
                    <script src="js/uisearch.js"></script>
                    <script>
                        new UISearch(document.getElementById('sb-search'));
                    </script>
                    <!-- //search-scripts -->
                </nav>
            </div>
        </div>
    </div>
    <!-- //Top-Bar -->
    <!-- Slider -->
    <div class="slider">
        <div class="callbacks_container">
            <ul class="rslides" id="slider">
                <li>
                    <div class="slider-img">
                        <img id="" src="../images/FastAndFurious8.jpg" class="img-responsive" alt="Manufactory">
                    </div>
                    <div class="slider-info w3ls-1">
                        <h3>The Fate of the Furious</h3>
                        <div class="underline"></div>
                        <p>When a mysterious woman seduces Dom into the world of terrorism and a betrayal of those
                            closest to him, the crew face trials that will test them as never before. </p>

                    </div>
                </li>
                <li>
                    <div class="slider-img">
                        <img src="../images/LaLaLand.jpg" class="img-responsive" alt="Manufactory">
                    </div>
                    <div class="slider-info">
                        <h3>La La Land</h3>
                        <div class="underline"></div>
                        <p>A jazz pianist falls for an aspiring actress in Los Angeles.</p>

                    </div>
                </li>
                <li>
                    <div class="slider-img">
                        <img src="../images/BeautyAndTheBeast.jpg" class="img-responsive" alt="Manufactory">
                    </div>
                    <div class="slider-info w3ls-1">
                        <h3>Beauty And The Beast</h3>
                        <div class="underline"></div>
                        <p>An adaptation of the fairy tale about a monstrous-looking prince and a young woman who fall
                            in love. </p>

                    </div>
                </li>
                <li>
                    <div class="slider-img">
                        <img src="../images/Spotlight.jpg" class="img-responsive" alt="Manufactory">
                    </div>
                    <div class="slider-info w3ls-1">
                        <h3>Spotlight</h3>
                        <div class="underline"></div>
                        <p>The true story of how the Boston Globe uncovered the massive scandal of child molestation and
                            cover-up within the local Catholic Archdiocese, shaking the entire Catholic Church to its
                            core.</p>

                    </div>
                </li>

                <li>
                    <div class="slider-img">
                        <img src="../images/TheGreatWall.jpg" class="img-responsive" alt="Manufactory">
                    </div>
                    <div class="slider-info w3ls-1">
                        <h3>The Great Wall</h3>
                        <div class="underline"></div>
                        <p>European mercenaries searching for black powder become embroiled in the defense of the Great
                            Wall of China against a horde of monstrous creatures. </p>

                    </div>
                </li>
            </ul>
            <script>
                var slider = document.getElementById('slider');
                var posterArr = slider.getElementsByTagName('li');
                posterArr[0].onclick = function () {
                    setUrl(24, 'tt4630562');
                };
                posterArr[1].onclick = function () {
                    setUrl(105, 'tt3783958');
                };
                posterArr[2].onclick = function () {
                    setUrl(12, 'tt2771200')
                };
                posterArr[3].onclick = function () {
                    setUrl(1578, 'tt1895587')
                };
                posterArr[4].onclick = function () {
                    setUrl(102, 'tt2034800')
                };

                function setUrl(filmID, imdbID) {
                    var url = 'views/details.jsp';
                    var ref = 'filmID';
                    var value = filmID;
                    url = setQueryString(url, ref, value);
                    ref = 'imdb_filmID';
                    value = imdbID;
                    url = setQueryString(url, ref, value);
                    location.href = url;
                }

            </script>
        </div>
        <div class="clearfix"></div>
    </div>
    <!-- //Slider -->
</div>
<!-- //Header -->
<!-- agileinfo -->
<div class="agileinfo">
    <div class="container">
        <h3 style="font-weight: bold; margin-top: 30px">Cinema Info</h3>
        <p class="ttt">Movies playing and coming soon.</p>
        <div class="latestinfo">
            <div class="title cf">
                <ul class="title-list fr cf ">
                    <li class="on">Opening This Week</li>
                    <li>Now Playing</li>
                    <li>Coming Soon</li>
                    <p></p>
                </ul>
            </div>
            <div class="product-wrap">
                <!--案例1-->
                <div class="product showing">
                    <ul class="cf">
                        <li class="ml0" id="thisweek">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="thisweek_film1_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="thisweek_film1_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="thisweek_film1_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="thisweek_film1_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="thisweek_film2_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="thisweek_film2_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="thisweek_film2_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="thisweek_film2_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="thisweek_film3_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="thisweek_film3_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="thisweek_film3_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="thisweek_film3_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="thisweek_film4_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="thisweek_film4_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="thisweek_film4_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="thisweek_film4_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="thisweek_film5_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="thisweek_film5_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="thisweek_film5_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="thisweek_film5_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
                <!--案例2-->
                <div class="product" id="latest">
                    <ul class="cf">
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="latest_film1_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="latest_film1_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="latest_film1_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="latest_film1_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="latest_film2_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="latest_film2_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="latest_film2_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="latest_film2_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="latest_film3_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="latest_film3_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="latest_film3_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="latest_film3_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="latest_film4_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="latest_film4_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="latest_film4_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="latest_film4_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="latest_film5_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="latest_film5_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="latest_film5_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="latest_film5_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
                <!--案例3-->
                <div class="product" id="coming">
                    <ul class="cf">
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="coming_film1_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="coming_film1_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="coming_film1_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="coming_film1_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="coming_film2_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="coming_film2_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="coming_film2_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="coming_film2_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="coming_film3_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="coming_film3_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="coming_film3_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="coming_film3_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="coming_film4_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="coming_film4_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="coming_film4_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="coming_film4_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                        <li class="ml0">
                            <div class="content-grid-effect slow-zoom vertical text-center">
                                <a id="coming_film5_url" href="" class="b-link-stripe b-animate-go  swipebox">
                                    <div class="img-box">
                                        <img id="coming_film5_pic" src="" alt="image" class="img-responsive zoom-img">
                                    </div>
                                    <div class="info-box">
                                        <div class="info-content">
                                            <h4 id="coming_film5_name">Premier Realty</h4>
                                            <span class="separator"></span>
                                            <p id="coming_film5_summary">Ut enim ad minima veniam, quis nostrum
                                                exercitationem ullam corporis suscipit
                                                laboriosam</p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- End of the cinemainfo -->

        <h3 style="font-weight: bold" id="top"><span id="IMDb" title="IMDb Top 250 Chart">IMDb</span> and <span
                id="Oscar" title="Oscar Best Picture Chart">Oscar</span> Top Films</h3>
        <p class="ttt">Chart of the top 250 films on IMDb and Best Picture Oscar each year.(Click the light blue title
            to switch)</p>
        <div class="bs-docs-example">
            <table id="toptable" class="table table-hover">
                <colgroup>
                    <col class="chartPoster">
                    <col class="chartTitle">
                    <col class="chartRating">
                    <col class="chartAdd">
                </colgroup>
                <thead>
                <tr>
                    <th>Poster</th>
                    <th>Rank&Title</th>
                    <th>Rating</th>
                    <%--<th>Fav</th>--%>
                </tr>
                </thead>
                <tbody id="tablebody">
                <script>


                    function loadTable(page, imdb_oscar) {
                        var table_body = document.getElementById('tablebody');
                        var add = '';
                        var url = 'views/details.jsp';
                        var temp = '';
                        var count = 0;  //count the number of movie shows in a page, max 10
                        var start = page * 10;
                        var end = start + 9;

                        if (imdb_oscar === 0) {
                            $.ajax({
                                type: 'post',
                                url: '/film/getFilmByType.action',
                                data: {
                                    filmType: 'Top250'
                                },
                                success: function (data) {
                                    $.each(data, function (i, item) {
                                        if (count < 10 && i >= start && i <= end) {
                                            url = setQueryString(url, 'filmID', item.filmID);
                                            url = setQueryString(url, 'imdb_filmID', item.imdb_filmID);
                                            temp = '' +
                                                '<tr>' +
                                                '<td>' +
                                                '<a href="' + url + '">' +
                                                '<img style="width: 46px; height: 67px" src=' + item.posterURL + '>' +
                                                '</a>' +
                                                '</td>' +
                                                '<td>' +
                                                (i + 1) + ". " +
                                                '<a href="' + url + '">' + item.name + '</a>' +
                                                '</td>' +
                                                '<td>' + item.score + '</td>' +
                                                '</tr>';
                                            add += temp;
                                            count++;
                                        }
                                    });
                                    table_body.innerHTML = add;
                                }
                            });
                        } else {
                            $.ajax({
                                type: 'post',
                                url: '/film/getFilmByType.action',
                                data: {
                                    filmType: 'Oscar'
                                },
                                success: function (data) {
                                    $.each(data, function (i, item) {
                                        if (count < 10 && i >= start && i <= end) {
                                            url = setQueryString(url, 'filmID', item.filmID);
                                            url = setQueryString(url, 'imdb_filmID', item.imdb_filmID);
                                            temp = '' +
                                                '<tr>' +
                                                '<td>' +
                                                '<a href="' + url + '">' +
                                                '<img style="width: 46px; height: 67px" src=' + item.posterURL + '>' +
                                                '</a>' +
                                                '</td>' +
                                                '<td>' +
                                                (i + 1) + ". " +
                                                '<a href="' + url + '">' + item.name + '</a>' +
                                                '</td>' +
                                                '<td>' + item.score + '</td>' +
                                                '</tr>';
                                            add += temp;
                                            count++;
                                        }
                                    });
                                    table_body.innerHTML = add;
                                }
                            });
                        }

                    }
                </script>
                </tbody>
            </table>
        </div>

        <!--The pagination bar-->
        <div style="width: 100%">
            <div class="content">
                <div class="demo">
                    <div id="paginate_imdb"></div>
                </div>
            </div>
            <script type="text/javascript" src="js/lib/jquery.paginate.js"></script>
            <script type="text/javascript">

            </script>
        </div>
        <!--End of the pagination bar-->

    </div>
</div>
<!-- agileinfo -->

<%--Load the table and pagination--%>
<script>
    $(window).load(function () {

        var IMDb_O = 1;
        var imdb = document.getElementById('IMDb');
        var oscar = document.getElementById('Oscar');
        loadTable(0, IMDb_O);
        $("#paginate_imdb").paginate({
            count: 10,
            start: 1,
            display: 15,
            border: false,
            text_color: '#79B5E3',
            background_color: 'none',
            text_hover_color: '#2573AF',
            background_hover_color: 'none',
            images: false,
            mouse: 'press',
            onChange: function (page_index) {
                loadTable(page_index - 1, IMDb_O);
                location.href = '#top';
            }
        });

        imdb.onclick = function () {
            IMDb_O = 0;
            loadTable(0, IMDb_O);
            $("#paginate_imdb").paginate({
                count: 25,
                start: 1,
                display: 15,
                border: false,
                text_color: '#79B5E3',
                background_color: 'none',
                text_hover_color: '#2573AF',
                background_hover_color: 'none',
                images: false,
                mouse: 'press',
                onChange: function (page_index) {
                    loadTable(page_index - 1, IMDb_O);
                    location.href = '#top';
                }
            });
        }
        oscar.onclick = function () {
            IMDb_O = 1;
            loadTable(0, IMDb_O);
            $("#paginate_imdb").paginate({
                count: 10,
                start: 1,
                display: 15,
                border: false,
                text_color: '#79B5E3',
                background_color: 'none',
                text_hover_color: '#2573AF',
                background_hover_color: 'none',
                images: false,
                mouse: 'press',
                onChange: function (page_index) {
                    loadTable(page_index - 1, IMDb_O);
                    location.href = '#top';
                }
            });
        }


    });
</script>

<jsp:include page="views/common/footer.jsp"></jsp:include>

<jsp:include page="views/common/loginbox.jsp"></jsp:include>

<script type="text/javascript" src="js/index.js"></script>


<!--End-slider-script-->
<script src="../js/easyResponsiveTabs.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#horizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion
            width: 'auto', //auto or any width like 600px
            fit: true   // 100% fit in a container
        });
    });
</script>
<script src="js/search_index.js"></script>
</body>
<!-- //Body -->
</html>
