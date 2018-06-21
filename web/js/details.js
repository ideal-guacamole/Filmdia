/**
 * Created by Ferriswheel on 2017/5/17.
 */
var poster = document.getElementById('poster');
var title = document.getElementById('title');
var summary = document.getElementById('summary');
var directors = document.getElementById('directors');
var actors = document.getElementById('actors');
var tags = document.getElementById('tags');
var score = document.getElementById('score');
var country = document.getElementById('country');
var language = document.getElementById('language');
var detail_language = document.getElementById('detail_language');
var detail_onTime = document.getElementById('detail_onTime');
var detail_watchUrl = document.getElementById('detail_watchUrl');
var box_worldGross = document.getElementById('box_worldGross');
var box_gross = document.getElementById('box_gross');
var box_budget = document.getElementById('box_budget');
var storyLine_tagLine = document.getElementById('storyLine_tagLine');
var storyLine_keywords = document.getElementById('storyLine_keywords');
var castBox = document.getElementById('castBox');
var runtime = document.getElementById('runtime');
var castTable = document.getElementById('castTable');
var casttbody = document.getElementById('casttbody ');
var castMap = {};

//core members
var director_pic = document.getElementById('director_pic');
var director_name = document.getElementById('director_name');
var star1_pic = document.getElementById('star1_pic');
var star1_name = document.getElementById('star1_name');
var star2_pic = document.getElementById('star2_pic');
var star2_name = document.getElementById('star2_name');
var star3_pic = document.getElementById('star3_pic');
var star3_name = document.getElementById('star3_name');


var filmID = getQueryString('filmID');
var imdb_filmID = getQueryString('imdb_filmID');
var name = getQueryString('name');
var film = null;
var storyline = document.getElementById('storyline');

//Favorite
var favorite = {
    favoriteID: null,
    filmID: filmID,
    filmName: null,
    score: null,
    category: null,
    userID: null,
    posterURL: null,
    summary: null
};

//split the tags and keywords
function split1(list, obj) {
    var str = '';
    $.each(list, function (i, item) {
        if (i !== list.length - 1) {
            str += item + ' | ';
        }
        else
            str += item;
    });
    obj.innerHTML = str;
}

//split the actors and directors(attached with pic src)
function split2(list, obj) {
    var str = '';
    $.each(list, function (i, item) {
        if (i % 2 == 0) {
            if (i !== list.length - 2) {
                str += item + ' | ';
            }
            else
                str += item;
        }

    });
    obj.innerHTML = str;
}

//core members
//split the actors and directors(attached with pic src)
function split3(list, obj) {
    var str = '';
    $.each(list, function (i, item) {
        if (i % 2 == 0) {
            if (i !== list.length - 2) {
                str += item + ' | ';
            }
            else
                str += item;
        }

    });
    obj.innerHTML = str;
}

