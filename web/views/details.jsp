<%@ page import="entityVO.UserAccount" %>
<%
    UserAccount userAccount = (UserAccount) session.getAttribute("userAccount");
    if (userAccount == null) {
        UserAccount initAccount = new UserAccount();
        initAccount.setUserID(0);
        initAccount.setUserName("");
        initAccount.setPassword("");
        userAccount = initAccount;
    }
%>
<%--
  Created by IntelliJ IDEA.
  User: Ferriswheel
  Date: 2017/5/17
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<!-- Head -->
<head>
    <title>Details · Filmdia</title>
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
    <script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="../js/bootstrap.min.js"></script>

    <!-- Own css and js-->
    <link rel="stylesheet" href="../css/details.css" type="text/css" media="all">
    <link rel="stylesheet" href="../css/Detail_Tab.css" type="text/css" media="all">
    <link rel="stylesheet" href="../css/user.css"/>
    <link rel="stylesheet" href="../css/spinner.css"/>
    <script src="../js/mylib.js"></script>
    <script type="text/javascript" src="../js/Detail_Tab.js"></script>
    <script src="../js/echarts.js"></script>
    <script src="../js/world.js"></script>
    <!-- <script type="text/javascript" src="../js/jquery.min.js"></script> -->

    <!-- Star css and js -->
    <!-- <script type="text/javascript" src="../js/jquery.js"></script> -->
    <!-- script type="text/javascript" src="jquery.rater.js"></script -->
    <!-- 	<script type="text/javascript" src="../js/jquery.rater.packed.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/rater.css" media="all" />  -->
    <!-- Button css -->
    <link rel="stylesheet" href="../css/button.css" type="text/css" media="all">
</head>
<!-- //Head -->
<!-- Body -->
<body style="background: url(../images/bgDetail.jpg) no-repeat fixed">
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
                        <h1><a class="navbar-brand" href="../index.jsp"><img src="../images/logo2.png"></a></h1>
                    </div>
                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse nav-wil" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav ">
                            <li><a href="../index.jsp">Home</a></li>
                            <li><a href="library.jsp">Library</a></li>
                            <li><a href="statistic.jsp">Statistic</a></li>
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
<div class="banner">
    <div class="title-info">
        <div class="film_poster"><a href=""><img id="poster" src=""></a></div>
        <div class="fast_info">
            <h2 id="title" class="film_title"><span class="Year">(2012)</span></h2>

            <span id="summary" class="film_summary"></span>
            <br>
            <span class="Directors"><label>Directors:&nbsp</label><span id="directors"></span></span>
            <span class="Stars"><label>Stars:&nbsp</label><span id="actors"></span></span>
            <span class="Tags"><label>Genre:&nbsp</label><span id="tags"></span></span>
        </div>
        <div class="add_fav">
            <div class="fav_content">
                <label class="Score"><span id="score"></span><span style="color: #fff; font-size: 17px">/10
                </span></label>
                <label class="rating_label" style="color: #fff">Your Rating:
                </label>
                <br/>
                <div style="text-align: center;font-size: 20px;line-height: 50px;color: #8c94ff;font-weight: bold"><em
                        id="userScore">No Rating yet</em></div>
                <!-- <div id="demo6" class="demo"></div>
                <script type="text/javascript">
                    $('#demo6').rater('../js/ratingsdemo.php', {maxvalue:10, style: 'basic', curvalue:0});
                </script> -->
                <button class="add_button btn btn-primary btn-sm btn-round" id="add_fav">Add to Favorite</button>
                <script>
                    document.getElementById('add_fav').onclick = function () {
                        var accountID = <%=userAccount.getUserID()%>;
                        addFav(accountID);
                    }
                </script>
            </div>

        </div>
    </div>
</div>

