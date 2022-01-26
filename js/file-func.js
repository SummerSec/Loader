// 此方案无法直接在谷歌浏览器上使用 需要设置跨域请求头，或更改协议
function fileReader(src) {
    /* 原生ajax */
    var xmlhttp;
    // 1，建立xmlHttpRequest对象
    if(window.XMLHttpRequest){
        xmlhttp = new XMLHttpRequest();
    }
    else{
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    // 2，设置回调函数
    xmlhttp.onreadystatechange=callback;
    // 3，使用open方法与服务器建立连接
    xmlhttp.open("GET",src);
    // 4，向服务器端发送数据
    xmlhttp.send();
    // 5，在回调函数中针对不同呃响应状态进行处理
    function callback(){
        //访问本地文件时status = 0
        if(xmlhttp.readyState === 4 && xmlhttp.status === 200 || xmlhttp.status === 0){
            //注意： onreadystatechange 事件被触发 4 次（0 - 4）, 分别是： 0-1、1-2、2-3、3-4，对应着 readyState 的每个变化。
            console.log("原生",xmlhttp.responseText);
        }
    }

    /*  jquery的ajax版本要求文件内容格式位json/jsonp */
    $.ajax({
        url: src,
        type: "GET",
        dataType: "jsonp",
        jsonpCallback: "foo",
        jsonp: 'foo',
        success: (res) => {
            console.log("jquery",res);
        }
    })
}



/* jsonp方案 */
async   function addScriptTag(src) {
    var script = document.createElement('script');
    script.setAttribute("type","text/javascript");
    script.src = src;
    document.body.appendChild(script);
}

async   function foo(data) {
    console.log("======"+JSON.stringify(data));
}


// window.onload = function () {
//     fileReader("./js/txt/data.txt");
//     addScriptTag('./js/txt/data.txt?callback=foo');
// }