if (name == 'null') {
    //加载电影详情(电影库电影)
    $.ajax({
        type: 'post',
        url: '/film/getFilm.action',
        contentType: 'application/json;charset=utf-8',
        data: filmID,
        success: function (data) {
            film = data;
            poster.src = film.posterURL;
            favorite.posterURL = film.posterURL;
            title.innerHTML = film.name;
            favorite.filmName = film.name;
            summary.innerHTML = film.summary;
            favorite.summary = film.summary;
            split2(film.directors, directors);
            split2(film.actors, actors);
            split1(film.tags, tags);
            favorite.category = splitCatForFav(film.tags);
            score.innerHTML = film.score;
            favorite.score = film.score;
            country.innerHTML = film.country;
            language.innerHTML = film.gross === 0 ? 'None' : '$' + film.gross;
            runtime.innerHTML = film.runtime === 0 ? 'None' : film.runtime + 'min';
            detail_language.innerHTML = film.language;
            detail_onTime.innerHTML = film.onTime;
            detail_watchUrl.innerHTML = '<a href="' + film.filmWatchURL + '">Click Here to Watch!</a>';


            box_worldGross.innerHTML = film.worldwideGross === 0 ? 'None' : ' $' + film.worldwideGross;
            box_gross.innerHTML = film.gross === 0 ? 'None' : ' $' + film.gross;
            box_budget.innerHTML = film.budget === 0 ? 'None' : ' $' + film.budget;

            //cast table
            castMap = film.cast;
            //遍历cast这个map
            for (var key in castMap) {
                var rowNum = castTable.rows.length;
                var newRow = castTable.insertRow(rowNum);
                var col1 = newRow.insertCell(0); //pic
                col1.innerHTML = rowNum;
                var col2 = newRow.insertCell(1); //name
                col2.innerHTML = key;
                var col3 = newRow.insertCell(2); //role
                col3.innerHTML = castMap[key];
            }

            //core members
            var directorlist = film.directors;
            var starlist = film.actors;
            director_name.innerHTML = directorlist[0] + '(Dir)';
            director_pic.src = directorlist[1];
            star1_name.innerHTML = starlist[0];
            star1_pic.src = starlist[1];
            star2_name.innerHTML = starlist[2];
            star2_pic.src = starlist[3];
            star3_name.innerHTML = starlist[4];
            star3_pic.src = starlist[5];

            //storyline
            storyLine_tagLine.innerHTML = film.tagLine;
            split1(film.scriptKeyWords, storyLine_keywords);
            storyline.innerHTML = film.storyline;
        }
    });
} else {
    //加载电影详情(首页影院信息电影)
    $.ajax({
        type: 'post',
        url: '/film/getFilmFromUpdate.action',
        contentType: 'application/json;charset=utf-8',
        data: filmID,
        success: function (data) {
            film = data;
            poster.src = film.posterURL;
            favorite.posterURL = film.posterURL;
            title.innerHTML = film.name;
            favorite.filmName = film.name;
            summary.innerHTML = film.summary;
            favorite.summary = film.summary;
            split2(film.directors, directors);
            split2(film.actors, actors);
            split1(film.tags, tags);
            favorite.category = splitCatForFav(film.tags);
            score.innerHTML = film.score;
            favorite.score = film.score;
            country.innerHTML = film.country;
            language.innerHTML = '$' + film.gross;
            runtime.innerHTML = film.runtime + 'min';
            detail_language.innerHTML = film.language;
            detail_onTime.innerHTML = film.onTime;
            detail_watchUrl.innerHTML = '<a href="' + film.filmWatchURL + '">Click Here to Watch!</a>';

            if (film.worldwideGross != 0) {
                box_worldGross.innerHTML = ' $' + film.worldwideGross;
            } else {
                box_worldGross.innerHTML = ' unknown';
            }

            box_gross.innerHTML = ' $' + film.gross;
            box_budget.innerHTML = ' $' + film.budget;

            //cast table
            castMap = film.cast;
            //遍历cast这个map
            var i = 1;
            var add = '';
            for (var key in castMap) {
                // var rowNum = castTable.rows.length;
                // var newRow = castTable.insertRow(rowNum);
                // var col1 = newRow.insertCell(0); //pic
                // col1.innerHTML = rowNum;
                // var col2 = newRow.insertCell(1); //name
                // col2.innerHTML = key;
                // var col3 = newRow.insertCell(2); //role
                // col3.innerHTML = castMap[key];
                add = '<tr>' +
                    '<td>' + i + '</td>' +
                    '<td>' + key + '</td>>' +
                    '<td>' + castMap[key] + '</td>' +
                    '</tr>>';
                casttbody += add
            }

            //core members
            var directorlist = film.directors;
            var starlist = film.actors;
            director_name.innerHTML = directorlist[0] + '(Dir)';
            director_pic.src = directorlist[1];
            star1_name.innerHTML = starlist[0];
            star1_pic.src = starlist[1];
            star2_name.innerHTML = starlist[2];
            star2_pic.src = starlist[3];
            star3_name.innerHTML = starlist[4];
            star3_pic.src = starlist[5];

            //storyline
            storyLine_tagLine.innerHTML = film.tagLine;
            split1(film.scriptKeyWords, storyLine_keywords);
            storyline.innerHTML = film.storyline;
        }
    });
}


//加载评论
var spinner = document.getElementById('spinner');
var reviewBox = document.getElementById('reviewBox');
var review = '';
var reviewNum = 0;
$.ajax({
    type: 'post',
    url: '/review/getReviews.action',
    contentType: 'application/json;charset=utf-8',
    data: imdb_filmID,
    success: function (data) {
        spinner.style.display = 'none';
        spinner.style.visibility = 'hidden';
        review = '';
        reviewNum = data.length;
        putReviews(data);
    }
});

//评论排序
var helpfulness_btn = document.getElementById('helpfulness_btn');
var release_btn = document.getElementById('release_btn');
var order_btn = document.getElementById('order_btn');
var reviewSort = null;
helpfulness_btn.addEventListener('click', function (e) {
    e.preventDefault();
    reviewSort = 'MostHelpful';
    sortReviews();
    release_btn.className = "";
    helpfulness_btn.className = "selected_sort";
});
release_btn.addEventListener('click', function (e) {
    e.preventDefault();
    reviewSort = 'Latest';
    sortReviews();
    release_btn.className = "selected_sort";
    helpfulness_btn.className = "";
});
order_btn.addEventListener('click', function (e) {
   if (reviewSort==='Latest' || reviewSort==='Oldest') {
       if (reviewSort==='Latest') {
           reviewSort = 'Oldest';
           sortReviews();
       } else {
           reviewSort = 'Latest';
           sortReviews();
       }
   } else {
       if (reviewSort==='MostHelpful') {
           reviewSort = 'LeastHelpful';
           sortReviews();
       } else {
           reviewSort = 'MostHelpful';
           sortReviews();
       }
   }
});

