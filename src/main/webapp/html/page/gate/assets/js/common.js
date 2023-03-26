
var Frame = window.location.search.substring(1);
if (Frame == "tv") {
    $('html').addClass('frame');
} else if (Frame == "forest"){
    $('html').addClass('frame forest');
}

window.addEventListener("keydown", e => {

    if(e.key == "Home") {
        window.location.href='index.html?'+Frame;
    } else if (e.key == "1") {
        window.location.href='eroum.html?'+Frame;
    } else if (e.key == "2") {
        window.location.href='market.html?'+Frame;
    } else if (e.key == "3") {
        window.location.href='partners.html?'+Frame;
    } else if (e.key == "s") {
        window.location.href='market.html?s';
    }
});