<div class="tab_group" style="background: transparent;">
    <div class="title cf" style="background: rgba(0,0,0,.1);">
        <ul class="title-list fr cf ">
            <li class="on">Technical Specs</li>
            <li>Reviews</li>
            <li id="graphPart">Graphs</li>
            <li>Comment</li>
            <p></p>
        </ul>
    </div>
    <div class="product-wrap" style="background: rgba(255,255,255,1);">
        <!--Specific-->
        <div class="product showing">
            <ul class="cf">
                <li class="ml0">
                    <!-- base Info -->
                    <div class="info_line1">
                        <span class="country_label">Country: </span><label id="country" class="Country"></label>
                        <span class="language_label">Gross: </span><label id="language" class="Language"></label>
                        <span class="runtime_label">Runtime: </span><label id="runtime" class="Runtime"></label>
                    </div>
                    <!-- base Info -->
                    <!-- Cast -->
                    <div id="castBox" class="Cast left">
                        <h3>Cast</h3>
                        <table class="table table-hover" id="castTable">
                            <colgroup>
                                <col class="Pic">
                                <col class="Name">
                                <col class="Role">
                            </colgroup>
                            <thead>
                            <tr>
                                <th>No.</th>
                                <th>Name</th>
                                <th>Role</th>
                            </tr>
                            </thead>
                            <tbody id="casttbody">
                            </tbody>
                        </table>
                    </div>
                    <!-- Cast end-->

                    <!-- Storyline -->
                    <div class="Storyline left">
                        <h3>Storyline</h3>
                        <div class="storyline_form">
                            <div class="storyline_part">
                                <p id="storyline">A naval war ship encounters an alien armada and faces the biggest
                                    threat mankind has
                                    ever faced. If they lose, the world could face a major extinction event and an alien
                                    invasion. Will humans win this alien war, what are the aliens doing here, and what
                                    do they want? Based on the Hasbro naval war game. </p>
                            </div>
                            <div class="tagline_part">
                                <label for="storyLine_tagLine">Tagline: </label>
                                <span id="storyLine_tagLine" class="Tagline">The battle for Earth begins at sea.</span>
                            </div>
                            <div class="keyword_part">
                                <label for="storyLine_keywords">Plot Keywords: </label>
                                <span id="storyLine_keywords" class="ScripteKeywords">oahuhawaii | hawaii | alien | naval | ship </span>
                            </div>
                        </div>
                    </div>
                    <%--Storyline end--%>

                    <!-- Details -->
                    <div class="Details right">
                        <h3>Details</h3>
                        <div class="detail_form">
                            <span>Language: <label id="detail_language" class="Language"></label></span>
                            <span>Release Date:
                                <label id="detail_onTime" class="OnTime"></label></span>
                            <span>Trailer Online: <label id="detail_watchUrl" class="OnTime"><a
                                    href=""></a></label></span>
                        </div>
                    </div>
                    <!-- Details end-->

                    <%--Core Members--%>
                    <div class="CoreMembers right">
                        <h3>Core Members</h3>
                        <div class="detail_form">
                            <div class="coresgroup">
                                <div class="cores">
                                    <img id="director_pic" src="../images/posters/B005CA4SJW.jpg"
                                         style="width:70px; height: 105px;">
                                    <div id="director_name" class="name">John Williams(Dir)</div>
                                </div>
                                <div class="cores">
                                    <img id="star1_pic" src="../images/posters/B005CA4SJW.jpg"
                                         style="width:70px; height: 105px;">
                                    <div id="star1_name" class="name">John Williams</div>
                                </div>
                                <div class="cores">
                                    <img id="star2_pic" src="../images/posters/B005CA4SJW.jpg"
                                         style="width:70px; height: 105px;">
                                    <div id="star2_name" class="name">John William</div>
                                </div>
                                <div class="cores">
                                    <img id="star3_pic" src="../images/posters/B005CA4SJW.jpg"
                                         style="width:70px; height: 105px;">
                                    <div id="star3_name" class="name">John Williams</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--Core Members end--%>

                    <%--Box office--%>
                    <div class="BoxOffice right">
                        <h3>Box Office</h3>
                        <div class="detail_form">
                            <span>Worldwide Gross: <label id="box_worldGross"></label></span>
                            <span>Gross: <label id="box_gross"></label></span>
                            <span>Budget: <label id="box_budget"></label></span>
                        </div>
                    </div>
                    <%--Box office end--%>


                </li>
                <li>
                </li>
                <li>
                </li>
                <li>
                </li>
            </ul>
        </div>

        <!--Reviews-->
        <div id="product" class="product">
            <ul class="cf">
                <li class="ml0">
                    <div id="reviewBox" class="reviews">
                        <div class="spinner" id="spinner">
                            <div class="spinner-container container1">
                                <div class="circle1"></div>
                                <div class="circle2"></div>
                                <div class="circle3"></div>
                                <div class="circle4"></div>
                            </div>
                            <div class="spinner-container container2">
                                <div class="circle1"></div>
                                <div class="circle2"></div>
                                <div class="circle3"></div>
                                <div class="circle4"></div>
                            </div>
                            <div class="spinner-container container3">
                                <div class="circle1"></div>
                                <div class="circle2"></div>
                                <div class="circle3"></div>
                                <div class="circle4"></div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <!--Graphs-->
        <div id="graph" class="product">
            <ul class="cf">
                <li class="ml0">
                    <section id="radarBox">
                    </section>
                    <section id="mapBox">
                    </section>
                    <section id="scoreNumBox">
                    </section>
                    <section id="scoreFluctuationBox">
                    </section>
                    <section id="reviewFluctuationBox">
                    </section>
                    <button
                            style="margin-bottom:20px;margin-left:470px;width: 80px;text-align: center;height: 30px;display: inline-block"
                            value="Day" onclick="javascript:makeReviewFluctuationByDay()">Day
                    </button>
                    <button style="margin-bottom:20px;margin-left:5px;width: 80px;text-align: center;height: 30px;display: inline-block"
                            value="Month" onclick="javascript:makeReviewFluctuationByMonth()">Month
                    </button>
                    <button style="margin-bottom:20px;margin-left:5px;width: 80px;text-align: center;height: 30px;display: inline-block"
                            value="Quarter" onclick="javascript:makeReviewFluctuationByQuarter()">Quarter
                    </button>
                    <section id="commentWordsBox">
                    </section>
                    <section id="descriptionLengthBox">
                    </section>
                </li>
            </ul>
        </div>

        <%--Script for Graphs--%>
        <script>
            //加载统计图
            var imdb_filmID = getQueryString('imdb_filmID');
            var graphPart = document.getElementById('graphPart');
            var graph = document.getElementById('graph');

            graphPart.onmouseover = function () {
                if (!graph.isEnter) {
                    graph.isEnter = true;
                    makeRadar();
                    makeReviewMap();
                }
            };
            var loadingReadyArr = [false, false, false, false, false, false];
            graph.onscroll = function () {
                var oScroll = graph.scrollTop;
                if (!loadingReadyArr[1] && oScroll > 400) {
                    loadingReadyArr[1] = true;
                    makeScoreNum();

                }
                if (!loadingReadyArr[2] && oScroll > 650) {
                    loadingReadyArr[2] = true;
                    makeScoreFluctuation();

                }
                if (!loadingReadyArr[3] && oScroll > 1100) {
                    loadingReadyArr[3] = true;
                    makeReviewFluctuationByDay();

                }
                if (!loadingReadyArr[4] && oScroll > 1550) {
                    loadingReadyArr[4] = true;
                    makeCommentWords();

                }
                if (!loadingReadyArr[5] && oScroll > 1900) {
                    loadingReadyArr[5] = true;
                    makeDescriptionLength();

                }
            };


            //电影雷达图
            function makeRadar() {
                var radarBox = document.getElementById('radarBox');
                var film = getFilm();
                var reviewNum = 0;
                $.ajax({
                    type: 'post',
                    url: '/review/getReviewNumber.action',
                    contentType: 'application/json;charset=utf-8',
                    data: imdb_filmID,
                    success: function (data) {
                        reviewNum = data;
                        var radarData = [];
                        for (var i = 0; i < film.tags.length; i++) {
                            $.ajax({
                                type: 'post',
                                url: '/filmChart/getRadarChartInfo.action',
                                data: {tag: film.tags[i], year: film.onTime.substr(0, 4)},
                                success: function (data) {
                                    radarData.push(data);
                                    if (radarData.length === film.tags.length) {
                                        var radarChart = echarts.init(radarBox);
                                        var str = 'Average in ' + film.tags[0];
                                        var option = {
                                            title: {
                                                text: 'General Figure'
                                            },
                                            tooltip: {},
                                            legend: {
                                                selectedMode: 'single',
                                                selected: {
                                                    'This Film': true,
                                                    str: true
                                                },
                                                data: [],
                                                left: 'left',
                                                top: 'center',
                                                orient: 'vertical'
                                            },
                                            scale: 'true',
                                            radar: {},
                                            series: []
                                        };
                                        var maxGross = 0;
                                        var maxBudget = 0;
                                        var maxReviewNumber = 0;
                                        var maxRatingNum = 0;
                                        for (var i = 0; i < radarData.length; i++) {
                                            if (maxGross < radarData[i].gross) {
                                                maxGross = radarData[i].gross;
                                            }
                                            if (maxGross < film.gross) {
                                                maxGross = film.gross;
                                            }
                                            if (maxBudget < radarData[i].budget) {
                                                maxBudget = radarData[i].budget;
                                            }
                                            if (maxBudget < film.budget) {
                                                maxBudget = film.budget;
                                            }
                                            if (maxReviewNumber < radarData[i].reviewNumber) {
                                                maxReviewNumber = radarData[i].reviewNumber;
                                            }
                                            if (maxReviewNumber < reviewNum) {
                                                maxReviewNumber = reviewNum;
                                            }
                                            if (maxRatingNum < radarData[i].ratingNum) {
                                                maxRatingNum = radarData[i].ratingNum;
                                            }
                                            if (maxRatingNum < film.ratingNum) {
                                                maxRatingNum = film.ratingNum;
                                            }
                                            option.legend.data.push(
                                                'Average in ' + film.tags[i]
                                            );
                                            option.series.push({
                                                name: 'Average in ' + film.tags[i],
                                                type: 'radar',
                                                symbolSize: '8',
                                                data: [
                                                    {
                                                        value: [film.score, film.gross, film.budget, reviewNum, film.runtime, film.ratingNum],
                                                        name: 'This Film'
                                                    },
                                                    {
                                                        value: [radarData[i].score, radarData[i].gross, radarData[i].budget, radarData[i].reviewNumber, radarData[i].runtime, radarData[i].ratingNum],
                                                        name: 'Average in ' + film.tags[i]
                                                    }
                                                ]
                                            })
                                        }
                                        option.radar = {
                                            indicator: [
                                                {name: 'Score', max: 10},
                                                {name: 'Gross', max: Math.round(maxGross * (Math.random() + 1))},
                                                {name: 'Budget', max: Math.round(maxBudget * (Math.random() + 1))},
                                                {
                                                    name: 'Review Number',
                                                    max: Math.round(maxReviewNumber * (Math.random() + 1))
                                                },
                                                {name: 'Runtime', max: 180},
                                                {
                                                    name: 'Rating Number',
                                                    max: Math.round(maxRatingNum * (Math.random() + 1))
                                                }
                                            ]
                                        };
                                        radarChart.setOption(option);
                                        radarBox.style.marginLeft = 200 + 'px';
                                    }

                                }
                            });
                        }

                    }
                });

            }

            //评论分布地图
            function makeReviewMap() {
                var mapBox = document.getElementById('mapBox');
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getReviewCountryDistribute.action',
                    contentType: 'application/json;charset=utf-8',
                    data: imdb_filmID,
                    success: function (data) {
                        var seriesData = [];
                        for (var key in data) {
                            seriesData.push({name: data[key].country, value: data[key].number});
                        }
                        var mapChart = echarts.init(mapBox);
                        var option = {
                            title: {
                                text: 'Review Number Worldwide Distribution',
                                left: 'left',
                                top: 'top'
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: function (params) {
                                    return params.seriesName + '<br/>' + params.name + ' : ' + params.value;
                                }
                            },
                            visualMap: {
                                min: 0,
                                max: 20,
                                text: ['High', 'Low'],
                                realtime: false,
                                calculable: true,
                                inRange: {
                                    color: ['#e0ffff', '#006edd']
                                }
                            },
                            series: [
                                {
                                    name: 'Review Number Worldwide Distribution',
                                    type: 'map',
                                    mapType: 'world',
                                    roam: false,
                                    itemStyle: {
                                        emphasis: {label: {show: false}}
                                    },
                                    data: seriesData
                                }
                            ]
                        };
                        mapChart.setOption(option);
                        mapBox.style.marginLeft = 200 + 'px';

                    }
                });
            }

            //评分分布
            function makeScoreNum() {
                var scoreNumBox = document.getElementById('scoreNumBox');
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getScoreNum.action',
                    contentType: 'application/json;charset=utf-8',
                    data: imdb_filmID,
                    success: function (data) {
                        var seriesData = [];
                        for (var key in data) {
                            seriesData.push(data[key]);
                        }
                        var scoreNumChart = echarts.init(scoreNumBox);
                        var option = {
                            title: {
                                text: 'Score Distribution'
                            },
                            tooltip: {},
                            legend: {
                                data: ['Num']
                            },
                            xAxis: {
                                type: 'category',
                                name: 'Interval',
                                data: ["0.0~0.9", "1.0~1.9", "2.0~2.9", "3.0~3.9",
                                    "4.0~4.9", "5.0~5.9", "6.0~6.9", "7.0~7.9", "8.0~8.9", "9.0~10.0"]
                            },
                            yAxis: {
                                type: 'value',
                                name: 'Num'
                            },
                            series: [{
                                name: 'Num',
                                type: 'bar',
                                data: seriesData
                            }]
                        };
                        scoreNumChart.setOption(option);
                        scoreNumBox.style.marginLeft = 200 + 'px';

                    }
                });
            }

            //分数增长
            function makeScoreFluctuation() {
                var scoreFluctuationBox = document.getElementById('scoreFluctuationBox');
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getScoreFluctuation.action',
                    contentType: 'application/json;charset=utf-8',
                    data: imdb_filmID,
                    success: function (data) {
                        var xAxisData = [];
                        var seriesData = [];
                        for (var key in data) {
                            xAxisData.push(key);
                            seriesData.push(data[key]);
                        }
                        var scoreFluctuationChart = echarts.init(scoreFluctuationBox);
                        var option = {
                            title: {
                                text: 'Score Fluctuation'
                            },
                            tooltip: {
                                trigger: 'axis',
                                formatter: "Date: {b}<br/> Score: {c}"
                            },
                            legend: {
                                data: ['Score']
                            },
                            dataZoom: {
                                type: 'slider',
                                xAxisIndex: 0
                            },
                            xAxis: {
                                type: 'category',
                                name: 'Date',
                                axisTick: {
                                    alignWithLabel: true
                                },
                                data: xAxisData
                            },
                            yAxis: {
                                type: 'value',
                                name: 'Score',
                                scale: true
                            },
                            series: [{
                                name: "Score",
//                                smooth: true,
                                type: 'line',
                                symbolSize: 6,
                                data: seriesData
                            }]
                        };
                        scoreFluctuationChart.setOption(option);
                        scoreFluctuationBox.style.marginLeft = 200 + 'px';

                    }
                });
            }

            //评论数增长
            function makeReviewFluctuationByDay() {
                var reviewFluctuationBox = document.getElementById('reviewFluctuationBox');
                var dayData = [];
                var seriesDayData = [];
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getReviewNum.action',
                    data: {
                        imdb_filmID: imdb_filmID,
                        type: 'Day'
                    },
                    success: function (data) {
                        for (var key in data) {
                            dayData.push(key);
                            seriesDayData.push(data[key]);
                        }
                        var reviewFluctuationChart = echarts.init(reviewFluctuationBox);
                        var option = {
                            title: {
                                text: 'Review Fluctuation'
                            },
                            tooltip: [{
                                trigger: 'axis',
                                formatter: "Day: {b}<br/> ReviewNum: {c}"
                            }],
                            legend: {
                                data: ['ReviewNumByDay']
                            },
                            dataZoom: {
                                type: 'slider',
                                xAxisIndex: 0
                            },
                            xAxis: [{
                                type: 'category',
                                name: 'Day',
                                data: dayData,
                                axisTick: {
                                    alignWithLabel: true
                                }
                            }],
                            yAxis: [{
                                type: 'value',
                                name: 'ReviewNum'
                            }],
                            series: [{
                                name: "ReviewNumByDay",
//                                smooth: true,
                                type: 'line',
                                symbolSize: 6,
                                data: seriesDayData
                            }]
                        };
                        reviewFluctuationChart.setOption(option);
                        reviewFluctuationBox.style.marginLeft = 200 + 'px';
                    }
                });
            }

            function makeReviewFluctuationByMonth() {
                var reviewFluctuationBox = document.getElementById('reviewFluctuationBox');
                var monthData = [];
                var seriesMonthData = [];
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getReviewNum.action',
                    data: {
                        imdb_filmID: imdb_filmID,
                        type: 'Month'
                    },
                    success: function (data) {
                        for (var key in data) {
                            monthData.push(key);
                            seriesMonthData.push(data[key]);
                        }
                        var reviewFluctuationChart = echarts.init(reviewFluctuationBox);
                        var option = {
                            title: {
                                text: 'Review Fluctuation'
                            },
                            tooltip: [{
                                trigger: 'axis',
                                formatter: "Month: {b}<br/> ReviewNum: {c}"
                            }],
                            legend: {
                                data: ['ReviewNumByMonth']
                            },
                            dataZoom: {
                                type: 'slider',
                                xAxisIndex: 0
                            },
                            xAxis: [{
                                type: 'category',
                                name: 'Month',
                                data: monthData,
                                axisTick: {
                                    alignWithLabel: true
                                }
                            }],
                            yAxis: [{
                                type: 'value',
                                name: 'ReviewNum'
                            }],
                            series: [{
                                name: "ReviewNumByMonth",
//                                smooth: true,
                                type: 'line',
                                symbolSize: 6,
                                data: seriesMonthData
                            }]
                        };
                        reviewFluctuationChart.setOption(option);
                    }
                });
            }

            function makeReviewFluctuationByQuarter() {
                var reviewFluctuationBox = document.getElementById('reviewFluctuationBox');
                var quarterData = [];
                var seriesQuarterData = [];
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getReviewNum.action',
                    data: {
                        imdb_filmID: imdb_filmID,
                        type: 'Quarter'
                    },
                    success: function (data) {
                        for (var key in data) {
                            quarterData.push(key);
                            seriesQuarterData.push(data[key]);
                        }
                        var reviewFluctuationChart = echarts.init(reviewFluctuationBox);
                        var option = {
                            title: {
                                text: 'Review Fluctuation'
                            },
                            tooltip: [{
                                trigger: 'axis',
                                formatter: "Quarter: {b}<br/> ReviewNum: {c}"
                            }],
                            legend: {
                                data: ['ReviewNumByQuarter']
                            },
                            dataZoom: {
                                type: 'slider',
                                xAxisIndex: 0
                            },
                            xAxis: [{
                                type: 'category',
                                name: 'Quarter',
                                data: quarterData,
                                axisTick: {
                                    alignWithLabel: true
                                }
                            }],
                            yAxis: [{
                                type: 'value',
                                name: 'ReviewNum'
                            }],
                            series: [{
                                name: "ReviewNumByQuarter",
//                                smooth: true,
                                type: 'line',
                                symbolSize: 6,
                                data: seriesQuarterData
                            }]
                        };
                        reviewFluctuationChart.setOption(option);
                    }
                });
            }

            //关键字分布
            function makeCommentWords() {
                var commentWordsBox = document.getElementById('commentWordsBox');
                var valueData = [];
                var nameData = [];
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getCommentWords.action',
                    data: {
                        imdb_filmID: imdb_filmID,
                        n: 5 + ''
                    },
                    success: function (data) {
                        var seriesData = [];
                        for (var key in data) {
                            nameData.push(key);
                            valueData.push(data[key]);
                            seriesData.push({value: data[key], name: key});
                        }
                        var commentWordsChart = echarts.init(commentWordsBox);
                        var option = {
                            title: {
                                text: 'Comment Words Top 5'
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: "{a} <br/>{b}: {c} ({d}%)"
                            },
                            legend: {
                                orient: 'vertical',
                                left: 'left',
                                top: 'center',
                                data: nameData
                            },
                            series: [
                                {
                                    name: 'Word',
                                    type: 'pie',
                                    radius: ['50%', '70%'],
                                    avoidLabelOverlap: false,
                                    label: {
                                        normal: {
                                            show: false,
                                            position: 'center'
                                        },
                                        emphasis: {
                                            show: true,
                                            textStyle: {
                                                fontSize: '30',
                                            }
                                        }
                                    },
                                    labelLine: {
                                        normal: {
                                            show: false
                                        }
                                    },
                                    data: seriesData
                                }
                            ]
                        };
                        commentWordsChart.setOption(option);
                        commentWordsBox.style.marginLeft = 200 + 'px';

                    }
                });
            }

            //描述长度分布
            function makeDescriptionLength() {
                var descriptionLengthBox = document.getElementById('descriptionLengthBox');
                var valueData = [];
                var nameData =
                    ['0-19 words', '20-39 words', '40-59 words', '60-79 words', '80-99 words', '100-119 words', '120-139 words', '140-159 words', '160-179 words', '180-199 words', '200 words above', '10-49 words',];
                $.ajax({
                    type: 'post',
                    url: '/filmChart/getDescriptionNum.action',
                    data: {
                        imdb_filmID: imdb_filmID,
                        number: 20 + ''
                    },
                    success: function (data) {
                        var seriesData = [];
                        for (var key in data) {
                            valueData.push(data[key]);
                            seriesData.push({value: data[key], name: nameData[key]});
                        }
                        var descriptionLengthChart = echarts.init(descriptionLengthBox);
                        var option = {
                            title: {
                                text: 'Description Length Distribution'
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: "{a} <br/>{b}: {c} ({d}%)"
                            },
                            legend: {
                                left: 'left',
                                top: 'center',
                                orient: 'vertical',
                                data: nameData
                            },
                            series: [
                                {
                                    name: 'Description Length',
                                    type: 'pie',
                                    radius: ['50%', '70%'],
                                    avoidLabelOverlap: false,
                                    label: {
                                        normal: {
                                            show: false,
                                            position: 'center'
                                        },
                                        emphasis: {
                                            show: true,
                                            textStyle: {
                                                fontSize: '24',
                                            }
                                        }
                                    },
                                    labelLine: {
                                        normal: {
                                            show: false
                                        }
                                    },
                                    data: seriesData
                                }
                            ]
                        };
                        descriptionLengthChart.setOption(option);
                        descriptionLengthBox.style.marginLeft = 200 + 'px';
                    }
                });
            }

        </script>

        <!--Write Reviews-->
        <div id="comment" class="product">
            <ul class="cf">
                <li class="ml0">

                    <form id="commentForm" action="" method="post" class="basic-grey">
                    </form>

                </li>
            </ul>
        </div>
        <%--Script for User Review--%>
        <script>
            var commentBox = document.getElementById('commentForm');


            //如果用户未登录则提示登陆
            if ('<%=userAccount.getUserName()%>' === "") {
                commentBox.innerHTML = '<span style="font-size: 20px">Please Sign In First.</span>';
            }

            else {
                //展示添加评论界面
                commentBox.innerHTML = '<h1>Add Your Comment\
                    <span>Please fill all the texts in the fields.</span>\
                    </h1>\
                    <label>\
                    <span>Score :</span>\
                </label>\
                <div id="starBox" style="height: 40px;display: inline-block;padding-top: 8px">\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    <img style="width:18px;" src="../images/star-small-dark.png" />\
                    </div>\
                    <label>\
                    <span>Summary :</span>\
                <input id="commentSummary" type="text" name="user_summary"\
                placeholder="Summary of Your Review"/>\
                    </label>\
                    <label>\
                    <span>Text :</span>\
                <textarea id="commentText" name="text" placeholder="Content of Your Review"></textarea>\
                    </label>\
                    <span>&nbsp;</span>\
                <input id="commitBtn" type="button" class="button" value="Send"/>';
                var commentScore = document.getElementById('commentScore');
                var commentSummary = document.getElementById('commentSummary');
                var commentText = document.getElementById('commentText');
                var commitBtn = document.getElementById('commitBtn');
                commitBtn.style.float = "right";
                commitBtn.style.marginRight = "10%";
                var starBox = document.getElementById('starBox');
                starBox.stars = 0;
                var stars = starBox.getElementsByTagName('img');
                for (var i = 0; i < stars.length; i++) {
                    stars[i].index = i + 1;
                    stars[i].onclick = function () {
                        var j = 0;
                        for (; j < this.index; j++) {
                            stars[j].src = '../images/star-small.png';
                        }
                        for (var k = 0; k < (10 - this.index); k++) {
                            stars[j + k].src = '../images/star-small-dark.png';
                        }
                        starBox.stars = j;
                    }
                }

                //如果有历史评论则展示历史评论
                $.ajax({
                    type: 'post',
                    url: '/user/getPersonalReview.action',
                    contentType: 'application/json',
                    data: '<%=userAccount.getUserID()%>',
                    success: function (data) {
                        if (data === null || data.length === 0) {
                            return false;
                        }

                        var beCommented = false;
                        var thisComment;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].imdb_filmID === imdb_filmID) {
                                beCommented = true;
                                thisComment = data[i];
                            }
                        }
                        if (beCommented) {
                            document.getElementById('userScore').innerHTML = thisComment.score;
                            var stars = '';
                            for (var j = 0; j < thisComment.score; j++) {
                                stars += '<img style="width: 18px" src="../images/star-small.png" />';
                            }
                            for (var j = 0; j < (10 - thisComment.score); j++) {
                                stars += '<img style="width: 18px" src="../images/star-small-dark.png" />';
                            }
                            var reviewDiv = '<form action="" method="post" class="basic-grey">\
                                <h1>History Review\
                                </h1>\
                                <label>\
                                    <span>Score :</span>\
                                </label>\
                                <div id="starBox" style="height: 40px;display: inline-block;padding-top: 8px">\
                                ' + stars + '\
                                </div>\
                                <label>\
                                    <span>Summary :</span>\
                                    <label style="color: black;line-height: 35px">' + thisComment.summary + '</label>\
                                </label>\
                                <label>\
                                    <span>Text :</span>\
                                    <div style="color: black;width: 500px;margin-left: 180px;height: 200px;line-height: 35px;">' + thisComment.text + '</div>\
                                </label>\
                            </form>';
                            commentBox.parentNode.innerHTML = reviewDiv;
                        }
                    }
                });
                commitBtn.addEventListener('click', function (e) {
                    e.stopPropagation();
                    if (starBox.stars === 0) {
                        alert("Score is empty!");
                    }
                    else if (commentSummary.value === '') {
                        alert("Summary is empty!");
                    }
                    else if (commentText.value === '') {
                        alert("Text is empty!");
                    }
                    else {
                        var date = new Date();
                        date = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
                        var review = {
                            reviewID: null,
                            time: date,
                            helpfulness: null,
                            summary: commentSummary.value,
                            text: commentText.value,
                            imdb_filmID: imdb_filmID,
                            userName: '<%=userAccount.getUserName()%>',
                            userCountry: 'China',
                            score: starBox.stars,
                            userInfo_userID: '<%=userAccount.getUserID()%>'
                        };
                        $.ajax({
                            type: 'post',
                            url: '/user/addPersonalReview.action',
                            contentType: 'application/json',
                            data: JSON.stringify(review),
                            success: function (data) {
                                if (data.result === 'success') {
                                    alert('Comment Success!');
                                    window.location.reload(true);
                                }
                                else {
                                    alert('Comment Failed!');
                                }
                            }
                        });
                    }
                });
            }


        </script>
    </div>
</div>

<!--loginBox-->
<jsp:include page="common/loginbox.jsp"></jsp:include>

<script src="../js/search.js"></script>
<script src="../js/details.js"></script>

<!-- footer -->
<jsp:include page="common/footer.jsp"></jsp:include>
</body>
<!-- //Body -->
</html>
