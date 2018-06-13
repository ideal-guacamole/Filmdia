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