function sortReviews() {
    $.ajax({
        type: 'post',
        url: '/review/getSortedReviews.action',
        data: {
            imdb_filmID: imdb_filmID,
            reviewSort: reviewSort,
        },
        success: function (data) {
            spinner.style.display = 'none';
            spinner.style.visibility = 'hidden';
            reviewBox.innerHTML = '';
            review = '';
            putReviews(data);
            reviewNum = data.length;
            console.log(data);
        }
    });
}
function putReviews(data) {
    var num = 0;
    var star = '<img style="width: 17px" src="../images/star-small.png" />';
    var star_dark = '<img style="width: 17px" src="../images/star-small-dark.png" />';
    console.log(reviewNum);
    for (var i = num; i < num + 10; i++) {
        if (i===reviewNum){
            break;
        }
        var filmStar = '';
        var j = 0;
        for (; j < data[i].score; j++) {
            filmStar += star;
        }
        while (j < 10) {
            filmStar += star_dark;
            j++;
        }
        var helpfulnessArray = data[i].helpfulness.split("/");
        var like = helpfulnessArray[0].replace(/,/g, "");
        var dislike = helpfulnessArray[1].replace(/,/g, "") - like;
        var fullContentText = data[i].text;
        var smallContentText;
        if (fullContentText.length > 700) {
            smallContentText = data[i].text.substr(0, 700) + '... ';

            review += '' +
                '<div class="review_part">\n' +
                '  <div class="review_title">\n' +
                '    <span class="review_userName">' + data[i].userName + '</span>\n' +
                '    <span class="review_time">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + data[i].time + '</span>   \n' +
                '    <div style="display:inline-block;position:absolute;top:13px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + filmStar + '</div>\n' +
                '  </div>\n' +
                '  <span class="review_summary">' + data[i].summary + '</span>\n' +
                '  <div class="review_text" id="smallContent' + i + '" style="display:block">' + smallContentText + '(\n' +
                '    <a href="javascript:" style="font-weight: bold" onclick="expend(' + i + ')" >unfold</a> )\n' +
                '  </div>\n' +
                '  <div class="review_text" id="fullContent' + i + '" style="display:none">' + fullContentText + '(\n' +
                '    <a href="javascript:" style="font-weight: bold" onclick="expend(' + i + ')" >fold</a> )\n' +
                '  </div>\n' +
                '  <div class="review_footer">&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                '    <span class="glyphicon glyphicon-thumbs-up" style="color: green; margin-right: 5px"></span>   \n' +
                '    <span style="font-size: 11px; color:#737373">' + like + '</span>&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                '    <span class="glyphicon glyphicon-thumbs-down" style="margin-left: 10px; margin-right: 5px"></span>\n' +
                '    <span style="font-size: 11px; color:#737373">' + dislike + '</span>\n' +
                '  </div>  \n' +
                '</div>';
        } else {
            smallContentText = fullContentText;

            review += '' +
                '<div class="review_part">\n' +
                '  <div class="review_title">\n' +
                '    <span class="review_userName">' + data[i].userName + '</span>\n' +
                '    <span class="review_time">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + data[i].time + '</span>   \n' +
                '    <div style="display:inline-block;position:absolute;top:13px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + filmStar + '</div>\n' +
                '  </div>\n' +
                '  <span class="review_summary">' + data[i].summary + '</span>\n' +
                '  <div class="review_text" id="smallContent' + i + '" style="display:block">' + smallContentText + '\n' +
                '  </div>\n' +
                '  <div class="review_text" id="fullContent' + i + '" style="display:none">' + fullContentText + '\n' +
                '  </div>\n' +
                '  <div class="review_footer">&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                '    <span class="glyphicon glyphicon-thumbs-up" style="color: green; margin-right: 5px"></span>   \n' +
                '    <span style="font-size: 11px; color:#737373">' + like + '</span>&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                '    <span class="glyphicon glyphicon-thumbs-down" style="margin-left: 10px; margin-right: 5px"></span>\n' +
                '    <span style="font-size: 11px; color: #737373">' + dislike + '</span>\n' +
                '  </div>  \n' +
                '</div>';
        }

    }
    num += 10;
    reviewBox.innerHTML += review;

    var lock = false;
    var finish = false;
    reviewBox.parentNode.parentNode.parentNode.onscroll = function () {
        var oScroll = this.scrollTop;
        if (finish) {
            return;
        }
        if (!lock && reviewBox.offsetHeight - oScroll < 1300) {
            lock = true;
            review = '';
            for (var i = num; i < num + 10; i++) {
                if (i === data.length) {
                    finish = true;
                    break;
                }
                var filmStar = '';
                for (var j = 0; j < data[i].score; j++) {
                    filmStar += star;
                }

                var helpfulnessArray = data[i].helpfulness.split("/");
                var like = helpfulnessArray[0];
                var dislike = helpfulnessArray[1] - helpfulnessArray[0];
                var fullContentText = data[i].text;
                var smallContentText;
                if (fullContentText.length > 700) {
                    smallContentText = data[i].text.substr(0, 700) + '... ';

                    review += '' +
                        '<div class="review_part">\n' +
                        '  <div class="review_title">\n' +
                        '    <span class="review_userName">' + data[i].userName + '</span>\n' +
                        '    <span class="review_time">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + data[i].time + '</span>   \n' +
                        '    <div style="display:inline-block;position:absolute;top:9px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + filmStar + '</div>\n' +
                        '  </div>\n' +
                        '  <span class="review_summary">' + data[i].summary + '</span>\n' +
                        '  <div class="review_text" id="smallContent' + i + '" style="display:block">' + smallContentText + '(\n' +
                        '    <a href="javascript:" style="font-weight: bold" onclick="expend(' + i + ')" >unfold</a> )\n' +
                        '  </div>\n' +
                        '  <div class="review_text" id="fullContent' + i + '" style="display:none">' + fullContentText + '(\n' +
                        '    <a href="javascript:" style="font-weight: bold" onclick="expend(' + i + ')" >fold</a> )\n' +
                        '  </div>\n' +
                        '  <div class="review_footer">&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                        '    <span class="glyphicon glyphicon-thumbs-up" style="color: green; margin-right: 5px"></span>   \n' +
                        '    <span>' + like + '</span>&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                        '    <span class="glyphicon glyphicon-thumbs-down" style="margin-left: 10px; margin-right: 5px"></span>\n' +
                        '    <span>' + dislike + '</span>\n' +
                        '  </div>  \n' +
                        '</div>';
                } else {
                    smallContentText = fullContentText;

                    review += '' +
                        '<div class="review_part">\n' +
                        '  <div class="review_title">\n' +
                        '    <span class="review_userName">' + data[i].userName + '</span>\n' +
                        '    <span class="review_time">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + data[i].time + '</span>   \n' +
                        '    <div style="display:inline-block;position:absolute;top:9px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' + filmStar + '</div>\n' +
                        '  </div>\n' +
                        '  <span class="review_summary">' + data[i].summary + '</span>\n' +
                        '  <div class="review_text" id="smallContent' + i + '" style="display:block">' + smallContentText + '\n' +
                        '  </div>\n' +
                        '  <div class="review_text" id="fullContent' + i + '" style="display:none">' + fullContentText + '\n' +
                        '  </div>\n' +
                        '  <div class="review_footer">&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                        '    <span class="glyphicon glyphicon-thumbs-up" style="color: green; margin-right: 5px"></span>   \n' +
                        '    <span>' + like + '</span>&nbsp;&nbsp;&nbsp;&nbsp;\n' +
                        '    <span class="glyphicon glyphicon-thumbs-down" style="margin-left: 10px; margin-right: 5px"></span>\n' +
                        '    <span>' + dislike + '</span>\n' +
                        '  </div>  \n' +
                        '</div>';
                }
            }
            num += 10;
            reviewBox.innerHTML += review;
            lock = false;
        }
    }
}

function expend(i) {
    var fullContent = document.getElementById('fullContent' + i);
    var smallContent = document.getElementById('smallContent' + i);

    fullContent.style.display = (fullContent.style.display === 'none') ? '' : 'none';
    smallContent.style.display = (smallContent.style.display === 'none') ? '' : 'none';
}

//Category
function splitCatForFav(list) {
    var str = '';
    $.each(list, function (i, item) {
        if (i !== list.length - 1) {
            str += item + '/';
        }
        else
            str += item;
    });
    return str;
}

//添加到用户的已收藏
var add_fav = document.getElementById('add_fav');

function addFav(userid) {
    if (userid == 0) {
        alert('Please sign in first.');
        return;
    }
    favorite.userID = userid;
    $.ajax({
        type: 'post',
        url: '/user/addFavorite.action',
        contentType: 'application/json;charset=utf-8',
        data: JSON.stringify(favorite),
        success: function (data) {
            if (data.result === 'success') {
                alert('Successfully added!\nYou can check it in User Center.');
                add_fav.setAttribute("disabled", "true");
                add_fav.innerHTML = "Added to Favorite";
            } else {
                alert('You have already added it!');
            }

        }
    });
}

function getFilm() {
    return film;
}

function getReviewNum() {
    return reviewNum;
}

